SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

  
  
  
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 4/4/2016  
-- Description:	Validate XT early arriving fatcs - look for reference details that have not been defined nad will be added by later stages
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateFindEarlyArrivingFacts]
AS  
BEGIN  
	SET NOCOUNT ON;  
  
	/* MAKE SURE QUERY MATCHES THE QUERY USED TO ADD INFERRED CURRENCIES INTO THE DWH */

	SELECT
		864 AS Code,
		Message = 'Currency found in XT ODS that is not in the DWH Currency table. Currency [' + LEFT(Currency,3) + '] has been added to the dimension' 
	FROM
		(
			SELECT
				DenominationCurrency AS Currency
			FROM
				BestCompany
			WHERE
				DenominationCurrency IS NOT NULL
			UNION
			SELECT
				QuotationCurrency AS Currency
			FROM
				BestCompany
			WHERE
				DenominationCurrency IS NOT NULL
			UNION
			SELECT
				DenominationCurrency AS Currency
			FROM
				BestShare
			WHERE
				DenominationCurrency IS NOT NULL
			UNION
			SELECT
				QuotationCurrency AS Currency
			FROM
				BestShare
			WHERE
				QuotationCurrency IS NOT NULL
		) AS X
	WHERE
		Currency NOT IN (
				SELECT
					CurrencyISOCode
				FROM
					dbo.DwhDimCurrency
			)

END  
  


GO
