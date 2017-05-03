SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
CREATE PROCEDURE [ETL].[UpdateFactEtfSnapshot] AS  
 
BEGIN 
	SET NOCOUNT ON
 
	/* Update existing and insert any new puppies */ 
 
	UPDATE 
		DWH 
	SET 
		InstrumentID = E.CurrentInstrumentID, 
		InstrumentStatusID = E.InstrumentStatusID, 
		DateID = E.DateID, 
		LastExDivDateID = E.LastExDivDateID, 
		OCPDateID = E.OCPDateID, 
		OCPTimeID = E.OCPTimeID, 
		OCPTime = E.OCPTime, 
		UtcOCPTime = E.UtcOCPTime, 
		LTPDateID = E.LTPDateID, 
		LTPTimeID = E.LTPTimeID, 
		LTPTime = E.LTPTime, 
		UtcLTPTime = E.UtcLTPTime, 
		MarketID = E.MarketID, 
	----TotalSharesInIssue = E.TotalSharesInIssue, 
		IssuedSharesToday = E.IssuedSharesToday, 
		ExDivYN = E.ExDivYN, 
		OpenPrice = E.OpenPrice, 
		LowPrice = E.LowPrice, 
		HighPrice = E.HighPrice, 
		BidPrice = E.BidPrice, 
		OfferPrice = E.OfferPrice, 
		ClosingAuctionBidPrice = E.ClosingAuctionBidPrice, 
		ClosingAuctionOfferPrice = E.ClosingAuctionOfferPrice, 
		OCP = E.OCP, 
		LTP = E.LTP, 
		MarketCap = E.MarketCap, 
		MarketCapEur = E.MarketCapEur, 
		Turnover = E.Turnover, 
		TurnoverND = E.TurnoverND, 
		TurnoverEur = E.TurnoverEur, 
		TurnoverNDEur = E.TurnoverNDEur, 
		TurnoverOB = E.TurnoverOB, 
		TurnoverOBEur = E.TurnoverOBEur, 
		Volume = E.Volume, 
		VolumeND = E.VolumeND, 
		VolumeOB = E.VolumeOB, 
		Deals = E.Deals, 
		DealsOB = E.DealsOB, 
		DealsND = E.DealsND, 
/*
		ISEQ20Shares = E.ISEQ20Shares, 
		ISEQ20Price = E.ISEQ20Price, 
		ISEQ20Weighting = E.ISEQ20Weighting, 
		ISEQ20MarketCap = E.ISEQ20MarketCap, 
		ISEQ20FreeFloat = E.ISEQ20FreeFloat, 
*/
/*
		ISEQOverallWeighting = E.ISEQOverallWeighting, 
		ISEQOverallMarketCap = E.ISEQOverallMarketCap, 
		ISEQOverallBeta30 = E.ISEQOverallBeta30, 
		ISEQOverallBeta250 = E.ISEQOverallBeta250, 
		ISEQOverallFreefloat = E.ISEQOverallFreefloat, 
		ISEQOverallPrice = E.ISEQOverallPrice, 
		ISEQOverallShares = E.ISEQOverallShares, 
*/
		OverallIndexYN = E.OverallIndexYN, 
		GeneralIndexYN = E.GeneralIndexYN, 
		FinancialIndexYN = E.FinancialIndexYN, 
		SmallCapIndexYN = E.SmallCapIndexYN, 
		ITEQIndexYN = E.ITEQIndexYN, 
		ISEQ20IndexYN = E.ISEQ20IndexYN, 
		ESMIndexYN = E.ESMIndexYN, 
		ExCapYN = E.ExCapYN, 
		ExEntitlementYN = E.ExEntitlementYN, 
		ExRightsYN = E.ExRightsYN, 
		ExSpecialYN = E.ExSpecialYN, 
		PrimaryMarket = E.PrimaryMarket, 
		BatchID = E.BatchID 
	FROM 
			DWH.FactEtfSnapshot DWH 
		INNER JOIN 
			DWH.DimInstrumentEtf I 
		ON DWH.InstrumentID = I.InstrumentID 
		INNER JOIN		 
			ETL.FactEtfSnapshotMerge E 
		ON  
			I.ISIN = E.ISIN 
		AND 
			DWH.DateID = E.DateID 
 
 
	INSERT INTO 
			DWH.FactEtfSnapshot 
		( 
			InstrumentID, 
			InstrumentStatusID, 
			DateID, 
			LastExDivDateID, 
			OCPDateID, 
			OCPTimeID, 
			OCPTime, 
			UtcOCPTime, 
			LTPDateID, 
			LTPTimeID, 
			LTPTime, 
			UtcLTPTime, 
			MarketID, 
--			TotalSharesInIssue, 
			IssuedSharesToday, 
			ExDivYN, 
			OpenPrice, 
			LowPrice, 
			HighPrice, 
			BidPrice, 
			OfferPrice, 
			ClosingAuctionBidPrice, 
			ClosingAuctionOfferPrice, 
			OCP, 
			LTP, 
			MarketCap, 
			MarketCapEur, 
			Turnover, 
			TurnoverND, 
			TurnoverEur, 
			TurnoverNDEur, 
			TurnoverOB, 
			TurnoverOBEur, 
			Volume, 
			VolumeND, 
			VolumeOB, 
			Deals, 
			DealsOB, 
			DealsND, 
/*
			ISEQ20Shares, 
			ISEQ20Price, 
			ISEQ20Weighting, 
			ISEQ20MarketCap, 
			ISEQ20FreeFloat, 
*/
/*
			ISEQOverallWeighting, 
			ISEQOverallMarketCap, 
			ISEQOverallBeta30, 
			ISEQOverallBeta250, 
			ISEQOverallFreefloat, 
			ISEQOverallPrice, 
			ISEQOverallShares, 
*/
			OverallIndexYN, 
			GeneralIndexYN, 
			FinancialIndexYN, 
			SmallCapIndexYN, 
			ITEQIndexYN, 
			ISEQ20IndexYN, 
			ESMIndexYN, 
			ExCapYN, 
			ExEntitlementYN, 
			ExRightsYN, 
			ExSpecialYN, 
			PrimaryMarket, 
			BatchID 
		) 
		SELECT 
			CurrentInstrumentID, 
			InstrumentStatusID, 
			DateID, 
			LastExDivDateID, 
			OCPDateID, 
			OCPTimeID, 
			OCPTime, 
			UtcOCPTime, 
			LTPDateID, 
			LTPTimeID, 
			LTPTime, 
			UtcLTPTime, 
			MarketID, 
