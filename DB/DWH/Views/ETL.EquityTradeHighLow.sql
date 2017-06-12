SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 
 
  
  
  
CREATE VIEW [ETL].[EquityTradeHighLow] AS  
		SELECT  
			I.ISIN,  
			T.TradeDateID,  
			COUNT(*) CNT,  
			MIN(T.TradePrice) AS LowPrice,  
			MAX(T.TradePrice) AS HighPrice  
		FROM  
				ETL.AggregationDateList D 
			LEFT OUTER JOIN   
				DWH.FactEquityTrade T  
			ON D.AggregateDateID = T.TradeDateID 
			INNER JOIN  
				DWH.DimInstrumentEquity I  
			ON T.InstrumentID = I.InstrumentID  
		WHERE  
			T.TradeCancelled = 'N'
		GROUP BY  
			I.ISIN,  
			T.TradeDateID  


GO
