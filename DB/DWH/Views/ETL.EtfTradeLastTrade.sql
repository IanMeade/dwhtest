SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
  
CREATE VIEW [ETL].[EtfTradeLastTrade] AS  
	/* LAST TRADE PRICE & DATE */  
		SELECT  
			D.AggregateDateID,   
			COALESCE( L1.InstrumentGlobalID, SNAP_KEY.InstrumentGlobalID ) AS InstrumentGlobalID,
			COALESCE( L1.TradeDateID, V.LTPDateID) AS LTPDateID ,  
			COALESCE( L1.TradeTimeID, V.LTPTimeID) AS LTPTimeID,  
			COALESCE( L1.TradeTimestamp, V.LTPTime) AS LTPTime,  
			COALESCE( L1.UTCTradeTimeStamp, V.UtcLTPTime) AS UtcLTPTime,  
			COALESCE( L1.TradePrice, V.LTP ) AS LastPrice  
		FROM  
				ETL.AggregationDateList D
			LEFT OUTER JOIN  
				ETL.EtfTradeLastTradeDateScoped L1  
			ON   
				D.AggregateDateID = L1.AggregateDateID  
			LEFT OUTER JOIN
			/* MOST RECENT TRADE RECORDED IN SNAPSHOT */  
			(
				SELECT
					ETF.InstrumentGlobalID,
					D.AggregateDateID,
					MAX(F.DateID) AS DateID,
					MAX(F.InstrumentID) AS InstrumentID
				FROM
						ETL.AggregationDateList D
					INNER JOIN
						DWH.FactEtfSnapshot F  
					ON D.AggregateDateID >= F.DateID
					INNER JOIN
						DWH.DimInstrumentEtf ETF
					ON F.InstrumentID = ETF.InstrumentID  
				GROUP BY
					D.AggregateDateID,
					ETF.InstrumentGlobalID
			) AS SNAP_KEY
			ON D.AggregateDateID = SNAP_KEY.AggregateDateID
			INNER JOIN
				DWH.FactEtfSnapshot V
			ON SNAP_KEY.DateID = V.DateID
			AND SNAP_KEY.InstrumentID = V.InstrumentID

GO
