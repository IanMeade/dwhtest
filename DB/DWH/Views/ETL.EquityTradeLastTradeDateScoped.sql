SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [ETL].[EquityTradeLastTradeDateScoped] AS   
	/* NO LOOCAL TIMES ETC.. */  
	/* NO DELAYED TRADE ACCOMODATED */  
		SELECT  
			LastTrade.AggregateDateID,   
			LastTrade.InstrumentGlobalID,  
			T.TradeDateID,  
			T.TradeTimeID,  
			T.TradeTimestamp,  
			T.UTCTradeTimeStamp,  
			MAX(T.TradePrice) AS TradePrice  
		FROM  
				DWH.FactEquityTrade T  
			INNER JOIN  
				DWH.DimInstrumentEquity Equity  
			ON T.InstrumentID = Equity.InstrumentID  
			INNER JOIN  
				ETL.AggregationDateList D
			ON   
				T.TradeDateID = D.AggregateDateID  
			INNER JOIN  
				DWH.DimTradeModificationType MOD  
			ON T.TradeModificationTypeID = MOD.TradeModificationTypeID  
			AND MOD.TradeModificationTypeName <> 'CANCEL'  
			INNER JOIN  
			(  
				SELECT  
					D.AggregateDateID,   
					Equity.InstrumentGlobalID,   
					MAX(TradeTimestamp) AS TradeTimestamp,  
					COUNT(*) CNT,  
					MIN(TradeTimestamp) AS T1  
				FROM  
						DWH.FactEquityTrade T  
					INNER JOIN  
						DWH.DimInstrumentEquity Equity  
					ON T.InstrumentID = Equity.InstrumentID  
					INNER JOIN  
						ETL.AggregationDateList D
					ON   
						T.TradeDateID = D.AggregateDateID  
					INNER JOIN  
						DWH.DimTradeModificationType MOD  
					ON T.TradeModificationTypeID = MOD.TradeModificationTypeID  
					AND MOD.TradeModificationTypeName <> 'CANCEL'  
				WHERE  
					T.DelayedTradeYN = 'N'  
				GROUP BY  
					D.AggregateDateID,   
					Equity.InstrumentGlobalID
			) AS LastTrade  
			ON  
				T.TradeDateID = LastTrade.AggregateDateID  
			AND  
				Equity.InstrumentGlobalID = LastTrade.InstrumentGlobalID
			AND  
				T.TradeTimestamp = LastTrade.TradeTimestamp  
		WHERE  
			T.DelayedTradeYN = 'N'  
		GROUP BY  
			LastTrade.AggregateDateID,   
			LastTrade.InstrumentGlobalID,  
			T.TradeDateID,  
			T.TradeTimeID,  
			T.TradeTimestamp,  
			T.UTCTradeTimeStamp  
  
  
  
  
 
 
 


GO
