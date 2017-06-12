SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 
 
 
  
CREATE VIEW [ETL].[EtfTradeHighLow] AS   
		SELECT   
			I.InstrumentGlobalID,   
			T.TradeDateID,   
			COUNT(*) CNT,   
			MIN(T.TradePrice) AS LowPrice,   
			MAX(T.TradePrice) AS HighPrice   
		FROM   
				ETL.AggregationDateList D 
			LEFT OUTER JOIN   
				DWH.FactEtfTrade T   
			ON D.AggregateDateID = T.TradeDateID 
			INNER JOIN   
				DWH.DimInstrumentEtf I   
			ON T.InstrumentID = I.InstrumentID   
			INNER JOIN   
				DWH.DimTradeModificationType TM   
			ON T.TradeModificationTypeID = TM.TradeModificationTypeID   
		WHERE   
			T.TradeCancelled = 'N'
		GROUP BY   
			I.InstrumentGlobalID,   
			T.TradeDateID   
   
   
  
 
 
 

GO
