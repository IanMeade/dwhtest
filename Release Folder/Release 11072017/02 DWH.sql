/* 
Run this script on: 
 
        T7-DDT-07.DWH    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.DWH 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 11/07/2017 15:12:08 
 
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
PRINT N'Dropping index [FactEquityTradeNonClusteredColumnStoreIndex] from [DWH].[FactEquityTrade]'
GO
DROP INDEX [FactEquityTradeNonClusteredColumnStoreIndex] ON [DWH].[FactEquityTrade]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [ETL].[EtfVolume]'
GO
DROP VIEW [ETL].[EtfVolume]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [ETL].[EquityVolume]'
GO
DROP VIEW [ETL].[EquityVolume]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[UpdateFactEtfSnapshotHelper]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 21/6/2017  
-- Description:	Prepare FactEtfSnapshotMerge table - default values etc...  
-- =============================================  
ALTER PROCEDURE [ETL].[UpdateFactEtfSnapshotHelper]  
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
		I.InstrumentGlobalID,  
		DWH.DateID  
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
				DWH.DateID < @DateID  
			GROUP BY  
				InstrumentGlobalID  
		) AS Prev  
		INNER JOIN       
			DWH.DimInstrumentEtf I   
		ON Prev.InstrumentGlobalID = I.InstrumentGlobalID  
		INNER JOIN  
			DWH.FactEtfSnapshot DWH       
		ON DWH.DateID = Prev.DateID  
		AND DWH.InstrumentID = I.InstrumentID       
  
  
	UPDATE  
		ETL  
	SET  
		/* FROM YESTERDAY */  
		OCPDateID = COALESCE( ETL.OCPDateID, SN.OCPDateID),  
		OCPTimeID = COALESCE( ETL.OCPTimeID, SN.OCPTimeID),  
		OCPDateTime = COALESCE( ETL.OCPDateTime, SN.OCPDateTime),  
		OCPTime = COALESCE( ETL.OCPTime, SN.OCPTime),  
		OCP = COALESCE( ETL.OCP, SN.OCP),  
		UtcOCPTime = COALESCE( ETL.UtcOCPTime, SN.UtcOCPTime),  
		LTPDateID = COALESCE( ETL.LTPDateID, SN.LTPDateID),  
		LTPTimeID = COALESCE( ETL.LTPTimeID, SN.LTPTimeID),  
		LtpDateTime = COALESCE( ETL.LtpDateTime, SN.LtpDateTime),  
		LTPTime = COALESCE( ETL.LTPTime, SN.LTPTime),  
		UtcLTPTime = COALESCE( ETL.UtcLTPTime, SN.UtcLTPTime),  
		LastPrice = COALESCE( ETL.LastPrice, SN.LTP),  
 
		/* CAN BE REPLACED WITH VALUE FROM ODS */ 
		--TotalSharesInIssue = COALESCE( ETL.TotalSharesInIssue, SN.TotalSharesInIssue),  
  
		/* SHOULD BE SOMETHING ELSE */  
		OpenPrice = COALESCE( ETL.OpenPrice, SN.OCP),  
		LowPrice = COALESCE( ETL.LowPrice, ETL.OpenPrice, SN.OCP),  
		HighPrice = COALESCE( ETL.HighPrice, ETL.OpenPrice, SN.OCP),  
  
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
		DealsND = ISNULL( ETL.DealsND, 0),  
  
		/* ETF Only - CALCULAED BY NEXT STAGE IF DATA IS AVAILABLE */  
		NAV = ISNULL(SN.NAV, 0),  
		NAVCalcDateID = ISNULL(SN.NAVCalcDateID,-1) 
  
	FROM  
			ETL.FactEtfSnapshotMerge ETL  
		INNER JOIN  
			#PreviousRows PR  
		ON ETL.InstrumentGlobalID = PR.InstrumentGlobalID  
		INNER JOIN  
			DWH.FactEtfSnapshot SN  
		ON PR.EtfSnapshotID = SN.EtfSnapshotID    
  
 
 	/* SPEICAL CASE FOR NEW SHARES */ 
	 
	/* IssuedSharesToday IS TotalSharesInIssue */  
	UPDATE 
		ETL.FactEquitySnapshotMerge 
	SET 
		IssuedSharesToday = TotalSharesInIssue		 
	WHERE 
		InstrumentGlobalID NOT IN ( 
			SELECT 
				InstrumentGlobalID 
			FROM 
				#PreviousRows  
			) 
 
 
	/* LAST CHANCE SALON */ 
	UPDATE 
		ETL.FactEtfSnapshotMerge 
	SET 
		NAV = ISNULL(NAV, 0),  
		NAVCalcDateID = ISNULL(NAVCalcDateID,-1) 
 
 
	DROP TABLE #PreviousRows  
