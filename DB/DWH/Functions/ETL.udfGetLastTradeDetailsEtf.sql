SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Ian Meade
-- Create date: 22/5/2017
-- Description:	Get Last Trade Prices - ETF 
-- =============================================
CREATE FUNCTION [ETL].[udfGetLastTradeDetailsEtf]
(	
	@DateID INT
)
RETURNS TABLE 
AS
RETURN 
(
	WITH
		ValidTrades AS (
			SELECT
				I.InstrumentGlobalID,
				T.EtfTradeID,
				T.TradeDateID,
				T.TradeTimeID,
				T.TradeTimestamp,
				T.UTCTradeTimeStamp,
				T.PublishedDateTime,
				T.TradePrice
			FROM
					DWH.FactEtfTrade T
				INNER JOIN	
					DWH.DimInstrument I
				ON T.InstrumentID = I.InstrumentID
			WHERE
					T.TradeCancelled = 'N'
				AND
				(
					/* Trade is not delayed */
					DelayedTradeYN = 'N'
				OR
					(
						DelayedTradeYN = 'Y'
					AND
						/* Trade is delayed by less tehan one day - ie published on same day as trade */	
						T.PublishDateID = T.TradeDateID
					)
				)
				AND
					TradeDateID <= @DateID
		),
		LastTradeDate AS (
			SELECT			
				InstrumentGlobalID,
				MAX(PublishedDateTime) PublishedDateTime
			FROM
				ValidTrades
			GROUP BY
				InstrumentGlobalID
		),
		LastTradeID AS (
			SELECT
				T.InstrumentGlobalID,
				T.PublishedDateTime,
				MAX(EtfTradeID) AS EtfTradeID
			FROM
				LastTradeDate L
			INNER JOIN
				ValidTrades T
			ON L.InstrumentGlobalID = T.InstrumentGlobalID
			AND L.PublishedDateTime = T.PublishedDateTime
			GROUP BY
				T.InstrumentGlobalID,
				T.PublishedDateTime
		)
		SELECT
			@DateID AS AggregationDateID,
			LT.InstrumentGlobalID,
			LT.PublishedDateTime,
			T.TradeDateID,
			T.TradeTimeID,
			T.TradeTimestamp,
			T.UTCTradeTimeStamp,
			T.TradePrice
		FROM
				LastTradeID LT
			INNER JOIN
				ValidTrades T
			ON LT.EtfTradeID = T.EtfTradeID

)

GO
