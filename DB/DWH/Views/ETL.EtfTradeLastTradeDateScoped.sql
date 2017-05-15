SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ETL].[EtfTradeLastTradeDateScoped] AS   
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
				DWH.FactEtfTrade T  
			INNER JOIN  
				DWH.DimInstrumentEtf ETF  
			ON T.InstrumentID = Etf.InstrumentID  
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
					ETF.InstrumentGlobalID,   
					MAX(TradeTimestamp) AS TradeTimestamp,  
					COUNT(*) CNT,  
					MIN(TradeTimestamp) AS T1  
				FROM  
						DWH.FactEtfTrade T  
					INNER JOIN  
						DWH.DimInstrumentEtf ETF  
					ON T.InstrumentID = ETF.InstrumentID  
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
					ETF.InstrumentGlobalID
			) AS LastTrade  
			ON  
				T.TradeDateID = LastTrade.AggregateDateID  
			AND  
				ETF.InstrumentGlobalID = LastTrade.InstrumentGlobalID
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
