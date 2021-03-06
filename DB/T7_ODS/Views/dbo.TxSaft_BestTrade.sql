SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[TxSaft_BestTrade] AS   
	/*    
		MOST RECENT COPY OF A TRADE   
		TRADES ARE SENT SEVERAL TIMES DURING THE DAY   
		THIS VIEW GETS THE MOST RECENT VERSION OF A TRADE IN THE TABLE   
	*/    
	SELECT   
		A_TRADE_DATE,   
		A_TRADE_LINK_NO,   
		A_ISIN, 
		A_TRADE_TYPE, 
		A_BUY_SELL_FLAG,   
		MAX(A_MOD_REASON_CODE) AS A_MOD_REASON_CODE,  
		COUNT(*) AS CNT,   
		MAX(TxSfaftID) AS TxSfaftID   
	FROM   
			dbo.TxSaft T
		INNER JOIN
			dbo.FileList FL
		ON T.DwhFileID = FL.DwhFileID
	WHERE
			FL.DwhStatus NOT IN ( 'COMPLETE', 'REJECT' )   
		AND
			FL.ProcessFileYN = 'Y'
	GROUP BY   
		A_TRADE_DATE,   
		A_TRADE_LINK_NO,   
		A_ISIN, 
		A_TRADE_TYPE, 
		A_BUY_SELL_FLAG
   
 


GO
