SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ETL].[PossibleDuplicates] AS
	/* 
		TRADES IN THE DHW THAT ETL MIGHT DUPLCIATE IF NO CHECK IS PERFORMED
		TRADES INCLUDE:
			TRADES IN EALRY FILES DUPLCIATED IN LATER FILES
			TRADES IN QUARANTINE
		CHECK STOPS WHEN FILES ARE MARKED COMPLETE OR REJECT
	*/ 

	/* USES FILE STATUS TO CHECK FOR DUPLICATES */
	/*
		SELECT
			TradeDateID,
			TradingSysTransNo
		FROM
				DWH.FactEquityTrade T
			INNER JOIN
				DWH.DimFile F
			ON T.TradeFileID = F.FileID
		WHERE
			FilePrcocessedStatus NOT IN ( 'COMPLETE', 'REJECT' )
		UNION
		SELECT
			TradeDateID,
			TradingSysTransNo
		FROM
				DWH.FactEtfTrade T
			INNER JOIN
				DWH.DimFile F
			ON T.TradeFileID = F.FileID
		WHERE
			FilePrcocessedStatus NOT IN ( 'COMPLETE', 'REJECT' ) 
	*/

	/* USES TRADE DATE TO CHECK FOR DUPLICATES */
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
