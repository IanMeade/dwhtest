/* 
Run this script on: 
 
        T7-SYS-DW-01.DWH    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.DWH 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 21/06/2017 17:12:13 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [DWH]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[UpdateFactEtfSnapshotHelper]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 21/6/2017 
-- Description:	Prepare FactEtfSnapshotMerge table - default values etc... 
-- ============================================= 
CREATE PROCEDURE [ETL].[UpdateFactEtfSnapshotHelper] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	/* GET THE DATE AGGREGATION IS RUN FOR - DEFINED TO BE ONE DAY IN EACH PROCEDURE CALL */     
	DECLARE @DateID AS INT     
	SELECT     
		@DateID = MAX(AggregationDateID)     
	FROM     
		ETL.FactEtfSnapshotMerge   
 
	/* GET PREVIOUS ROWS - FOR DEFAULT VALUES USED IN FIRST ROW PER DAY */      
	SELECT 
		DWH.EtfSnapshotID, 
		I.InstrumentGlobalID 
	INTO 
		#PreviousRows 
	FROM 
		( 
			SELECT 
				InstrumentGlobalID, 
				MAX(DateID)	AS DateID 
			FROM 
					DWH.FactEtfSnapshot DWH      
				INNER JOIN      
					DWH.DimInstrumentEtf I      
				ON DWH.InstrumentID = I.InstrumentID      
			WHERE 
				DWH.DateID < 20170621 
			GROUP BY 
				InstrumentGlobalID 
		) AS Prev 
		INNER JOIN 
			DWH.FactEtfSnapshot DWH      
		ON DWH.DateID = Prev.DateID 
		INNER JOIN      
			DWH.DimInstrumentEtf I  
		ON Prev.InstrumentGlobalID = I.InstrumentGlobalID 
		AND DWH.InstrumentID = I.InstrumentID      
 
	UPDATE 
		ETL 
	SET 
		/* FROM YESTERDAY */ 
		OCPDateID = COALESCE( ETL.OCPDateID, SN.OCPDateID), 
		OCPTimeID = COALESCE( ETL.OCPTimeID, SN.OCPTimeID), 
		OCPTime = COALESCE( ETL.OCPTime, SN.OCPTime), 
		UtcOCPTime = COALESCE( ETL.UtcOCPTime, SN.UtcOCPTime), 
		LTPDateID = COALESCE( ETL.LTPDateID, SN.LTPDateID), 
		LTPTimeID = COALESCE( ETL.LTPTimeID, SN.LTPTimeID), 
		LTPTime = COALESCE( ETL.LTPTime, SN.LTPTime), 
		UtcLTPTime = COALESCE( ETL.UtcLTPTime, SN.UtcLTPTime), 
		OpenPrice = COALESCE( ETL.OpenPrice, SN.OpenPrice), 
		LowPrice = COALESCE( ETL.LowPrice, SN.LowPrice), 
		HighPrice = COALESCE( ETL.HighPrice, SN.HighPrice), 
		LastPrice = COALESCE( ETL.LastPrice, SN.LTP), 
 
		/* MAKE NULLABLE FIELD 0 */  
		Turnover = ISNULL( ETL.Turnover, 0),     
		TurnoverND = ISNULL( ETL.TurnoverND, 0),     
		TurnoverEur = ISNULL( ETL.TurnoverEur, 0),      
		TurnoverNDEur = ISNULL( ETL.TurnoverNDEur, 0),      
		TurnoverOB = ISNULL( ETL.TurnoverOB, 0),      
		TurnoverOBEur = ISNULL( ETL.TurnoverOBEur, 0),      
		Volume = ISNULL( ETL.Volume, 0),      
		VolumeND = ISNULL( ETL.VolumeND, 0),      
		VolumeOB = ISNULL( ETL.VolumeOB, 0),      
		Deals = ISNULL( ETL.Deals, 0),      
		DealsOB = ISNULL( ETL.DealsOB, 0),      
		DealsND = ISNULL( ETL.DealsND, 0)    
 
	FROM 
			ETL.FactEtfSnapshotMerge ETL 
		LEFT OUTER JOIN 
			#PreviousRows PR 
		ON ETL.InstrumentGlobalID = ETL.InstrumentGlobalID 
		LEFT OUTER JOIN 
			DWH.FactEtfSnapshot SN 
		ON PR.EtfSnapshotID = SN.EtfSnapshotID   
 
	DROP TABLE #PreviousRows 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[FactEquityIndexPrep]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [ETL].[FactEquityIndexPrep] ALTER COLUMN [IndexCode] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[UpdateFactEquitySnapshotHelper]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 21/6/2017 
