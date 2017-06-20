SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
   
    
CREATE PROCEDURE [ETL].[UpdateFactEtfSnapshot]   
	@WISDOM_ISIN VARCHAR(12)  
AS     
    
BEGIN    
	SET NOCOUNT ON   
  
	/* MAKE NULLABLE FIELD 0 */  
	UPDATE  
		ETL.FactEtfSnapshotMerge   
	SET  
		Turnover = ISNULL(Turnover, 0),   
		TurnoverND = ISNULL(TurnoverND, 0),   
		TurnoverEur = ISNULL(TurnoverEur, 0),    
		TurnoverNDEur = ISNULL(TurnoverNDEur, 0),    
		TurnoverOB = ISNULL(TurnoverOB, 0),    
		TurnoverOBEur = ISNULL(TurnoverOBEur, 0),    
		Volume = ISNULL(Volume, 0),    
		VolumeND = ISNULL(VolumeND, 0),    
		VolumeOB = ISNULL(VolumeOB, 0),    
		Deals = ISNULL(Deals, 0),    
		DealsOB = ISNULL(DealsOB, 0),    
		DealsND = ISNULL(DealsND, 0)  
    
 	/* GET THE DATE AGGREGATION IS RUN FOR - DEFINED TO BE ONE DAY IN EACH PROCEDURE CALL */   
	DECLARE @DateID AS INT   
	SELECT   
		@DateID = MAX(DateID)   
	FROM   
		ETL.FactEquitySnapshotMerge   
	   
	IF @DateID = CAST(CONVERT(CHAR,GETDATE(),112) AS int)   
	BEGIN   
		/* UPDATING TODAYS SNAPSHOT */   
		/* Update existing and insert any new puppies */     
   
		UPDATE    
			DWH    
		SET    
			InstrumentID = E.InstrumentID,    
			InstrumentStatusID = E.InstrumentStatusID,    
			DateID = E.AggregationDateID,    
	--		LastExDivDateID = E.LastExDivDateID,    
			OCPDateID = E.OCPDateID,    
			OCPTimeID = E.OCPTimeID,    
			OCPTime = E.OCPTime,    
			UtcOCPTime = E.UtcOCPTime,    
			OcpDateTime = E.OcpDateTime,  
			LTPDateID = E.LTPDateID,    
			LTPTimeID = E.LTPTimeID,    
			LTPTime = E.LTPTime,    
			UtcLTPTime = E.UtcLTPTime,    
			LtpDateTime = E.LtpDateTime,  
			/*   
			MarketID = E.MarketID,    
			*/   
	--		TotalSharesInIssue = E.TotalSharesInIssue,    
			--IssuedSharesToday = E.IssuedSharesToday,    
			--ExDivYN = E.ExDivYN,    
			OpenPrice = E.OpenPrice,    
			LowPrice = E.LowPrice,    
			HighPrice = E.HighPrice,    
			BidPrice = E.BidPrice,    
			OfferPrice = E.OfferPrice,    
			ClosingAuctionBidPrice = E.ClosingAuctionBidPrice,    
			ClosingAuctionOfferPrice = E.ClosingAuctionOfferPrice,    
			OCP = E.OpenPrice,    
			LTP = E.LastPrice,    
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
			/* NOT NEEDED FOR ETF */   
			/*   
			ISEQ20Shares = E.ISEQ20Shares,    
			ISEQ20Price = E.ISEQ20Price,    
			ISEQ20Weighting = E.ISEQ20Weighting,    
			ISEQ20MarketCap = E.ISEQ20MarketCap,    
			ISEQ20FreeFloat = E.ISEQ20FreeFloat,    
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
			--ExCapYN = E.ExCapYN,    
			--ExEntitlementYN = E.ExEntitlementYN,    
			--ExRightsYN = E.ExRightsYN,    
			--ExSpecialYN = E.ExSpecialYN,    
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
				I.InstrumentGlobalID = E.InstrumentGlobalID   
			AND    
				DWH.DateID = E.AggregationDateID   
	END   
	ELSE   
	BEGIN   
		UPDATE    
			DWH    
		SET    
			InstrumentID = E.InstrumentID,    
			InstrumentStatusID = E.InstrumentStatusID,    
			DateID = E.AggregationDateID,    
	--		LastExDivDateID = E.LastExDivDateID,    
			OCPDateID = E.OCPDateID,    
			OCPTimeID = E.OCPTimeID,    
			OCPTime = E.OCPTime,    
			OcpDateTime = E.OcpDateTime,  
			UtcOCPTime = E.UtcOCPTime,    
			LTPDateID = E.LTPDateID,    
			LTPTimeID = E.LTPTimeID,    
			LTPTime = E.LTPTime,    
			UtcLTPTime = E.UtcLTPTime,    
			LtpDateTime = E.LtpDateTime,  
			/*   
			MarketID = E.MarketID,    
			*/   
	--		TotalSharesInIssue = E.TotalSharesInIssue,    
			--IssuedSharesToday = E.IssuedSharesToday,    
			--ExDivYN = E.ExDivYN,    
			OpenPrice = E.OpenPrice,    
			LowPrice = E.LowPrice,    
			HighPrice = E.HighPrice,    
			BidPrice = E.BidPrice,    
			OfferPrice = E.OfferPrice,    
			ClosingAuctionBidPrice = E.ClosingAuctionBidPrice,    
			ClosingAuctionOfferPrice = E.ClosingAuctionOfferPrice,    
			OCP = E.OpenPrice,    
			LTP = E.LastPrice,    
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
			/* NOT NEEDED FOR ETF */   
			/*   
			ISEQ20Shares = E.ISEQ20Shares,    
			ISEQ20Price = E.ISEQ20Price,    
			ISEQ20Weighting = E.ISEQ20Weighting,    
			ISEQ20MarketCap = E.ISEQ20MarketCap,    
			ISEQ20FreeFloat = E.ISEQ20FreeFloat,    
			ISEQOverallWeighting = E.ISEQOverallWeighting,    
			ISEQOverallMarketCap = E.ISEQOverallMarketCap,    
			ISEQOverallBeta30 = E.ISEQOverallBeta30,    
			ISEQOverallBeta250 = E.ISEQOverallBeta250,    
			ISEQOverallFreefloat = E.ISEQOverallFreefloat,    
			ISEQOverallPrice = E.ISEQOverallPrice,    
			ISEQOverallShares = E.ISEQOverallShares,    
			*/   
	/*   
   
			OverallIndexYN = E.OverallIndexYN,    
			GeneralIndexYN = E.GeneralIndexYN,    
			FinancialIndexYN = E.FinancialIndexYN,    
			SmallCapIndexYN = E.SmallCapIndexYN,    
			ITEQIndexYN = E.ITEQIndexYN,    
			ISEQ20IndexYN = E.ISEQ20IndexYN,    
			ESMIndexYN = E.ESMIndexYN,    
	*/   
			--ExCapYN = E.ExCapYN,    
			--ExEntitlementYN = E.ExEntitlementYN,    
			--ExRightsYN = E.ExRightsYN,    
			--ExSpecialYN = E.ExSpecialYN,    
			/*   
			PrimaryMarket = E.PrimaryMarket,    
			*/   
			BatchID = E.BatchID    
		FROM    
				DWH.FactEtfSnapshot DWH    
			INNER JOIN    
				DWH.DimInstrumentEtf I    
			ON DWH.InstrumentID = I.InstrumentID    
			INNER JOIN		    
				ETL.FactEtfSnapshotMerge E    
			ON     
				I.InstrumentGlobalID = E.InstrumentGlobalID   
			AND    
				DWH.DateID = E.AggregationDateID   
	   
	END    
    
   
	INSERT INTO    
			DWH.FactEtfSnapshot    
		(    
			InstrumentID,    
			InstrumentStatusID,    
			DateID,    
--			LastExDivDateID,    
			OCPDateID,    
			OCPTimeID,    
			OCPTime,    
			UtcOCPTime,    
			OcpDateTime,  
			LTPDateID,    
			LTPTimeID,    
			LTPTime,    
			UtcLTPTime,    
			LtpDateTime,  
			MarketID,    
--			TotalSharesInIssue,    
--			IssuedSharesToday,    
--			ExDivYN,    
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
--			ExCapYN,    
--			ExEntitlementYN,    
--			ExRightsYN,    
--			ExSpecialYN,    
			PrimaryMarket,    
			BatchID    
		)    
		SELECT    
			InstrumentID,    
			InstrumentStatusID,    
			AggregationDateID,    