--			TotalSharesInIssue, 
			IssuedSharesToday, 
			ExDivYN, 
			OpenPrice, 
			LowPrice, 
			HighPrice, 
			BidPrice, 
			OfferPrice, 
			ClosingAuctionBidPrice, 
			ClosingAuctionOfferPrice, 
			OCP, 
			LTP, 
			MarketCap, 
			MarketCapEur, 
			Turnover, 
			TurnoverND, 
			TurnoverEur, 
			TurnoverNDEur, 
			TurnoverOB, 
			TurnoverOBEur, 
			Volume, 
			VolumeND, 
			VolumeOB, 
			Deals, 
			DealsOB, 
			DealsND, 
/*
			ISEQ20Shares, 
			ISEQ20Price, 
			ISEQ20Weighting, 
			ISEQ20MarketCap, 
			ISEQ20FreeFloat, 
*/
/*
			ISEQOverallWeighting, 
			ISEQOverallMarketCap, 
			ISEQOverallBeta30, 
			ISEQOverallBeta250, 
			ISEQOverallFreefloat, 
			ISEQOverallPrice, 
			ISEQOverallShares, 
*/
			OverallIndexYN, 
			GeneralIndexYN, 
			FinancialIndexYN, 
			SmallCapIndexYN, 
			ITEQIndexYN, 
			ISEQ20IndexYN, 
			ESMIndexYN, 
			ExCapYN, 
			ExEntitlementYN, 
			ExRightsYN, 
			ExSpecialYN, 
			PrimaryMarket, 
			BatchID 
		FROM 
			ETL.FactEtfSnapshotMerge E 
		WHERE 
			NOT EXISTS ( 
					SELECT 
						* 
					FROM	 
							DWH.FactEtfSnapshot DWH 
						INNER JOIN 
							DWH.DimInstrumentEtf I 
						ON DWH.InstrumentID = I.InstrumentID 
					WHERE 
							I.ISIN = E.ISIN 
						AND 
							DWH.DateID = E.DateID 
				)			 
 
	/* SPECIAL UPDATE FOR WINDOW TREE */

	/* Table used to capture the IDs of changed row - used ot update ETFSharesInIssue */
	DECLARE @WisdomTreeUpdates TABLE ( EtfSnapshotID INT )

	/* MAIN UPDATE OF ETF VALUES */
	/* - ASSUMES DATA HAS BEEN CORRECTLY STAGED */
	/* - INCLKUDES OUTPUT CLAUSE TO ALLOW UPDATE OF SHARES ISSUES TODAY */
	
	UPDATE
		DWH
	SET
		NAVCalcDateID = DWH.DateID,
		NAV = ODS.NAV_per_unit,
		ETFSharesInIssue = ODS.Units_In_Issue
	OUTPUT
		inserted.EtfSnapshotID INTO @WisdomTreeUpdates
	FROM
			ETL.FactEtfSnapshotMerge E 
		INNER JOIN
			DWH.FactEtfSnapshot DWH 
		on E.DateID = DWH.DateID
		INNER JOIN 
			DWH.DimInstrumentEtf I 
		ON DWH.InstrumentID = I.InstrumentID 
		INNER JOIN
			ETL.StateStreet_ISEQ20_NAV ODS
		ON E.DateID = ODS.ValuationDateID
	WHERE
		I.InstrumentName = 'WisdomTree ISEQ 20 UCITS ETF Shares'
		
	UPDATE
		DWH
	SET
		IssuedSharesToday = DWH.ETFSharesInIssue - PREV.ETFSharesInIssue
	FROM
			@WisdomTreeUpdates U
		INNER JOIN
			DWH.FactEtfSnapshot DWH 
		ON U.EtfSnapshotID = DWH.EtfSnapshotID
		INNER JOIN 
			DWH.DimInstrumentEtf I 
		ON DWH.InstrumentID = I.InstrumentID 
		CROSS APPLY (
					SELECT
						TOP 1
						ETFSharesInIssue
					FROM
							DWH.FactEtfSnapshot DWH2
						INNER JOIN 
							DWH.DimInstrumentEtf I2 
						ON DWH2.InstrumentID = I2.InstrumentID 
					WHERE
							I2.InstrumentName = 'WisdomTree ISEQ 20 UCITS ETF Shares'
						AND
							DWH2.ETFSharesInIssue IS NOT NULL
						AND
							DWH.DateID > DWH2.DateID
					ORDER BY
						DWH.DateID DESC
				) AS PREV
	WHERE
		I.InstrumentName = 'WisdomTree ISEQ 20 UCITS ETF Shares'
			

END 


GO
