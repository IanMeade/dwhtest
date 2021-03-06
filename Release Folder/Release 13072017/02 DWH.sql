/* 
Run this script on: 
 
        T7-DDT-07.DWH    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.DWH 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 13/07/2017 13:03:51 
 
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
PRINT N'Dropping index [IX_FactEquityTradeClustered] from [DWH].[FactEquityTrade]'
GO
DROP INDEX [IX_FactEquityTradeClustered] ON [DWH].[FactEquityTrade]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[FactEquitySnapshotMerge]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [ETL].[FactEquitySnapshotMerge] ALTER COLUMN [LseTurnover] [numeric] (19, 6) NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [DWH].[UpdateDimFile]'
GO
-- =============================================    
-- Author:		Ian Meade    
-- Create date: 20/1/2017    
-- Description:	Update DimFile     
-- =============================================    
ALTER PROCEDURE [DWH].[UpdateDimFile]    
	@FileName VARCHAR(50),     
	@FileTypeTag VARCHAR(50),     
	@SaftFileLetter VARCHAR(2),     
	@FileProcessedStatus VARCHAR(50)    
AS    
BEGIN    
	SET NOCOUNT ON;    
    
	DECLARE @File TABLE (    
				FileName VARCHAR(50),     
				FileTypeTag VARCHAR(50),     
				SaftFileLetter CHAR(2),     
				FileProcessedStatus VARCHAR(50)    
		)    
	INSERT INTO    
			@File    
		VALUES    
			(    
				@FileName,    
				@FileTypeTag,    
				@SaftFileLetter,    
				@FileProcessedStatus    
			)    
    
    
	MERGE    
			DWH.DimFile AS F    
		USING    
			@File AS I    
		ON F.FileName = I.Filename    
		WHEN MATCHED THEN    
			UPDATE    
				SET    
					FileProcessedTime = GETDATE(),    
					FileProcessedStatus = I.FileProcessedStatus    
		WHEN NOT MATCHED THEN    
			INSERT     
					( FileName, FileType, FileTypeTag, SaftFileLetter, FileProcessedTime, FileProcessedStatus )    
    
				VALUES     
					( I.FileName, I.FileTypeTag, I.FileTypeTag, I.SaftFileLetter, GETDATE(), I.FileProcessedStatus )    
		OUTPUT 		    
			$ACTION, INSERTED.FileID;    
    
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
						IndexTimeID <= @TimeID  
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
PRINT N'Altering [ETL].[UpdateFactEquityIndexSnapshot]'
GO
-- =============================================      
-- Author:		Ian Meade      
-- Create date: 25/4/2017      
-- Description:	Update FactEquityIndexSnapshot with details in merge table      
-- =============================================      
ALTER PROCEDURE [ETL].[UpdateFactEquityIndexSnapshot]      
	@BatchID INT  
AS      
BEGIN      
	SET NOCOUNT ON;      
  
  
	MERGE      
			DWH.FactEquityIndexSnapshot AS DWH      
		USING (      
				SELECT      
					IndexDateID,       
					IndexTypeID,       
					OpenValue,       
					LastValue AS CloseValue,       
					ReturnValue,       
					DailyLowValue,       
					DailyHighValue,       
					InterestRate,       
					MarketCap      
				FROM      
					ETL.FactEquityIndexSnapshotMerge      
			) AS ETL (       
					IndexDateID,       
					IndexTypeID,       
					OpenValue,       
					CloseValue,       
					ReturnValue,       
					DailyLowValue,       
					DailyHighValue,       
					InterestRate,       
					MarketCap       
				)      
			ON (      
				DWH.DateID = ETL.IndexDateID      
			AND      
				DWH.IndexTypeID = ETL.IndexTypeID      
			)      
		WHEN MATCHED       
			THEN UPDATE SET      
				DWH.OpenValue = ETL.OpenValue,       
				DWH.CloseValue = ETL.CloseValue,       
				DWH.ReturnIndex = ETL.ReturnValue,       
				DWH.DailyLow = ETL.DailyLowValue,       
				DWH.DailyHigh = ETL.DailyHighValue,       
				DWH.InterestRate = ETL.InterestRate,       
				DWH.MarketCap = ETL.MarketCap      
		WHEN NOT MATCHED      
			THEN INSERT       
				(      
					DateID,       
					IndexTypeID,       
					OpenValue,       
					CloseValue,       
					ReturnIndex,       
					MarketCap,       
					DailyHigh,       
					DailyLow,       
					InterestRate,       
					BatchID      
				)      
				VALUES      
				(       
					IndexDateID,       
					IndexTypeID,       
					OpenValue,       
					CloseValue,       
					ReturnValue,       
					MarketCap,       
					DailyHighValue,       
					DailyLowValue,       
					InterestRate,       
					@BatchID       
				);      
      
END      
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[ValidateT7EarlyFacts]'
GO
 
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 8/3/2017   
-- Description: Validate T7TradeMainDataFlowOutput - warnigns about inferred entries in DWH dimensions - warning only 
-- =============================================   
ALTER PROCEDURE [ETL].[ValidateT7EarlyFacts] 
AS   
BEGIN   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
	 
	SELECT 
		27 AS Code, 
		'Early arriving facts found in Equity Junk Dimension - review MDM for dimension row [' + STR(EquityTradeJunkID) + ']' AS Message 
	FROM 
		DWH.DimEquityTradeJunk 
	WHERE 
		Inferred = 'Y' 
 
   
END   
  
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FactEquityTradeClustered] on [DWH].[FactEquityTrade]'
GO
CREATE UNIQUE CLUSTERED INDEX [IX_FactEquityTradeClustered] ON [DWH].[FactEquityTrade] ([TradeDateID], [EquityTradeID]) WITH (DATA_COMPRESSION = PAGE)
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