END  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[UpdateFactEquitySnapshotHelper]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 21/6/2017 
-- Description:	Prepare FactEquitySnapshotMerge table - default values etc... 
-- ============================================= 
ALTER PROCEDURE [ETL].[UpdateFactEquitySnapshotHelper] 
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
		I.InstrumentGlobalID, 
		DWH.DateID 
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
				DWH.DateID < @DateID 
			GROUP BY 
				InstrumentGlobalID 
		) AS Prev 
		INNER JOIN      
			DWH.DimInstrumentEquity I  
		ON Prev.InstrumentGlobalID = I.InstrumentGlobalID 
		INNER JOIN 
			DWH.FactEquitySnapshot DWH      
		ON DWH.DateID = Prev.DateID 
		AND DWH.InstrumentID = I.InstrumentID      
 
 
	UPDATE 
		ETL 
	SET 
		/* FROM YESTERDAY */ 
		OCPDateID = COALESCE( ETL.OCPDateID, SN.OCPDateID), 
		OCPTimeID = COALESCE( ETL.OCPTimeID, SN.OCPTimeID), 
		OCPDateTime = COALESCE( ETL.OCPDateTime, SN.OCPDateTime), 
		OCPTime = COALESCE( ETL.OCPTime, SN.OCPTime), 
		OCP = COALESCE( ETL.OCP, SN.OCP), 
		UtcOCPTime = COALESCE( ETL.UtcOCPTime, SN.UtcOCPTime), 
		LTPDateID = COALESCE( ETL.LTPDateID, SN.LTPDateID), 
		LTPTimeID = COALESCE( ETL.LTPTimeID, SN.LTPTimeID), 
		LtpDateTime = COALESCE( ETL.LtpDateTime, SN.LtpDateTime), 
		LTPTime = COALESCE( ETL.LTPTime, SN.LTPTime), 
		UtcLTPTime = COALESCE( ETL.UtcLTPTime, SN.UtcLTPTime), 
		LTP = COALESCE( ETL.LTP, SN.LTP), 
		ISEQ20Shares = COALESCE( ETL.ISEQ20Shares, SN.ISEQ20Shares), 
		ISEQ20Price = COALESCE( ETL.ISEQ20Price, SN.ISEQ20Price), 
		ISEQ20Weighting = COALESCE( ETL.ISEQ20Weighting, SN.ISEQ20Weighting), 
		ISEQOverallWeighting = COALESCE( ETL.ISEQOverallWeighting, SN.ISEQOverallWeighting), 
		ISEQOverallBeta30 = COALESCE( ETL.ISEQOverallBeta30, SN.ISEQOverallBeta30), 
		ISEQOverallBeta250 = COALESCE( ETL.ISEQOverallBeta250, SN.ISEQOverallBeta250), 
		ISEQOverallPrice = COALESCE( ETL.ISEQOverallPrice, SN.ISEQOverallPrice), 
		ISEQOverallShares = COALESCE( ETL.ISEQOverallShares, SN.ISEQOverallShares), 
		ISEQ20CappedShares = COALESCE( ETL.ISEQ20CappedShares, SN.ISEQ20CappedShares), 
		ETFFMShares = COALESCE( ETL.ETFFMShares, SN.ETFFMShares), 
 
		/* SHOULD BE SOMETHING ELSE */ 
		OpenPrice = COALESCE( ETL.OpenPrice, SN.OCP), 
		LowPrice = COALESCE( ETL.LowPrice, ETL.OpenPrice, SN.OCP), 
		HighPrice = COALESCE( ETL.HighPrice, ETL.OpenPrice, SN.OCP), 
 
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
		DealsND = ISNULL( ETL.DealsND, 0), 
		LseTurnover = ISNULL( ETL.LseTurnover, 0), 
		LseVolume  = ISNULL( ETL.LseVolume, 0), 
 
		/* NO LAST EX FIV DATE */ 
		LastExDivDateID = ISNULL( ETL.LastExDivDateID, -1)  
 
	FROM 
			ETL.FactEquitySnapshotMerge ETL 
		INNER JOIN 
			#PreviousRows PR 
		ON ETL.InstrumentGlobalID = PR.InstrumentGlobalID 
		INNER JOIN 
			DWH.FactEquitySnapshot SN 
		ON PR.EquitySnapshotID = SN.EquitySnapshotID   
 
 
	/* SPEICAL CASE FOR NEW SHARES */ 
	 
	/* IssuedSharesToday IS TotalSharesInIssue */  
	UPDATE 
		ETL.FactEquitySnapshotMerge 
	SET 
		IssuedSharesToday = TotalSharesInIssue		 
	WHERE 
		InstrumentGlobalID NOT IN ( 
			SELECT 
				InstrumentGlobalID 
			FROM 
				#PreviousRows  
			) 
 
 
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
 
 
	/* Set MarketCap values */ 
 
	/* Market cap after stats are loaded */ 
	UPDATE 
		ETL.FactEquitySnapshotMerge   
	SET 
		ISEQOverallMarketCap = ISEQOverallPrice * ISEQOverallShares * ISEQOverallFreeFloat, 
		ISEQ20CappedMarketCap = ISEQOverallPrice * ISEQ20CappedShares * ISEQOverallFreeFloat, 
		/* this comes from the iseq 20 stats file - adding extra if its possible stats havve loaded but not iseq 20 stats */ 
		ISEQ20MarketCap = COALESCE(ISEQ20MarketCap, COALESCE(RestrictedLastTradePrice, ISEQOverallPrice ) * ISEQ20Shares * ISEQOverallFreeFloat) 
	WHERE 
		StatsLoaded = 'Y' 
 
	/* Market cap before stats are loaded */ 
	UPDATE 
		ETL.FactEquitySnapshotMerge   
	SET 
		ISEQOverallMarketCap = COALESCE(RestrictedLastTradePrice, ISEQOverallPrice ) * ISEQOverallShares * ISEQOverallFreeFloat, 
		ISEQ20CappedMarketCap = COALESCE(RestrictedLastTradePrice, ISEQOverallPrice ) * ISEQ20CappedShares * ISEQOverallFreeFloat, 
		ISEQ20MarketCap = COALESCE(RestrictedLastTradePrice, ISEQOverallPrice ) * ISEQ20Shares * ISEQOverallFreeFloat 
	WHERE 
		ISNULL(StatsLoaded, 'N') <> 'Y' 
 
 
	     
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
			ISEQ20CappedMarketCap = E.ISEQ20CappedMarketCap, 
			ISEQ20FreeFloat = E.ISEQ20FreeFloat,       
			ISEQOverallWeighting = E.ISEQOverallWeighting,       
			ISEQOverallMarketCap = E.ISEQOverallMarketCap,      
			ISEQOverallBeta30 = E.ISEQOverallBeta30,       
			ISEQOverallBeta250 = E.ISEQOverallBeta250,       
			ISEQOverallFreefloat = E.ISEQOverallFreefloat,       
			ISEQOverallPrice = E.ISEQOverallPrice,       
			ISEQOverallShares = E.ISEQOverallShares,       
			ISEQ20CappedShares = E.ISEQ20CappedShares, 
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
			ISEQ20Shares = E.ISEQ20Shares,       
			ISEQ20Price = E.ISEQ20Price,       
			ISEQ20Weighting = E.ISEQ20Weighting,       
			ISEQ20MarketCap = E.ISEQ20MarketCap,       
			ISEQ20CappedMarketCap = E.ISEQ20CappedMarketCap, 
			ISEQ20FreeFloat = E.ISEQ20FreeFloat,       
			ISEQOverallWeighting = E.ISEQOverallWeighting,       
			ISEQOverallMarketCap = E.ISEQOverallMarketCap,      
			ISEQOverallBeta30 = E.ISEQOverallBeta30,       
			ISEQOverallBeta250 = E.ISEQOverallBeta250,       
			ISEQOverallFreefloat = E.ISEQOverallFreefloat,       
			ISEQOverallPrice = E.ISEQOverallPrice,       
			ISEQOverallShares = E.ISEQOverallShares,       
			ISEQ20CappedShares = E.ISEQ20CappedShares, 
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
			ISEQ20CappedMarketCap,    
			ISEQ20FreeFloat,       
			ISEQOverallWeighting,       
			ISEQOverallMarketCap,       
			ISEQOverallBeta30,       
			ISEQOverallBeta250,       
			ISEQOverallFreefloat,       
			ISEQOverallPrice,       
			ISEQOverallShares,       
			ISEQ20CappedShares, 
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
			ISEQ20CappedMarketCap, 
			ISEQ20FreeFloat,       
			ISEQOverallWeighting,       
			ISEQOverallMarketCap,      
			ISEQOverallBeta30,       
			ISEQOverallBeta250,       
			ISEQOverallFreefloat,       
			ISEQOverallPrice,       
			ISEQOverallShares,       
			ISEQ20CappedShares, 
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
 
 
 
	UPDATE 
		DWH 
	SET 
		OCPDateTime = CAST(D.Day AS datetime) + CAST(DWH.OCPTime AS datetime) 
	FROM 
			DWH.FactEquitySnapshot DWH 
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
			DWH.FactEquitySnapshot DWH 
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
			'IEOC' AS IndexCode,     
			ISEQ20LeveragedOpen AS OpenValue     
		FROM     
			RowBased     
		UNION ALL     
		SELECT     
			IndexDateID,     
			'IEOE' AS IndexCode,     
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
				(OverallLow) OverallDailyLow,     
				(FinancialLow) FinancialDailyLow,     
				(GeneralLow) GeneralDailyLow,     
				(SmallCapLow) SamllCapDailyLow,     
				(ITEQLow) ITEQDailyLow,     
				(ISEQ20Low) ISEQ20DailyLow,     
				(ISEQ20INAVLow) ISEQ20INAVDailyLow,     
				(ESMLow) ESMDailyLow,     
				(ISEQ20InverseLow) ISEQ20InverseDailyLow,     
				(ISEQ20LeveragedLow) ISEQ20LeveragedDailyLow,     
				(ISEQ20CappedLow) ISEQ20CappedDailyLow,     
     
				(OverallHigh) OverallDailyHigh,     
				(FinancialHigh) FinancialDailyHigh,     
				(GeneralHigh) GeneralDailyHigh,     
				(SmallCapHigh) SamllCapDailyHigh,     
				(ITEQHigh) ITEQDailyHigh,     
				(ISEQ20High) ISEQ20DailyHigh,     
				(ISEQ20INAVHigh) ISEQ20INAVDailyHigh,     
				(ESMHigh) ESMDailyHigh,     
				(ISEQ20InverseHigh) ISEQ20InverseDailyHigh,     
				(ISEQ20LeveragedHigh) ISEQ20LeveragedDailyHigh,     
				(ISEQ20CappedHigh) ISEQ20CappedDailyHigh     
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
 
  
 
	DROP TABLE #Samples     
	DROP TABLE #FIRST     
	DROP TABLE #LAST     
	DROP TABLE #AGG     
     
