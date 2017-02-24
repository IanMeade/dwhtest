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
				DWH.FactEquityTrade T
			INNER JOIN
				DWH.DimInstrumentEquity I
			ON T.InstrumentID = I.InstrumentID
			AND I.CurrentRowYN = 'Y'
			INNER JOIN
				DWH.DimTradeModificationType TM
			ON T.TradeModificationTypeID = TM.TradeModificationTypeID
		WHERE
			TM.TradeModificationTypeName <> 'CANCEL'
		GROUP BY
			I.ISIN,
			T.TradeDateID


GO