-- Description:	Prepare FactEquitySnapshotMerge table - default values etc... 
-- ============================================= 
CREATE PROCEDURE [ETL].[UpdateFactEquitySnapshotHelper] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	/* GET THE DATE AGGREGATION IS RUN FOR - DEFINED TO BE ONE DAY IN EACH PROCEDURE CALL */     
	DECLARE @DateID AS INT     
	SELECT     
		@DateID = MAX(DateID)     
	FROM     
		ETL.FactEquitySnapshotMerge   
 
	/* GET PREVIOUS ROWS - FOR DEFAULT VALUES USED IN FIRST ROW PER DAY */      
	SELECT 
		DWH.EquitySnapshotID, 
		I.InstrumentGlobalID 
	INTO 
		#PreviousRows 
	FROM 
		( 
			SELECT 
				InstrumentGlobalID, 
				MAX(DateID)	AS DateID 
			FROM 
					DWH.FactEquitySnapshot DWH      
				INNER JOIN      
					DWH.DimInstrumentEquity I      
				ON DWH.InstrumentID = I.InstrumentID      
			WHERE 
				DWH.DateID < 20170621 
			GROUP BY 
				InstrumentGlobalID 
		) AS Prev 
		INNER JOIN 
			DWH.FactEquitySnapshot DWH      
		ON DWH.DateID = Prev.DateID 
		INNER JOIN      
			DWH.DimInstrumentEquity I  
		ON Prev.InstrumentGlobalID = I.InstrumentGlobalID 
		AND DWH.InstrumentID = I.InstrumentID      
 
	UPDATE 
		ETL 
	SET 
		/* FROM YESTERDAY */ 
		OCPDateID = COALESCE( ETL.OCPDateID, SN.OCPDateID), 
		OCPTimeID = COALESCE( ETL.OCPTimeID, SN.OCPTimeID), 
		OCPTime = COALESCE( ETL.OCPTime, SN.OCPTime), 
		UtcOCPTime = COALESCE( ETL.UtcOCPTime, SN.UtcOCPTime), 
		LTPDateID = COALESCE( ETL.LTPDateID, SN.LTPDateID), 
		LTPTimeID = COALESCE( ETL.LTPTimeID, SN.LTPTimeID), 
		LTPTime = COALESCE( ETL.LTPTime, SN.LTPTime), 
		UtcLTPTime = COALESCE( ETL.UtcLTPTime, SN.UtcLTPTime), 
		OpenPrice = COALESCE( ETL.OpenPrice, SN.OpenPrice), 
		LowPrice = COALESCE( ETL.LowPrice, SN.LowPrice), 
		HighPrice = COALESCE( ETL.HighPrice, SN.HighPrice), 
		LTP = COALESCE( ETL.LTP, SN.LTP), 
 
		/* MAKE NULLABLE FIELD 0 */  
		Turnover = ISNULL( ETL.Turnover, 0),     
		TurnoverND = ISNULL( ETL.TurnoverND, 0),     
		TurnoverEur = ISNULL( ETL.TurnoverEur, 0),      
		TurnoverNDEur = ISNULL( ETL.TurnoverNDEur, 0),      
		TurnoverOB = ISNULL( ETL.TurnoverOB, 0),      
		TurnoverOBEur = ISNULL( ETL.TurnoverOBEur, 0),      
		Volume = ISNULL( ETL.Volume, 0),      
		VolumeND = ISNULL( ETL.VolumeND, 0),      
		VolumeOB = ISNULL( ETL.VolumeOB, 0),      
		Deals = ISNULL( ETL.Deals, 0),      
		DealsOB = ISNULL( ETL.DealsOB, 0),      
		DealsND = ISNULL( ETL.DealsND, 0)    
 
	FROM 
			ETL.FactEquitySnapshotMerge ETL 
		LEFT OUTER JOIN 
			#PreviousRows PR 
		ON ETL.InstrumentGlobalID = ETL.InstrumentGlobalID 
		LEFT OUTER JOIN 
			DWH.FactEquitySnapshot SN 
		ON PR.EquitySnapshotID = SN.EquitySnapshotID   
 
	DROP TABLE #PreviousRows 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[UpdateFactEquitySnapshot]'