END     
     
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EquityVolume]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 7/7/2017 
-- Description:	Equity volume using function 
-- ============================================= 
CREATE FUNCTION [ETL].[EquityVolume] 
(	 
	@D AS INT 
) 
RETURNS TABLE  
AS 
RETURN  
( 
	WITH Trades AS ( 
			SELECT 
				/* Trades fro day */  
				TradeVolume, 
				TradeTurnover, 
				InstrumentID, 
				EquityTradeJunkID, 
				CurrencyID, 
				DelayedTradeYN 
			FROM 
				DWH.FactEquityTrade T     
			WHERE 
				TradeDateID = @D 
			AND 
				DelayedTradeYN = 'N' 
			AND 
				TradeCancelled = 'N' 
			UNION ALL 
			SELECT 
				/* Delayed trades for required day*/ 
				TradeVolume, 
				TradeTurnover, 
				InstrumentID, 
				EquityTradeJunkID, 
				CurrencyID, 
				DelayedTradeYN 
			FROM 
				DWH.FactEquityTrade T     
			WHERE 
				PublishDateID = @D 
			AND 
				PublishedDateTime < GETDATE() 
			AND 
				DelayedTradeYN = 'Y' 
			AND 
				TradeCancelled = 'N' 
		) 
		SELECT 
			I.InstrumentGlobalID,   
			/* DEALS */     
			COUNT(*) AS Deals,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',1,0) ) AS DealsOB,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,1) ) AS DealsND,     
			/* TRADE VOLUME */     
			SUM(TradeVolume) AS TradeVolume,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',TradeVolume,0) ) AS TradeVolumeOB,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,TradeVolume) ) AS TradeVolumeND,     
			/* TURNOVER */     
			SUM(TradeTurnover) AS Turnover,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',TradeTurnover,0) ) AS TurnoverOB,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,TradeTurnover) ) AS TurnoverND,     
			/* TURN OVER - EUR */     
			SUM( TradeTurnover / ExRate.ExchangeRate ) AS TurnoverEur,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',TradeTurnover / ExRate.ExchangeRate ,0) ) AS TurnoverObEur,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,TradeTurnover / ExRate.ExchangeRate ) ) AS TurnoverNdEur,     
			MIN(ExRate.ExchangeRate ) EXR     
		FROM 
				Trades T 
			INNER JOIN   
				DWH.DimInstrumentEquity I   
			ON T.InstrumentID = I.InstrumentID 
			INNER JOIN     
				DWH.DimEquityTradeJunk JK     
			ON T.EquityTradeJunkID = JK.EquityTradeJunkID    
			CROSS APPLY      
			(     
				SELECT     
					TOP 1     
					ExchangeRate     
				FROM     
					DWH.FactExchangeRate EX     
				WHERE     
					EX.DateID <= @D 
				AND     
					T.CurrencyID = EX.CurrencyID     
				ORDER BY     
					EX.DateID DESC     
			) AS ExRate 		 
		GROUP BY     
			I.InstrumentGlobalID 
) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EtfVolume]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 7/7/2017 
-- Description:	Etf volume using function 
-- ============================================= 
CREATE FUNCTION [ETL].[EtfVolume] 
(	 
	@D AS INT 
) 
RETURNS TABLE  
AS 
RETURN  
( 
	WITH Trades AS ( 
			SELECT 
				/* Trades fro day */  
				TradeVolume, 
				TradeTurnover, 
				InstrumentID, 
				EquityTradeJunkID, 
				CurrencyID, 
				DelayedTradeYN 
			FROM 
				DWH.FactEtfTrade T     
			WHERE 
				TradeDateID = @D 
			AND 
				DelayedTradeYN = 'N' 
			AND 
				TradeCancelled = 'N' 
			UNION ALL 
			SELECT 
				/* Delayed trades for required day*/ 
				TradeVolume, 
				TradeTurnover, 
				InstrumentID, 
				EquityTradeJunkID, 
				CurrencyID, 
				DelayedTradeYN 
			FROM 
				DWH.FactEtfTrade T     
			WHERE 
				PublishDateID = @D 
			AND 
				PublishedDateTime < GETDATE() 
			AND 
				DelayedTradeYN = 'Y' 
			AND 
				TradeCancelled = 'N' 
		) 
		SELECT 
			I.InstrumentGlobalID,   
			/* DEALS */     
			COUNT(*) AS Deals,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',1,0) ) AS DealsOB,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,1) ) AS DealsND,     
			/* TRADE VOLUME */     
			SUM(TradeVolume) AS TradeVolume,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',TradeVolume,0) ) AS TradeVolumeOB,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,TradeVolume) ) AS TradeVolumeND,     
			/* TURNOVER */     
			SUM(TradeTurnover) AS Turnover,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',TradeTurnover,0) ) AS TurnoverOB,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,TradeTurnover) ) AS TurnoverND,     
			/* TURN OVER - EUR */     
			SUM( TradeTurnover / ExRate.ExchangeRate ) AS TurnoverEur,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',TradeTurnover / ExRate.ExchangeRate ,0) ) AS TurnoverObEur,     
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,TradeTurnover / ExRate.ExchangeRate ) ) AS TurnoverNdEur,     
			MIN(ExRate.ExchangeRate ) EXR     
		FROM 
				Trades T 
			INNER JOIN   
				DWH.DimInstrumentEtf I   
			ON T.InstrumentID = I.InstrumentID 
			INNER JOIN     
				DWH.DimEquityTradeJunk JK     
			ON T.EquityTradeJunkID = JK.EquityTradeJunkID    
			CROSS APPLY      
			(     
				SELECT     
					TOP 1     
					ExchangeRate     
				FROM     
					DWH.FactExchangeRate EX     
				WHERE     
					EX.DateID <= @D 
				AND     
					T.CurrencyID = EX.CurrencyID     
				ORDER BY     
					EX.DateID DESC     
			) AS ExRate 		 
		GROUP BY     
			I.InstrumentGlobalID 
) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [FactEquityTradeNonClusteredColumnStoreIndex] on [DWH].[FactEquityTrade]'
GO
CREATE NONCLUSTERED COLUMNSTORE INDEX [FactEquityTradeNonClusteredColumnStoreIndex] ON [DWH].[FactEquityTrade] ([EquityTradeID], [InstrumentID], [TradingSysTransNo], [TradeDateID], [TradeTimeID], [TradeTimestamp], [UTCTradeTimeStamp], [PublishDateID], [PublishTimeID], [PublishedDateTime], [UTCPublishedDateTime], [DelayedTradeYN], [EquityTradeJunkID], [BrokerID], [TraderID], [CurrencyID], [TradePrice], [BidPrice], [OfferPrice], [TradeVolume], [TradeTurnover], [TradeModificationTypeID], [TradeCancelled], [InColumnStore], [TradeFileID], [BatchID], [CancelBatchID]) WHERE ([TradeDateID]<=(20170711))
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [FactEquityTradeVolumeHelper] on [DWH].[FactEquityTrade]'
GO
CREATE NONCLUSTERED INDEX [FactEquityTradeVolumeHelper] ON [DWH].[FactEquityTrade] ([PublishDateID], [InstrumentID], [DelayedTradeYN], [TradeCancelled], [PublishedDateTime])
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
