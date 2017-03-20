SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 
 
 
CREATE VIEW [ETL].[EquityTradeLastTrade] AS 
	/* LAST TRADE PRICE & DATE */ 
		SELECT 
			AID.AggregateDate,  
			AID.AggregateDateID,  
			AID.InstrumentID,  
			AID.ISIN,  
			COALESCE( L1.TradeDateID, LastTrade.LTPDateID) AS LTPDateID , 
			COALESCE( L1.TradeTimeID, LastTrade.LTPTimeID) AS LTPTimeID, 
			COALESCE( L1.TradeTimestamp, LastTrade.LTPTime) AS LTPTime, 
			COALESCE( L1.UTCTradeTimeStamp, LastTrade.UtcLTPTime) AS UtcLTPTime, 
			COALESCE( L1.TradePrice, LastTrade.LTP ) AS LastPrice 
		FROM 
				ETL.ActiveInstrumentsDates AID 
			LEFT OUTER JOIN 
				ETL.EquityTradeLastTradeDateScoped L1 
			ON  
				AID.AggregateDateID = L1.AggregateDateID 
			AND  
				AID.ISIN = L1.ISIN 
			/* MOST RECENT TRADE RECORDED IN SNAPSHOT */ 
			OUTER APPLY 
			( 
				SELECT 
					TOP 1 
 
					F.LTP, 
					F.LTPDateID, 
					F.LTPTimeID, 
					F.LTPTime, 
					F.UtcLTPTime 
				FROM 
						DWH.FactEquitySnapshot F 
					INNER JOIN 
						DWH.DimInstrumentEquity EQUITY 
					ON F.InstrumentID = EQUITY.InstrumentID 
				WHERE 
					AID.AggregateDateID > F.DateID 
				AND 
					AID.ISIN = EQUITY.ISIN 
				ORDER BY 
					F.DateID ASC 
			) AS LastTrade 
 
 
 
 
 

GO
