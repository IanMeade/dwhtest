SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



 
 
 
 
CREATE VIEW [ETL].[EtfTradeLastTradeDateScoped] AS  
	/* NO LOOCAL TIMES ETC.. */ 
	/* NO DELAYED TRADE ACCOMODATED */ 
		SELECT 
			LastTrade.AggregateDateID,  
			LastTrade.ISIN, 
			T.TradeDateID, 
			T.TradeTimeID, 
			T.TradeTimestamp, 
			T.UTCTradeTimeStamp, 
			MAX(T.TradePrice) AS TradePrice 
		FROM 
				DWH.FactEtfTrade T 
			INNER JOIN 
				DWH.DimInstrumentEtf Etf 
			ON T.InstrumentID = Etf.InstrumentID 
			INNER JOIN 
				ETL.ActiveInstrumentsDates AID 
			ON  
				Etf.ISIN = AID.ISIN 
			AND 
				T.TradeDateID = AID.AggregateDateID 
			INNER JOIN 
				DWH.DimTradeModificationType MOD 
			ON T.TradeModificationTypeID = MOD.TradeModificationTypeID 
			AND MOD.TradeModificationTypeName <> 'CANCEL' 
			INNER JOIN 
			( 
				SELECT 
					AID.AggregateDateID,  
					AID.ISIN,  
					MAX(TradeTimestamp) AS TradeTimestamp, 
					COUNT(*) CNT, 
					MIN(TradeTimestamp) AS T1 
				FROM 
						DWH.FactEtfTrade T 
					INNER JOIN 
						DWH.DimInstrumentEtf Etf 
					ON T.InstrumentID = Etf.InstrumentID 
					INNER JOIN 
						ETL.ActiveInstrumentsDates AID 
					ON  
						Etf.ISIN = AID.ISIN 
					AND 
						T.TradeDateID = AID.AggregateDateID 
					INNER JOIN 
						DWH.DimTradeModificationType MOD 
					ON T.TradeModificationTypeID = MOD.TradeModificationTypeID 
					AND MOD.TradeModificationTypeName <> 'CANCEL' 
				WHERE 
					T.DelayedTradeYN = 'N' 
				GROUP BY 
					AID.AggregateDateID,  
					AID.ISIN 
			) AS LastTrade 
			ON 
				T.TradeDateID = LastTrade.AggregateDateID 
			AND 
				Etf.ISIN = LastTrade.ISIN 
			AND 
				T.TradeTimestamp = LastTrade.TradeTimestamp 
		WHERE 
			T.DelayedTradeYN = 'N' 
		GROUP BY 
			LastTrade.AggregateDateID,  
			LastTrade.ISIN, 
			T.TradeDateID, 
			T.TradeTimeID, 
			T.TradeTimestamp, 
			T.UTCTradeTimeStamp 
 
 
 
 



GO
