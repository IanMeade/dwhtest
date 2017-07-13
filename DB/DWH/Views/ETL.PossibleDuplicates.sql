SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




  
   
CREATE VIEW [ETL].[PossibleDuplicates] AS   
	/* USES TRADE DATE TO CHECK FOR DUPLICATES */   
  
	/* Supported by Index: IX_FactEquityTrade_DuplicateCheck & IX_FactEtfTrade_DuplicateCheck */  
		SELECT   
			T.TradeDateID,   
			T.TradingSysTransNo,
			I.ISIN,
			J.TradeTypeCategory
		FROM   
				DWH.FactEquityTrade T   
			INNER JOIN
				DWH.DimInstrumentEquity I
			ON T.InstrumentID = I.InstrumentID
			INNER JOIN
				DWH.DimEquityTradeJunk J
			ON T.EquityTradeJunkID = J.EquityTradeJunkID
		WHERE   
			TradeDateID IN ( SELECT TradeDateID FROM ETL.EquityTradeDate )   
		UNION   
		SELECT   
			T.TradeDateID,   
			T.TradingSysTransNo,
			I.ISIN,
			J.TradeTypeCategory
		FROM   
				DWH.FactEtfTrade T   
			INNER JOIN
				DWH.DimInstrumentEtf I
			ON T.InstrumentID = I.InstrumentID
			INNER JOIN
				DWH.DimEquityTradeJunk J
			ON T.EquityTradeJunkID = J.EquityTradeJunkID
		WHERE   
			TradeDateID IN ( SELECT TradeDateID FROM ETL.EquityTradeDate )   

   
  




GO