GO
       
ALTER PROCEDURE [ETL].[UpdateFactEquitySnapshot] AS        
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
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[UpdateFactEtfSnapshot]'
GO
     
      
ALTER PROCEDURE [ETL].[UpdateFactEtfSnapshot]     
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
	 
			--ExCapYN = E.ExCapYN,      
			--ExEntitlementYN = E.ExEntitlementYN,      
			--ExRightsYN = E.ExRightsYN,      
			--ExSpecialYN = E.ExSpecialYN,      
		*/ 
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
	/*		@WisdomTreeUpdates U     
		INNER JOIN     
	*/ 
			DWH.FactEtfSnapshot DWH      
	/* 
		ON U.EtfSnapshotID = DWH.EtfSnapshotID     
	*/ 
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
		I.ISIN <> @WISDOM_ISIN     
	AND 
		DWH.DateID = @DateID 
			     
     
END      
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[AggrgeateFactEquityIndex]'
GO
-- =============================================     
-- Author:		Ian Meade     
-- Create date: 25/4/2017     
-- Description:	Aggregate the Equity Indexes - for upodate to FactEquityIndexSnapshot     
--				Note: cannot call storted proecedure dirrectly from SSIS due to meta-data issue - populating tbale for next step     
-- =============================================     
ALTER PROCEDURE [ETL].[AggrgeateFactEquityIndex]     
	@IndexDateID INT,  
	@ExpectedTime DATETIME  
