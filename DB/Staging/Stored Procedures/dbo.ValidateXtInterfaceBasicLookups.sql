SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 7/3/2017 
-- Description:	Basic XT Interface validation - misc lookups - bad data is removed from staging table 
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateXtInterfaceBasicLookups] 
AS 
BEGIN 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	/* Simple XT Interface validation checks */ 
 
	/* Result tables - empty table means no invalid rows found */ 
	DECLARE @Messages TABLE ( Code INT, Message VARCHAR(1000) ) 
 
	/* Instruments with no ISIN */ 
	INSERT INTO  
			@Messages  
		( 
			Code,  
			Message  
		) 
		SELECT 
			123 As Code, 
			'XT Instrument found with no ISIN. Instrument has not been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message 
		FROM 
			dbo.XtOdsInstrumentEquityEtfUpdate  
		WHERE 
			ISIN IS NULL 
		OR
			LEN(LTRIM(ISIN)) = 0
 
	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		ISIN IS NULL 
 
 	/* Instruments with no Company gid */ 
	INSERT INTO  
			@Messages  
		( 
			Code,  
			Message  
		) 
		SELECT 
			128 As Code, 
			'XT Instrument found with no Company GID. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message 
		FROM 
			dbo.XtOdsInstrumentEquityEtfUpdate  
		WHERE 
			CompanyGlobalID IS NULL
		OR
			CompanyGlobalID = ''

	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		CompanyGlobalID IS NULL
	OR
		CompanyGlobalID = ''

 
	/* Instruments with no Company Approval */ 
	INSERT INTO  
			@Messages  
		( 
			Code,  
			Message  
		) 
		SELECT 
			124 As Code, 
			'XT Instrument found with no Company Approval. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message 
		FROM 
			dbo.XtOdsInstrumentEquityEtfUpdate  
		WHERE 
			CompanyApprovalType IS NULL 
 
	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		CompanyApprovalType IS NULL 
 
  
	/* Instruments with no Issuer GID */ 
	INSERT INTO  
			@Messages  
		( 
			Code,  
			Message  
		) 
		SELECT 
			124 As Code, 
			'XT Instrument found with no Issuer GID. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message 
		FROM 
			dbo.XtOdsInstrumentEquityEtfUpdate  
		WHERE 
			IssuerGlobalID IS NULL
		OR
			IssuerGlobalID = ''
 
	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		IssuerGlobalID IS NULL
	OR
		IssuerGlobalID = ''


	/* Instruments with no Issuer Name  */ 
	INSERT INTO  
			@Messages  
		( 
			Code,  
			Message  
		) 
		SELECT 
			124 As Code, 
			'XT Instrument found with no Issuer Name. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message 
		FROM 
			dbo.XtOdsInstrumentEquityEtfUpdate  
		WHERE 
			IssuerName IS NULL
		OR
			IssuerName = ''
 
	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		IssuerName IS NULL
	OR
		IssuerName = ''


	/* Instruments with invalid status */ 
	INSERT INTO  
			@Messages  
		( 
			Code,  
			Message  
		) 
		SELECT 
			125 As Code, 
			'XT Instrument found with invalid Instrument Status. Instrument has not been processed. GID: ' + InstrumentGlobalID + '  Status: ' + InstrumentStatusName AS Message 
		FROM 
			dbo.XtOdsInstrumentEquityEtfUpdate  
		WHERE 
			InstrumentStatusName NOT IN ( 
					SELECT 
						StatusName 
					FROM 
						DwhDimStatus 
				) 
	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		InstrumentStatusName NOT IN ( 
				SELECT 
					StatusName 
				FROM 
					DwhDimStatus 
			) 
 
	/* Companies with invalid Status */ 
	INSERT INTO  
			@Messages  
		( 
			Code,  
			Message  
		) 
		SELECT 
			125 As Code, 
			'XT Company found with invalid Company Status. Instrument has not been processed. GID: ' + CompanyGlobalID + '  Status: ' + CompanyStatusName AS Message 
		FROM 
			dbo.XtOdsInstrumentEquityEtfUpdate  
		WHERE 
			CompanyStatusName NOT IN ( 
					SELECT 
						StatusName 
					FROM 
						DwhDimStatus 
				) 
	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		CompanyStatusName NOT IN ( 
				SELECT 
					StatusName 
				FROM 
					DwhDimStatus 
			) 
 
	/* Instruments with invalid currency */ 
	INSERT INTO  
			@Messages  
		( 
			Code,  
			Message  
		) 
		SELECT 
			126 As Code, 
			'XT Instrument found with invalid Currency. Instrument has not been processed. GID: ' + InstrumentGlobalID + ' Currency: ' + CurrencyISOCode AS Message 
		FROM 
			dbo.XtOdsInstrumentEquityEtfUpdate  
		WHERE 
			CurrencyISOCode NOT IN ( 
					SELECT 
						CurrencyISOCode 
					FROM 
						DwhDimCurrency 
				) 
 
	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		CurrencyISOCode NOT IN ( 
				SELECT 
					CurrencyISOCode 
				FROM 
					DwhDimCurrency 
			) 
 
	/* Instruments with invalid currency */ 
	INSERT INTO  
			@Messages  
		( 
			Code,  
			Message  
		) 
		SELECT 
			126 As Code, 
			'XT Instrument found with invalid Quotation Currency. Instrument has not been processed. GID: ' + InstrumentGlobalID + ' Currency: ' + QuotationCurrencyISOCode AS Message 
		FROM 
			dbo.XtOdsInstrumentEquityEtfUpdate  
		WHERE 
			QuotationCurrencyISOCode NOT IN ( 
					SELECT 
						CurrencyISOCode 
					FROM 
						DwhDimCurrency 
				) 

 
	/* Instruments with invalid currency */ 
	INSERT INTO  
			@Messages  
		( 
			Code,  
			Message  
		) 
		SELECT 
			126 As Code, 
			'XT Instrument found with invalid Market. Verify MDM Market Table has correct XtCode entry. Instrument has not been processed. GID: ' + InstrumentGlobalID + ' Maket: ' + MarketName  AS Message 
		FROM 
			dbo.XtOdsInstrumentEquityEtfUpdate  
		WHERE 
			MarketName NOT IN ( 
					SELECT 
						XtCode
					FROM
						dbo.MdmMarket
					WHERE
						XtCode IS NOT NULL
				) 
 

	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		MarketName NOT IN ( 
					SELECT 
						XtCode
					FROM
						dbo.MdmMarket
					WHERE
						XtCode IS NOT NULL
			) 
 
 
 
	/* RETURN ALL ERROR MESSAGES */ 
	SELECT  
		Code, 
		Message 
	FROM 
		@Messages 
 
 
 
END 
GO
