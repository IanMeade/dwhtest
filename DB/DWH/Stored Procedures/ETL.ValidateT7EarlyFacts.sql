SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================  
-- Author:		Ian Meade  
-- Create date: 8/3/2017  
-- Description: Validate T7TradeMainDataFlowOutput - warnigns about inferred entries in DWH dimensions - warning only
-- =============================================  
CREATE PROCEDURE [ETL].[ValidateT7EarlyFacts]
AS  
BEGIN  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
	
	SELECT
		27 AS Code,
		'Early arriving facts found in Equity Junk Dimension - review MDM for dimension row [' + STR(EquityTradeJunkID) + ']' AS Message
	FROM
		DWH.DimEquityTradeJunk
	WHERE
		Inferred = 'Y'

  
END  
 


GO