AS     
BEGIN     
	SET NOCOUNT ON;     
     
	DECLARE @TimeID INT   
  
	SELECT  
		@TimeID = CAST(LEFT(REPLACE( CONVERT(CHAR, @ExpectedTime, 114), ':', ''),4) AS INT)  
  
  
   /* FIND LAST INDX SAMPLE FOR REQUIRED DATE */  
  
	SELECT  
		MAX(EquityIndexID) AS EquityIndexID  
	INTO     
		#Samples     
	FROM  
		DWH.FactEquityIndex  
	WHERE  
		IndexDateID = @IndexDateID  
	AND  
		IndexTimeID = (  
					SELECT				  
						MAX(IndexTimeID)  
					FROM  
						DWH.FactEquityIndex  
					WHERE  
						IndexDateID = @IndexDateID  
					AND  
						IndexTimeID < @TimeID  
				);  
  
	 /* Get Open values in #FIRST tmep table */    
	 /* Get Last & Return in #LAST tnep table */    
	 /* Gets gih and low in #AGG temp table */    
      
	WITH RowBased AS (     
			SELECT     
				I.IndexDateID,     
				OverallOpen,     
				FinancialOpen,     
				GeneralOpen,     
				SmallCapOpen,     
				ITEQOpen,     
				ISEQ20Open,     
				ISEQ20INAVOpen,     
				ESMopen,     
				ISEQ20InverseOpen,     
				ISEQ20LeveragedOpen,     
				ISEQ20CappedOpen     
			FROM     
					DWH.FactEquityIndex I     
				INNER JOIN     
					#Samples S     
				ON     
					I.EquityIndexID = S.EquityIndexID    
			)     
		SELECT     
			IndexDateID,     
			'IEOP' AS IndexCode,     
			OverallOpen AS OpenValue     
		INTO      
			#FIRST     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEUP' AS IndexCode,     
			FinancialOpen AS OpenValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEQP' AS IndexCode,     
			GeneralOpen AS OpenValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEYP' AS IndexCode,     
			SmallCapOpen AS OpenValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEEP' AS IndexCode,     
			ISEQ20Open AS OpenValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEOA' AS IndexCode,     
			ESMopen AS OpenValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEOD' AS IndexCode,     
			ISEQ20InverseOpen AS OpenValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEOC' AS IndexCode,     
			ISEQ20LeveragedOpen AS OpenValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IE0E' AS IndexCode,     
			ISEQ20CappedOpen AS OpenValue     
		FROM     
			RowBased;     
     
	WITH RowBased AS (     
			SELECT     
				I.IndexDateID,     
				OverallLast,     
				FinancialLast,     
				GeneralLast,     
				SmallCapLast,     
				ITEQLast,     
				ISEQ20Last,     
				ISEQ20INAVLast,     
				ESMLast,     
				ISEQ20InverseLast,     
				ISEQ20LeveragedLast,     
				ISEQ20CappedLast,     
				OverallReturn,     
				FinancialReturn,     
				GeneralReturn,     
				SmallCapReturn,     
				ITEQReturn,     
				ISEQ20Return,     
				NULL AS ISEQ20INAVReturn,     
				ESMReturn,     
				ISEQ20InverseReturn,     
				ISEQ20CappedReturn     
			FROM     
					DWH.FactEquityIndex I     
				INNER JOIN     
					#Samples S     
				ON I.EquityIndexID = S.EquityIndexID     
			)     
		SELECT     
			IndexDateID,     
			'IEOP' AS IndexCode,     
			OverallLast AS LastValue,     
			OverallReturn AS ReturnValue     
		INTO #LAST     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEUP' AS IndexCode,     
			FinancialLast AS LastValue,     
			FinancialReturn AS ReturnValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEQP' AS IndexCode,     
			GeneralLast AS LastValue,     
			GeneralReturn AS ReturnValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEYP' AS IndexCode,     
			SmallCapLast AS LastValue,     
			SmallCapReturn AS ReturnValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEEP' AS IndexCode,     
			ISEQ20Last AS LastValue,     
			ISEQ20Return AS ReturnValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEOA' AS IndexCode,     
			ESMLast AS LastValue,     
			ESMReturn AS ReturnValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEOD' AS IndexCode,     
			ISEQ20InverseLast AS LastValue,     
			ISEQ20InverseReturn AS ReturnValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEOC' AS IndexCode,     
			ISEQ20LeveragedLast AS LastValue,     
			NULL AS ReturnValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEOE' AS IndexCode,     
			ISEQ20CappedLast AS LastValue,     
			ISEQ20CappedReturn AS ReturnValue     
		FROM     
			RowBased;     
     
     
	/* HIGHEST AND HighEST */     
	WITH RowBased AS (     
			SELECT     
				IndexDateID,     
				(OverallLast) OverallDailyLow,     
				(FinancialLast) FinancialDailyLow,     
				(GeneralLast) GeneralDailyLow,     
				(SmallCapLast) SamllCapDailyLow,     
				(ITEQLast) ITEQDailyLow,     
				(ISEQ20Last) ISEQ20DailyLow,     
				(ISEQ20INAVLast) ISEQ20INAVDailyLow,     
				(ESMLast) ESMDailyLow,     
				(ISEQ20InverseLast) ISEQ20InverseDailyLow,     
				(ISEQ20LeveragedLast) ISEQ20LeveragedDailyLow,     
				(ISEQ20CappedLast) ISEQ20CappedDailyLow,     
     
				(OverallLast) OverallDailyHigh,     
				(FinancialLast) FinancialDailyHigh,     
				(GeneralLast) GeneralDailyHigh,     
				(SmallCapLast) SamllCapDailyHigh,     
				(ITEQLast) ITEQDailyHigh,     
				(ISEQ20Last) ISEQ20DailyHigh,     
				(ISEQ20INAVLast) ISEQ20INAVDailyHigh,     
				(ESMLast) ESMDailyHigh,     
				(ISEQ20InverseLast) ISEQ20InverseDailyHigh,     
				(ISEQ20LeveragedLast) ISEQ20LeveragedDailyHigh,     
				(ISEQ20CappedLast) ISEQ20CappedDailyHigh     
			FROM     
					DWH.FactEquityIndex I     
				INNER JOIN     
					#Samples S     
				ON I.EquityIndexID = S.EquityIndexID   
		)     
		SELECT     
			IndexDateID,     
			'IEOP' AS IndexCode,     
			OverallDailyLow AS DailyLowValue,     
			OverallDailyHigh AS DailyHighValue     
		INTO #AGG     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEUP' AS IndexCode,     
			FinancialDailyLow AS DailyLowValue,     
			FinancialDailyHigh AS DailyHighValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEQP' AS IndexCode,     
			GeneralDailyLow AS DailyLowValue,     
			GeneralDailyHigh AS DailyHighValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEYP' AS IndexCode,     
			SamllCapDailyLow AS DailyLowValue,     
			SamllCapDailyHigh AS DailyHighValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEEP' AS IndexCode,     
			ISEQ20DailyLow AS DailyLowValue,     
			ISEQ20DailyHigh AS DailyHighValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEOA' AS IndexCode,     
			ESMDailyLow AS DailyLowValue,     
			ESMDailyHigh AS DailyHighValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEOD' AS IndexCode,     
			ISEQ20InverseDailyLow AS DailyLowValue,     
			ISEQ20InverseDailyHigh AS DailyHighValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEOC' AS IndexCode,     
			ISEQ20LeveragedDailyLow AS DailyLowValue,     
			ISEQ20LeveragedDailyHigh AS DailyHighValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEOE' AS IndexCode,     
			ISEQ20CappedDailyLow AS DailyLowValue,     
			ISEQ20CappedDailyHigh AS DailyHighValue     
		FROM     
			RowBased;     
     
	TRUNCATE TABLE ETL.FactEquityIndexPrep     
     
	INSERT INTO     
			ETL.FactEquityIndexPrep     
		(     
			IndexDateID,     
			IndexCode,     
			OpenValue,     
			LastValue,     
			ReturnValue,     
			DailyLowValue,     
			DailyHighValue     
		)     
		SELECT     
			F.IndexDateID,     
			F.IndexCode,     
			F.OpenValue,     
			L.LastValue,     
			L.ReturnValue,     
			A.DailyLowValue,     
			A.DailyHighValue     
		FROM     
				#FIRST F     
			INNER JOIN     
				#LAST L     
			ON F.IndexDateID = L.IndexDateID     
			AND F.IndexCode = L.IndexCode     
			INNER JOIN     
				#AGG A     
			ON F.IndexDateID = A.IndexDateID     
			AND F.IndexCode = A.IndexCode     
 
