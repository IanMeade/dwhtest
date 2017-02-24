SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [ETL].[EquityTradeLastTradeDateScoped] AS 
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

				DWH.FactEquityTrade T
			INNER JOIN
				DWH.DimInstrumentEquity EQUITY
			ON T.InstrumentID = EQUITY.InstrumentID
			INNER JOIN
				ETL.ActiveInstrumentsDates AID
			ON 
				EQUITY.ISIN = AID.ISIN
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
						DWH.FactEquityTrade T


					INNER JOIN
						DWH.DimInstrumentEquity EQUITY
					ON T.InstrumentID = EQUITY.InstrumentID
					INNER JOIN
						ETL.ActiveInstrumentsDates AID
					ON 
						EQUITY.ISIN = AID.ISIN
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
				EQUITY.ISIN = LastTrade.ISIN
			AND
				T.TradeTimestamp = LastTrade.TradeTimestamp
		WHERE
			T.DelayedTradeYN = 'N'
		AND 
			AID.InstrumentType = 'EQUITY'
		GROUP BY
			LastTrade.AggregateDateID, 
			LastTrade.ISIN,
			T.TradeDateID,
			T.TradeTimeID,
			T.TradeTimestamp,
			T.UTCTradeTimeStamp




GO
