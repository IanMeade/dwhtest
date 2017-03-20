SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 13/2/2017 
-- Description:	OOP / Official Opening Price from TxSAFT files 
-- ============================================= 
CREATE FUNCTION [dbo].[udfTxSaftOop] 
(	 
	@TradeDate DATE 
) 
RETURNS TABLE  
AS 
RETURN  
( 
	SELECT 
		T.A_ISIN, 
		MAX(A_OFFICIAL_OPENING_PRICE) AS A_OFFICIAL_OPENING_PRICE, 
		COUNT(DISTINCT A_OFFICIAL_OPENING_PRICE) AS PriceVersions 
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
		/* NOT A DELAYED TRADE */ 
		T.A_DEFERRED_IND != 'Y' 
	AND 
		/* NOT CANCELED */ 
		T.A_MOD_REASON_CODE != '003' 
	GROUP BY 
		T.A_ISIN 
	HAVING 
		MAX(A_OFFICIAL_OPENING_PRICE) IS NOT NULL 
 
 
) 
 
GO
