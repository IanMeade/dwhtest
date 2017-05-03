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
  
	/* SSILENTLY REMOVE EMPTY InstrumentGlobalID - SHOULD NOT BE POSSIBLE */
	DELETE
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE  
		ISNULL(InstrumentGlobalID, '') = ''

	/* Result tables - empty table means no invalid rows found */  
	DECLARE @Messages TABLE ( Code INT, Message VARCHAR(2000), InstrumentGlobalID VARCHAR(30) )  
  
	/* Find invalid instruments */

	INSERT INTO 
			@Messages
		SELECT  
			551 As Code,  
			'XT Instrument found with no InstrumentName. Instrument has not been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			ISNULL(InstrumentName,'') = ''
		UNION
		SELECT  
			552 As Code,  
			'XT Instrument found with no ISIN. Instrument has not been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			ISNULL(ISIN,'') = ''
		UNION
		SELECT  
			553 As Code,  
			'XT Instrument found with no Issuer Name. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			ISNULL(IssuerName,'') = '' 
		UNION
		SELECT  
			554 As Code,  
			'XT Instrument found with no Issuer GID. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			ISNULL(IssuerGlobalID,'') = ''
		UNION
		SELECT  
			555 As Code,  
			'XT Instrument found with no Company GID. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			ISNULL(CompanyGlobalID,'') = '' 
		UNION
		SELECT  
			556 As Code,  
			'XT Instrument found with missing Market. Verify MDM Market Table has correct XtCode entry. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			ISNULL(MarketName,'') = ''
		UNION
		SELECT  
			557 As Code,  
			'XT Instrument found with invalid Market. Verify MDM Market Table has correct XtCode entry. Instrument has not been processed. GID: ' + InstrumentGlobalID + ' Maket: ' + MarketName  AS Message,
			InstrumentGlobalID
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
		UNION
		SELECT  
			558 As Code,  
			'XT Instrument found with missing InstrumentStatusName. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			ISNULL(InstrumentStatusName,'') = ''
		UNION
		SELECT  
			559 As Code,  
			'XT Instrument found with invalid InstrumentStatusName - not all status names are valid for Equity. Instrument has not been processed. GID: ' + InstrumentGlobalID + ' InstrumentStatusName: ' + InstrumentStatusName AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			InstrumentStatusName NOT IN (
						SELECT
							StatusName
						FROM
							dbo.MdmStatus
						WHERE
							ValidForEquity = 'Y'
					)
		UNION
		SELECT  
			560 As Code,  
			'XT Instrument found with missing InstrumentStatusDate. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			InstrumentStatusDate IS NULL
		UNION
		SELECT  
			561 As Code,  
			'XT Instrument found with missing InstrumentListedDate. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			InstrumentListedDate IS NULL
		UNION
		/* DISABLED FOR NOW - PROBABLY POPULATED IN EQ2 / CORPORATE ACTIONS */
		/*
		SELECT  
			562 As Code,  
			'XT Instrument found with missing IssuedDate. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			IssuedDate IS NULL
		UNION
		*/
		SELECT  
			563 As Code,  
			'XT Instrument found without Currency. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			ISNULL(CurrencyISOCode,'') = ''
		UNION
		SELECT  
			564 As Code,  
			'XT Instrument found with invalid Currency. Instrument has not been processed. GID: ' + InstrumentGlobalID + 'Currency: ' + CurrencyISOCode AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			CurrencyISOCode NOT IN (
							SELECT
								CurrencyISOCode
							FROM
								dbo.DwhDimCurrency
					)
		UNION
		/* DISABLED FOR NOW - PROBABLY POPULATED IN EQ2 / CORPORATE ACTIONS */
		/*
		SELECT  
			565 As Code,  
			'XT Instrument found with missing TotalSharesInIssue. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			TotalSharesInIssue IS NULL
		UNION
		*/
		SELECT  
			566 As Code,  
			'XT Instrument found with missing CompanyStatusName. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			ISNULL(CompanyStatusName,'') = ''
		UNION
		SELECT  
			567 As Code,  
			'XT Instrument found with invalid CompanyStatusName. Instrument has not been processed. GID: ' + InstrumentGlobalID + ' CompanyStatusName: ' + CompanyStatusName AS Message,
			InstrumentGlobalID
		FROM  
			dbo.XtOdsInstrumentEquityEtfUpdate   
		WHERE  
			CompanyStatusName NOT IN (
						SELECT
							StatusName
						FROM
							dbo.MdmStatus
					)

	/*  Delete invalid instruments */
	DELETE
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE
		InstrumentGlobalID IN (
				SELECT 
					InstrumentGlobalID
				FROM 
					@Messages  
				)
	  
	/* RETURN ALL ERROR MESSAGES */  
	SELECT   
		Code,  
		Message  
	FROM  
		@Messages  
  
    
END  

GO
