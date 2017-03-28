SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 
CREATE VIEW [ETL].[PossibleDuplicates] AS 
	/* USES TRADE DATE TO CHECK FOR DUPLICATES */ 

	/* Supported by Index: IX_FactEquityTrade_DuplicateCheck & IX_FactEtfTrade_DuplicateCheck */
		SELECT 
			TradeDateID, 
			TradingSysTransNo 
		FROM 
				DWH.FactEquityTrade T 
		WHERE 
			TradeDateID IN ( SELECT TradeDateID FROM ETL.EquityTradeDate ) 
		UNION 
		SELECT 
			TradeDateID, 
			TradingSysTransNo 
		FROM 
				DWH.FactEtfTrade T 
		WHERE 
			TradeDateID IN ( SELECT TradeDateID FROM ETL.EquityTradeDate ) 
 

GO
