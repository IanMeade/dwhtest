SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 19/4/2017 
-- Description:	XT Interface validation - warning when optional fields are not populated and are fixed by ETL - instruments are still allowed progress
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateXtInterfacedWarningPlusFix] 
AS 
BEGIN 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	/* Simple XT Interface warnings - Return warning - and apples fix */
	SELECT
		591 AS Code,
		'WARNING: XT Instrument found with invalid QuotationCurrencyISOCode. Value has been set to UNKNONW and Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message 
	FROM
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE
		QuotationCurrencyISOCode NOT IN
					(
						SELECT
							CurrencyISOCode
						FROM
							DwhDimCurrency
					)

	/* FIX CURRENCY / FORCE TO UNKNOWN */
	UPDATE
		dbo.XtOdsInstrumentEquityEtfUpdate  
	SET
		QuotationCurrencyISOCode = 'UNK'
	WHERE
		QuotationCurrencyISOCode NOT IN
					(
						SELECT
							CurrencyISOCode
						FROM
							DwhDimCurrency
					)

		
 
END 


GO
