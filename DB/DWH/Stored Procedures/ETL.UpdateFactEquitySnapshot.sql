SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
      
CREATE PROCEDURE [ETL].[UpdateFactEquitySnapshot] AS       
/* UPDATE SNAPSHOT WITH LATEST TS SET OF CHANGES */    
/* DEFINED TO BE ONE DATE IN MERGE TABLE EACH TIME PRODCURE IS CALLED */    
    
BEGIN      
	SET NOCOUNT ON     

	/* GET DEFAULT VALUES FROM PREVIOUS ROW AND MAKE NULLABLE FIELD 0 */   
	EXEC [ETL].[UpdateFactEquitySnapshotHelper]

	    
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
			--DateID = E.DateID,      
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
			MarketID = E.MarketID,      
			TotalSharesInIssue = E.TotalSharesInIssue,      
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
			ISEQ20Shares = E.ISEQ20Shares,      
			/* Use LTP if ISEQ20Price (from file) has not been populated yet */
			ISEQ20Price = ISNULL(E.ISEQ20Price, IIF(E.ISEQ20IndexYN='Y',E.LTP,NULL)),
			ISEQ20Weighting = E.ISEQ20Weighting,      
			ISEQ20MarketCap = E.ISEQ20MarketCap,      
			ISEQ20FreeFloat = E.ISEQ20FreeFloat,      
			ISEQOverallWeighting = E.ISEQOverallWeighting,      
			ISEQOverallMarketCap = E.TotalSharesInIssue * E.ISEQOverallFreefloat * E.ISEQOverallPrice,     
			ISEQOverallBeta30 = E.ISEQOverallBeta30,      
			ISEQOverallBeta250 = E.ISEQOverallBeta250,      
			ISEQOverallFreefloat = E.ISEQOverallFreefloat,      
			ISEQOverallPrice = E.ISEQOverallPrice,      
			ISEQOverallShares = E.ISEQOverallShares,      
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
			LseTurnover = E.LseTurnover,     
			LseVolume = E.LseVolume,     
			ETFFMShares = E.ETFFMShares,     
			BatchID = E.BatchID      
		FROM      
				DWH.FactEquitySnapshot DWH      
			INNER JOIN      
				DWH.DimInstrumentEquity I      
			ON DWH.InstrumentID = I.InstrumentID      
			INNER JOIN		      
				ETL.FactEquitySnapshotMerge E      
			ON       
				I.InstrumentGlobalID = E.InstrumentGlobalID    
			AND      
				DWH.DateID = E.DateID      
	END    
	ELSE    
	BEGIN    
		/* UPDATING AN OLDER SNAPSHOT */    
		/* Only update some fields */      
      
		UPDATE      
			DWH      
		SET      
			--InstrumentID = E.CurrentInstrumentID,      
			--InstrumentStatusID = E.InstrumentStatusID,      
			--DateID = E.DateID,      
			--LastExDivDateID = E.LastExDivDateID,      
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
			MarketID = E.MarketID,      
			--TotalSharesInIssue = E.TotalSharesInIssue,      
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
			/* Probably not...    
			ISEQ20Shares = E.ISEQ20Shares,      
			ISEQ20Price = E.ISEQ20Price,      
			ISEQ20Weighting = E.ISEQ20Weighting,      
			ISEQ20MarketCap = E.ISEQ20MarketCap,      
			ISEQ20FreeFloat = E.ISEQ20FreeFloat,      
			ISEQOverallWeighting = E.ISEQOverallWeighting,      
			ISEQOverallMarketCap = E.TotalSharesInIssue * E.ISEQOverallFreefloat * E.ISEQOverallPrice,     
			ISEQOverallBeta30 = E.ISEQOverallBeta30,      
			ISEQOverallBeta250 = E.ISEQOverallBeta250,      
			ISEQOverallFreefloat = E.ISEQOverallFreefloat,      
			ISEQOverallPrice = E.ISEQOverallPrice,      
			ISEQOverallShares = E.ISEQOverallShares,      
			*/    
			/* From XT ....    
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
			*/    
			LseTurnover = E.LseTurnover,     
			LseVolume = E.LseVolume,     
			ETFFMShares = E.ETFFMShares,     
   
			BatchID = E.BatchID      
		FROM      
				DWH.FactEquitySnapshot DWH      
			INNER JOIN      
				DWH.DimInstrumentEquity I      
			ON DWH.InstrumentID = I.InstrumentID      
			INNER JOIN		      
				ETL.FactEquitySnapshotMerge E      
			ON       
				I.InstrumentGlobalID = E.InstrumentGlobalID    
			AND      
				DWH.DateID = E.DateID      
	    
	    
	END    
	      



	INSERT INTO      
			DWH.FactEquitySnapshot      
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
			TotalSharesInIssue,      
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
			ISEQ20Shares,      
			ISEQ20Price,      
			ISEQ20Weighting,      
			ISEQ20MarketCap,      
			ISEQ20FreeFloat,      
			ISEQOverallWeighting,      
			ISEQOverallMarketCap,      
			ISEQOverallBeta30,      
			ISEQOverallBeta250,      
			ISEQOverallFreefloat,      
			ISEQOverallPrice,      
			ISEQOverallShares,      
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
			LseTurnover,     
			LseVolume,     
			ETFFMShares,     
			BatchID      
		)      
		SELECT      
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
			OcpDateTime,    
			MarketID,      
			TotalSharesInIssue,      
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
			ISEQ20Shares,      
			/* Use LTP if ISEQ20Price (from file) has not been populated yet */
			ISEQ20Price = ISNULL(E.ISEQ20Price, IIF(E.ISEQ20IndexYN='Y',E.LTP,NULL)),
			ISEQ20Weighting,      
			ISEQ20MarketCap,      
			ISEQ20FreeFloat,      
			ISEQOverallWeighting,      
			TotalSharesInIssue * ISEQOverallFreefloat * ISEQOverallPrice,     
			ISEQOverallBeta30,      
			ISEQOverallBeta250,      
			ISEQOverallFreefloat,      
			ISEQOverallPrice,      
			ISEQOverallShares,      
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
			LseTurnover,     
			LseVolume,     
			ETFFMShares,     
			BatchID      
		FROM      
				ETL.FactEquitySnapshotMerge E      
		WHERE      
			NOT EXISTS (      
					SELECT      
						*      
					FROM	      
							DWH.FactEquitySnapshot DWH      
						INNER JOIN      
							DWH.DimInstrumentEquity I      
						ON DWH.InstrumentID = I.InstrumentID      
					WHERE      
							I.InstrumentGlobalID = E.InstrumentGlobalID    
						AND      
							DWH.DateID = E.DateID      
				)			      
      

	/* UPDATE IssuedSharesToday */ 
 
	UPDATE    
		DWH    
	SET    
		IssuedSharesToday = DWH.TotalSharesInIssue - PREV.TotalSharesInIssue    
	FROM    
			DWH.FactEquitySnapshot DWH     
		INNER JOIN     
			DWH.DimInstrumentEquity I     
		ON DWH.InstrumentID = I.InstrumentID     
		CROSS APPLY (    
					SELECT    
						TOP 1    
						DWH_Inside.TotalSharesInIssue    
					FROM    
							DWH.FactEquitySnapshot DWH_Inside 
						INNER JOIN     
							DWH.DimInstrumentEquity I_Inside    
						ON DWH_Inside.InstrumentID = I_Inside.InstrumentID     
					WHERE    
							I.InstrumentGlobalID = I_Inside.InstrumentGlobalID 
						AND 
							DWH_Inside.TotalSharesInIssue IS NOT NULL    
						AND    
							DWH.DateID > DWH_Inside.DateID    
					ORDER BY    
						DWH_Inside.DateID DESC    
				) AS PREV    
	WHERE
		DWH.DateID = @DateID
			    
END      
    
    
GO
