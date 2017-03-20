SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 13/2/2017 
-- Description:	OCP / Official CLosing Price from TxSAFT files 
-- ============================================= 
CREATE FUNCTION [dbo].[udfTxSaftOcp] 
(	 
	@TradeDate DATE 
) 
RETURNS TABLE  
AS 
RETURN  
( 
	SELECT 
		T.A_ISIN, 
		MAX(A_OFFICIAL_CLOSING_PRICE) AS A_OFFICIAL_CLOSING_PRICE, 
		MAX(A_TRADE_TIME_OCP) AS A_TRADE_TIME_OCP, 
		MAX(A_TRADE_TIME_OCP_GMT) AS A_TRADE_TIME_OCP_GMT, 
		COUNT(DISTINCT A_OFFICIAL_CLOSING_PRICE) AS PriceVersions, 
		COUNT(DISTINCT A_TRADE_TIME_OCP) AS TimeVersions 
	FROM 
			dbo.[File] F 
		INNER JOIN 
			dbo.TxSaft T 
		ON F.DwhFileID = T.DwhFileID  
	WHERE 
		T.A_TRADE_DATE = @TradeDate 
	AND 
		F.FileTag = 'TxSaft' 
	AND 
		F.ContainsEndOfDayDetailsYN = 'Y'
	AND 
		/* NOT A DELAYED TRADE */ 
		A_DEFERRED_IND != 'Y' 
	AND 
		/* NOT CANCELED */ 
		A_MOD_REASON_CODE != '003' 
	GROUP BY 
		T.A_ISIN 
--	HAVING 
	--	MAX(A_OFFICIAL_CLOSING_PRICE) IS NOT NULL 
 
 
) 
GO
