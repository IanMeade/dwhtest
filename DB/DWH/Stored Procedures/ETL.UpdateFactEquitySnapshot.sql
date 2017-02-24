SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [ETL].[UpdateFactEquitySnapshot] AS
	/* STILL WIP */


	/* SET DUMMY FOREIGN KEYS FOR NULL DATES / TIMES */
	UPDATE
		ETL.TradeAggregationsFactEquityTradeSnapshot
	SET
		/* InstrumentID */
		/* CurrencyID */
		OCP_DATEID = ISNULL( OCP_DATEID, -1),
		/* OCP_TIME */
		OCP_TIME_ID = ISNULL( OCP_TIME_ID, 0),
		/* OCP_TIME_UTC */
		LTPDateID = ISNULL( LTPDateID, -1),
		LTPTimeID = ISNULL( LTPTimeID, 0)
		/* LTPTime */
		/* UtcLTPTime */


	/* Update any existing entires */

	UPDATE
		I
	SET
			OCPDateID = O.OCP_DATEID,
			OCPTimeID = O.OCP_TIME_ID,
			OCPTime = O.OCP_TIME,
			UtcOCPTime = O.OCP_TIME_UTC,
			OCP = O.OCP,		
			OpenPrice = O.OOP,
			LTP = O.LastPrice,
			LTPDateID = O.LTPDateID,
			LTPTimeID = O.LTPTimeID,
			LTPTime = O.LTPTime,
			UtcLTPTime = O.UtcLTPTime,

			/*
			LastPriceTimeID, 
			*/
			LowPrice = O.LowPrice , 
			HighPrice = O.HighPrice, 
			Deals = O.Deals, 
			DealsOB = O.DealsOB, 
			DealsND = O.DealsND,
			/*
			Volume = O.Volume, 
			VolumeOB = O.VolumeOB, 
			VolumeND = O.VolumeND, 
			*/

			Turnover = O.Turnover, 
			TurnoverOB = O.TurnoverOB, 
			TurnoverND = O.TurnoverND, 
			TurnoverEur = O.TurnoverEur, 
			TurnoverObEur = O.TurnoverObEur, 
			TurnoverNdEur = O.TurnoverNdEur,

			BidPrice = O.BidPrice,
			OfferPrice = O.OfferPrice,
			ClosingAuctionBidPrice = O.ClosingAuctionBidPrice, 
			ClosingAuctionOfferPrice = O.ClosingAuctionOfferPrice

	FROM
			DWH.FactEquitySnapshot I
		INNER JOIN
			DWH.DimInstrumentEquity EQUITY
		ON 
			I.InstrumentID = EQUITY.InstrumentID
		INNER JOIN
			ETL.TradeAggregationsFactEquityTradeSnapshot O
		ON 
			O.AggregateDateID = I.DateID
		AND
			O.ISIN = EQUITY.ISIN
	
	


	/* Insert new rows */

	INSERT INTO
			DWH.FactEquitySnapshot
		(
			InstrumentID, 
			DateID, 

			OCPDateID,
			OCPTimeID,
			OCPTime,
			UtcOCPTime,
			OCP, 
			OpenPrice,

			/*
			OOP, 
			*/
			LTP,
			LTPDateID,
			LTPTimeID,
			LTPTime,
			UtcLTPTime,
			LowPrice, 
			HighPrice, 
			Deals, 
			DealsOB, 
			DealsND, 
			Volume, 
			VolumeOB, 
			VolumeND, 
			Turnover, 
			TurnoverOB, 
			TurnoverND, 
			TurnoverEur, 
			TurnoverObEur, 
			TurnoverNdEur,

			BidPrice,
			OfferPrice,
			ClosingAuctionBidPrice, 
			ClosingAuctionOfferPrice 

		)
		SELECT
			InstrumentID, 
			AggregateDateID, 

			OCP_DATEID,
			OCP_TIME_ID,
			OCP_TIME,
			OCP_TIME_UTC,
			OCP, 
			OOP, 
			LastPrice, 
			LTPDateID,
			LTPTimeID,
			LTPTime,
			UtcLTPTime,
			LowPrice, 
			HighPrice, 
			Deals, 
			DealsOB, 
			DealsND, 
			TradeVolume, 
			TradeVolumeOB, 
			TradeVolumeND, 
			Turnover, 
			TurnoverOB, 
			TurnoverND, 
			TurnoverEur, 
			TurnoverObEur, 
			TurnoverNdEur,

			BidPrice,
			OfferPrice,
			ClosingAuctionBidPrice, 
			ClosingAuctionOfferPrice 


		FROM
			ETL.TradeAggregationsFactEquityTradeSnapshot O
		WHERE
			NOT EXISTS (
					SELECT
						*
					FROM
							DWH.FactEquitySnapshot I
						INNER JOIN

							DWH.DimInstrumentEquity EQUITY
						ON 
							I.InstrumentID = EQUITY.InstrumentID
					WHERE
						O.AggregateDateID = I.DateID
					AND
						O.ISIN = EQUITY.ISIN
				)

GO
