SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

    
     
CREATE PROCEDURE [ETL].[UpdateFactEtfSnapshot]    
	@WISDOM_ISIN VARCHAR(12)   
AS      
     
BEGIN     
	SET NOCOUNT ON    
   
   	/* GET DEFAULT VALUES FROM PREVIOUS ROW AND MAKE NULLABLE FIELD 0 */   
	EXEC ETL.UpdateFactEtfSnapshotHelper
     
 	/* GET THE DATE AGGREGATION IS RUN FOR - DEFINED TO BE ONE DAY IN EACH PROCEDURE CALL */    
	DECLARE @DateID AS INT    
	SELECT    
		@DateID = MAX(AggregationDateID)    
	FROM    
		ETL.FactEtfSnapshotMerge    
	    
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
			LastExDivDateID = E.LastExDivDateID,     
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
			OpenPrice = E.OpenPrice,     
			LowPrice = E.LowPrice,     
			HighPrice = E.HighPrice,     
			BidPrice = E.BidPrice,     
			OfferPrice = E.OfferPrice,     
			ClosingAuctionBidPrice = E.ClosingAuctionBidPrice,     
			ClosingAuctionOfferPrice = E.ClosingAuctionOfferPrice,     
			OCP = E.OCP,     
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
			ExDivYN = E.ExDivYN,     
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
			MarketID = E.MarketID,     
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
			OCP = E.OCP,     
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
			OcpDateTime,   
			LTPDateID,     
			LTPTimeID,     
			LTPTime,     
			UtcLTPTime,     
			LtpDateTime,   
			MarketID,     
--			TotalSharesInIssue,     
--			IssuedSharesToday,     
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
			NAV,
			NAVCalcDateID,
			BatchID     
		)     
		SELECT     
			InstrumentID,     
			InstrumentStatusID,     
			AggregationDateID,     
			LastExDivDateID,     
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
			ExDivYN,     
			OpenPrice,     
			LowPrice,     
			HighPrice,     
			BidPrice,     
			OfferPrice,     
			ClosingAuctionBidPrice,     
			ClosingAuctionOfferPrice,     
			OCP,    
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
			NAV,
			NAVCalcDateID,
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
    
   
	/* MAIN UPDATE OF ETF VALUES */    
	/* - ASSUMES DATA HAS BEEN CORRECTLY STAGED */    
	/* - INCLUDES OUTPUT CLAUSE TO ALLOW UPDATE OF SHARES ISSUES TODAY */    
	    
	/* Get most recent ODS value */	
	DECLARE @Unit NUMERIC(19,2) = 0

	SELECT
		TOP 1
		@Unit = Units_In_Issue
	FROM
		ETL.StateStreet_ISEQ20_NAV ODS 
	WHERE
		ODS.ValuationDateID <= (
						SELECT
							MIN(AggregationDateID)
						FROM
							ETL.FactEtfSnapshotMerge E  
					)
	ORDER BY
		ODS.ValuationDateID DESC

	UPDATE    
		DWH
	SET  
		ETFSharesInIssue = COALESCE(@Unit, DWH.ETFSharesInIssue)
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
	WHERE    
		E.ISIN = @WISDOM_ISIN    
		    
	/* WISDOM TREE UPDATE */ 
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
	AND
		DWH.DateID = @DateID
 
	/* GENERIC UPDATE / ALL NON WISDOM TREE UPDATES */ 
	/* SAME AS ABOICE BUT DIFFERENT FILTER - KEEPNG SEPERATE INCASE THESE NEED TO CHANGE */ 
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
		I.ISIN <> @WISDOM_ISIN    
	AND
		DWH.DateID = @DateID
			    

	/* MANUAL FIXES */
	UPDATE
		DWH.FactEtfSnapshot
	SET
		IssuedSharesToday = ISNULL(IssuedSharesToday ,0)
	WHERE
		DateID = @DateID

	UPDATE
		DWH
	SET
		OCPDateTime = CAST(D.Day AS datetime) + CAST(DWH.OCPTime AS datetime)
	FROM
			DWH.FactEtfSnapshot DWH
		INNER JOIN
			DWH.DimDate D
		ON DWH.OCPDateID = D.DateID
	WHERE
		DWH.DateID = @DateID
	AND
		DWH.OCPDateID IS NOT NULL
	AND
		DWH.OCPDateID <> -1
	AND
		DWH.OCPTime IS NOT NULL
			
	UPDATE
		DWH
	SET
		LtpDateTime = CAST(D.Day AS datetime) + CAST(DWH.LTPTime AS datetime)
	FROM
			DWH.FactEtfSnapshot DWH
		INNER JOIN
			DWH.DimDate D
		ON DWH.LTPDateID = D.DateID
	WHERE
		DWH.DateID = @DateID
	AND
		DWH.LTPDateID IS NOT NULL
	AND
		DWH.LTPDateID <> -1
	AND
		DWH.LtpTime IS NOT NULL
			



    
END     

GO