--			LastExDivDateID,    
			OCPDateID,    
			OCPTimeID,    
			OCPTime,    
			UtcOCPTime,    
			OcpDateTime,  
			LTPDateID,    
			LTPTimeID,    
			LTPTime,    
			UtcLTPTime,    
			LtpDateTime,  
			MarketID,    
--			TotalSharesInIssue,    
--			IssuedSharesToday,    
--			ExDivYN,    
			OpenPrice,    
			LowPrice,    
			HighPrice,    
			BidPrice,    
			OfferPrice,    
			ClosingAuctionBidPrice,    
			ClosingAuctionOfferPrice,    
			OpenPrice,   
			LastPrice,   
			MarketCap,    
			MarketCapEur,    
			ISNULL(Turnover, 0),   
			ISNULL(TurnoverND, 0),   
			ISNULL(TurnoverEur, 0),    
			ISNULL(TurnoverNDEur, 0),    
			ISNULL(TurnoverOB, 0),    
			ISNULL(TurnoverOBEur, 0),    
			ISNULL(Volume, 0),    
			ISNULL(VolumeND, 0),    
			ISNULL(VolumeOB, 0),    
			ISNULL(Deals, 0),    
			ISNULL(DealsOB, 0),    
			ISNULL(DealsND, 0),    
   
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
--			ExCapYN,    
--			ExEntitlementYN,    
--			ExRightsYN,    
--			ExSpecialYN,    
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
							I.InstrumentGlobalID = E.InstrumentGlobalID   
						AND    
							DWH.DateID = E.AggregationDateID   
				)			    
   
    
    
	/* SPECIAL UPDATE FOR WISDOM TREE */   
   
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
		on E.AggregationDateID = DWH.DateID   
		INNER JOIN    
			DWH.DimInstrumentEtf I    
		ON DWH.InstrumentID = I.InstrumentID    
		INNER JOIN   
			ETL.StateStreet_ISEQ20_NAV ODS   
		ON E.AggregationDateID = ODS.ValuationDateID   
	WHERE   
		I.ISIN = @WISDOM_ISIN   
		   
	/* WISDOM TREE UPDATE */
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
							DWH.FactEtfSnapshot DWH_Inside
						INNER JOIN    
							DWH.DimInstrumentEtf I2    
						ON DWH_Inside.InstrumentID = I2.InstrumentID    
					WHERE   
							I2.ISIN = @WISDOM_ISIN   
						AND   
							DWH_Inside.ETFSharesInIssue IS NOT NULL   
						AND   
							DWH.DateID > DWH_Inside.DateID   
					ORDER BY   
						DWH_Inside.DateID DESC   
				) AS PREV   
	WHERE   
		I.ISIN = @WISDOM_ISIN   

	/* GENERIC UPATE / ALL NON WISDOM TREE UPDATES */
	/* SAME AS ABVOIE BUT DIFFERNET FILTER - KEEPNG SEPERATE INCASE THESE NEED TO CHANGE */
	UPDATE   
		DWH   
	SET   
		IssuedSharesToday = DWH.ETFSharesInIssue - PREV.ETFSharesInIssue   
	FROM   
			DWH.FactEtfSnapshot DWH    
		INNER JOIN    
			DWH.DimInstrumentEtf I    
		ON DWH.InstrumentID = I.InstrumentID    
		CROSS APPLY (   
					SELECT   
						TOP 1   
						ETFSharesInIssue   
					FROM   
							DWH.FactEtfSnapshot DWH_Inside
						INNER JOIN    
							DWH.DimInstrumentEtf I_Inside    
						ON DWH_Inside.InstrumentID = I_Inside.InstrumentID    
					WHERE   
							I.InstrumentGlobalID = I_Inside.InstrumentGlobalID
						AND   
							DWH_Inside.ETFSharesInIssue IS NOT NULL   
						AND   
							DWH.DateID > DWH_Inside.DateID   
					ORDER BY   
						DWH_Inside.DateID DESC   
				) AS PREV   
	WHERE   
		I.ISIN = @WISDOM_ISIN   
			   
   
END    
   
   
   
GO