SELECT * 		from	ETL.FactEquityIndexPrep     
 
   
 
	DROP TABLE #Samples     
	DROP TABLE #FIRST     
	DROP TABLE #LAST     
	DROP TABLE #AGG     
     
END     
     
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[GetInstrumentEquityAtDate]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 20/6/2017 
-- Description:	To support Equity / Etf snapshots 
-- ============================================= 
CREATE FUNCTION [ETL].[GetInstrumentEquityAtDate] 
(	 
	@Date DATE 
) 
RETURNS TABLE  
AS 
RETURN  
( 
	SELECT
		*
	FROM
		DWH.DimInstrumentEquity
	WHERE
		InstrumentID IN (
					SELECT
						MAX(InstrumentID) InstrumentID
					FROM
						DWH.DimInstrumentEquity
					WHERE
						StartDate <= @Date
					GROUP BY
						InstrumentGlobalID
				) 
 
) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[GetInstrumentEtfAtDate]'
GO
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 20/6/2017 
-- Description:	To support Equity / Etf snapshots 
-- ============================================= 
CREATE FUNCTION [ETL].[GetInstrumentEtfAtDate] 
(	 
	@Date DATE 
) 
RETURNS TABLE  
AS 
RETURN  
( 
	SELECT 
		* 
	FROM 
		DWH.DimInstrumentEtf 
	WHERE 
		InstrumentID IN ( 
					SELECT 
						MAX(InstrumentID) InstrumentID 
					FROM 
						DWH.DimInstrumentEtf 
					WHERE 
						StartDate <= @Date 
					GROUP BY 
						InstrumentGlobalID 
				) 
 
) 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[ValidateT7EarlyFacts]'
GO
 
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 8/3/2017   
-- Description: Validate T7TradeMainDataFlowOutput - warnigns about inferred entries in DWH dimensions - warning only 
-- =============================================   
CREATE PROCEDURE [ETL].[ValidateT7EarlyFacts] 
AS   
BEGIN   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
	 
	SELECT 
		27 AS Code, 
		'Early arrvng facts found in Equity Junk Dimension - review MDM for dimension row [' + STR(EquityTradeJunkID) + ']' AS Message 
	FROM 
		DWH.DimEquityTradeJunk 
	WHERE 
		Inferred = 'Y' 
 
   
END   
  
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT 
SET @Success = 1 
SET NOEXEC OFF 
IF (@Success = 1) PRINT 'The database update succeeded' 
ELSE BEGIN 
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION 
	PRINT 'The database update failed' 
END
GO
