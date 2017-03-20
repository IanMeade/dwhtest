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

	DELETE
		dbo.XtOdsInstrumentEquityEtfUpdate 
	WHERE
		ISIN IS NULL


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
			'XT Comapnmy found with invalid Company Status. Instrument has not been processed. GID: ' + CompanyGlobalID + '  Status: ' + CompanyStatusName AS Message
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

	DELETE
		dbo.XtOdsInstrumentEquityEtfUpdate 
	WHERE
		QuotationCurrencyISOCode NOT IN (
				SELECT
					CurrencyISOCode
				FROM
					DwhDimCurrency
			)


	/* RETURN ALL ERROR MESSAGES */
	SELECT 
		Code,
		Message
	FROM
		@Messages



END
GO
