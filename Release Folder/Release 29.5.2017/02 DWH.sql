/* 
Run this script on: 
 
        T7-DDT-06.DWH    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.DWH 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 29/05/2017 14:10:57 
 
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
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating role EtlRunner'
GO
CREATE ROLE [EtlRunner] 
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating role ReportRunner'
GO
CREATE ROLE [ReportRunner] 
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating role ReportWriter'
GO
CREATE ROLE [ReportWriter] 
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating schemas'
GO
CREATE SCHEMA [DWH] 
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE SCHEMA [ETL] 
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE SCHEMA [Report] 
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[FactEtfTrade]'
GO
CREATE TABLE [DWH].[FactEtfTrade] 
( 
[EtfTradeID] [int] NOT NULL IDENTITY(1, 1), 
[InstrumentID] [int] NOT NULL, 
[TradingSysTransNo] [int] NOT NULL, 
[TradeDateID] [int] NOT NULL, 
[TradeTimeID] [smallint] NOT NULL, 
[TradeTimestamp] [time] NOT NULL, 
[UTCTradeTimeStamp] [time] NOT NULL, 
[PublishDateID] [int] NOT NULL, 
[PublishTimeID] [smallint] NOT NULL, 
[PublishedDateTime] [datetime2] NOT NULL, 
[UTCPublishedDateTime] [datetime2] NOT NULL, 
[DelayedTradeYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[EquityTradeJunkID] [smallint] NOT NULL, 
[BrokerID] [smallint] NOT NULL, 
[TraderID] [smallint] NOT NULL, 
[CurrencyID] [smallint] NOT NULL, 
[TradePrice] [numeric] (19, 6) NOT NULL, 
[BidPrice] [numeric] (19, 6) NOT NULL, 
[OfferPrice] [numeric] (19, 6) NOT NULL, 
[TradeVolume] [int] NOT NULL, 
[TradeTurnover] [numeric] (19, 6) NOT NULL, 
[TradeModificationTypeID] [smallint] NOT NULL, 
[TradeCancelled] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[TradeFileID] [int] NOT NULL, 
[BatchID] [int] NOT NULL CONSTRAINT [DF_FactEtfTrade_BatchID] DEFAULT ((0)), 
[CancelBatchID] [int] NULL, 
[InColumnStore] [bit] NOT NULL CONSTRAINT [DF_FactEtfTrade_InColumnStore] DEFAULT ((0)) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactEtfTrade] on [DWH].[FactEtfTrade]'
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [PK_FactEtfTrade] PRIMARY KEY CLUSTERED  ([EtfTradeID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FactEtfTrade_DuplicateCheck] on [DWH].[FactEtfTrade]'
GO
CREATE NONCLUSTERED INDEX [IX_FactEtfTrade_DuplicateCheck] ON [DWH].[FactEtfTrade] ([TradeDateID], [TradingSysTransNo])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimTradeModificationType]'
GO
CREATE TABLE [DWH].[DimTradeModificationType] 
( 
[TradeModificationTypeID] [smallint] NOT NULL IDENTITY(1, 1), 
[TradingSysModificationTypeCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeModificationTypeName] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[CancelTradeYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimTradeModificationType] on [DWH].[DimTradeModificationType]'
GO
ALTER TABLE [DWH].[DimTradeModificationType] ADD CONSTRAINT [PK_DimTradeModificationType] PRIMARY KEY CLUSTERED  ([TradeModificationTypeID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimInstrumentEtf]'
GO
CREATE TABLE [DWH].[DimInstrumentEtf] 
( 
[InstrumentID] [int] NOT NULL, 
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentName] [varchar] (256) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[SecurityType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[SEDOL] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentStatusID] [smallint] NOT NULL, 
[InstrumentStatusDate] [date] NOT NULL, 
[InstrumentListedDate] [date] NULL, 
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[CompanyGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[CompanyListedDate] [date] NULL, 
[CompanyApprovalType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[CompanyApprovalDate] [date] NULL, 
[TransparencyDirectiveYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketAbuseDirectiveYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProspectusDirectiveYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketID] [smallint] NOT NULL, 
[IssuerDomicile] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[WKN] [varchar] (6) COLLATE Latin1_General_CI_AS NOT NULL, 
[MNEM] [varchar] (4) COLLATE Latin1_General_CI_AS NOT NULL, 
[PrimaryBusinessSector] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[SubBusinessSector1] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[SubBusinessSector2] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[SubBusinessSector3] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[SubBusinessSector4] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[SubBusinessSector5] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[OverallIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[GeneralIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[FinancialIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[SmallCapIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[ITEQIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[ISEQ20IndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[ESMIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FinancialYearEndDate] [date] NULL, 
[IncorporationDate] [date] NULL, 
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[TransparencyDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProspectusDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerDomicileDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[FeeCodeName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuedDate] [date] NULL, 
[CurrencyID] [smallint] NOT NULL, 
[UnitOfQuotation] [numeric] (19, 9) NOT NULL, 
[QuotationCurrencyID] [smallint] NOT NULL, 
[ISEQ20Freefloat] [numeric] (19, 6) NOT NULL, 
[ISEQOverallFreeFloat] [numeric] (19, 6) NOT NULL, 
[IssuerSedolMasterFileName] [varchar] (35) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[CFIName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[CFICode] [varchar] (6) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NOT NULL, 
[TotalSharesInIssue] [numeric] (28, 6) NOT NULL, 
[LastEXDivDate] [date] NULL, 
[CompanyStatusID] [smallint] NOT NULL, 
[Note] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[StartDate] [datetime2] NOT NULL, 
[EndDate] [datetime2] NULL, 
[CurrentRowYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[BatchID] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimInstrumentEtf] on [DWH].[DimInstrumentEtf]'
GO
ALTER TABLE [DWH].[DimInstrumentEtf] ADD CONSTRAINT [PK_DimInstrumentEtf] PRIMARY KEY CLUSTERED  ([InstrumentID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[AggregationDateList]'
GO
CREATE TABLE [ETL].[AggregationDateList] 
( 
[AggregateDate] [date] NULL, 
[AggregateDateID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EtfTradeLastTradeDateScoped]'
GO
  
CREATE VIEW [ETL].[EtfTradeLastTradeDateScoped] AS     
	/* NO LOOCAL TIMES ETC.. */    
	/* NO DELAYED TRADE ACCOMODATED */    
		SELECT    
			LastTrade.AggregateDateID,     
			LastTrade.InstrumentGlobalID,    
			T.TradeDateID,    
			T.TradeTimeID,    
			T.TradeTimestamp,    
			T.UTCTradeTimeStamp,    
			MAX(T.TradePrice) AS TradePrice    
		FROM    
				DWH.FactEtfTrade T    
			INNER JOIN    
				DWH.DimInstrumentEtf ETF    
			ON T.InstrumentID = Etf.InstrumentID    
			INNER JOIN    
				ETL.AggregationDateList D  
			ON     
				T.TradeDateID = D.AggregateDateID    
			INNER JOIN    
				DWH.DimTradeModificationType MOD    
			ON T.TradeModificationTypeID = MOD.TradeModificationTypeID    
			AND MOD.TradeModificationTypeName <> 'CANCEL'    
			INNER JOIN    
			(    
				SELECT    
					D.AggregateDateID,     
					ETF.InstrumentGlobalID,     
					MAX(TradeTimestamp) AS TradeTimestamp,    
					COUNT(*) CNT,    
					MIN(TradeTimestamp) AS T1    
				FROM    
						DWH.FactEtfTrade T    
					INNER JOIN    
						DWH.DimInstrumentEtf ETF    
					ON T.InstrumentID = ETF.InstrumentID    
					INNER JOIN    
						ETL.AggregationDateList D  
					ON     
						T.TradeDateID = D.AggregateDateID    
					INNER JOIN    
						DWH.DimTradeModificationType MOD    
					ON T.TradeModificationTypeID = MOD.TradeModificationTypeID    
					AND MOD.TradeModificationTypeName <> 'CANCEL'    
				WHERE    
					T.DelayedTradeYN = 'N'    
				GROUP BY    
					D.AggregateDateID,     
					ETF.InstrumentGlobalID  
			) AS LastTrade    
			ON    
				T.TradeDateID = LastTrade.AggregateDateID    
			AND    
				ETF.InstrumentGlobalID = LastTrade.InstrumentGlobalID  
			AND    
				T.TradeTimestamp = LastTrade.TradeTimestamp    
		WHERE    
			T.DelayedTradeYN = 'N'    
		GROUP BY    
			LastTrade.AggregateDateID,     
			LastTrade.InstrumentGlobalID,    
			T.TradeDateID,    
			T.TradeTimeID,    
			T.TradeTimestamp,    
			T.UTCTradeTimeStamp    
    
    
    
    
   
   
   
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[FactEtfSnapshot]'
GO
CREATE TABLE [DWH].[FactEtfSnapshot] 
( 
[EtfSnapshotID] [int] NOT NULL IDENTITY(1, 1), 
[InstrumentID] [int] NOT NULL, 
[InstrumentStatusID] [smallint] NULL, 
[DateID] [int] NOT NULL, 
[NAVCalcDateID] [int] NOT NULL CONSTRAINT [DF_FactEtfSnapshot_NAVCalcDateID] DEFAULT ((-1)), 
[LastExDivDateID] [int] NULL, 
[OCPDateID] [int] NULL, 
[OCPTimeID] [smallint] NULL, 
[OCPTime] [time] NULL, 
[UtcOCPTime] [time] NULL, 
[OcpDateTime] [datetime2] NULL, 
[LTPDateID] [int] NULL, 
[LTPTimeID] [smallint] NULL, 
[LTPTime] [time] NULL, 
[UtcLTPTime] [time] NULL, 
[LtpDateTime] [datetime2] NULL, 
[MarketID] [smallint] NULL, 
[NAV] [numeric] (19, 6) NULL, 
[ETFSharesInIssue] [numeric] (28, 6) NULL, 
[IssuedSharesToday] [numeric] (28, 6) NULL, 
[ExDivYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[OpenPrice] [numeric] (19, 6) NULL, 
[LowPrice] [numeric] (19, 6) NULL, 
[HighPrice] [numeric] (19, 6) NULL, 
[BidPrice] [numeric] (19, 6) NULL, 
[OfferPrice] [numeric] (19, 6) NULL, 
[ClosingAuctionBidPrice] [numeric] (19, 6) NULL, 
[ClosingAuctionOfferPrice] [numeric] (19, 6) NULL, 
[OCP] [numeric] (19, 6) NULL, 
[LTP] [numeric] (19, 6) NULL, 
[MarketCap] [numeric] (28, 6) NULL, 
[MarketCapEur] [numeric] (28, 6) NULL, 
[Turnover] [numeric] (19, 6) NULL, 
[TurnoverND] [numeric] (19, 6) NULL, 
[TurnoverEur] [numeric] (19, 6) NULL, 
[TurnoverNDEur] [numeric] (19, 6) NULL, 
[TurnoverOB] [numeric] (19, 6) NULL, 
[TurnoverOBEur] [numeric] (19, 6) NULL, 
[Volume] [bigint] NULL, 
[VolumeND] [bigint] NULL, 
[VolumeOB] [bigint] NULL, 
[Deals] [bigint] NULL, 
[DealsOB] [bigint] NULL, 
[DealsND] [bigint] NULL, 
[ISEQ20Shares] [numeric] (28, 6) NULL, 
[ISEQ20Price] [numeric] (19, 6) NULL, 
[ISEQ20Weighting] [numeric] (9, 6) NULL, 
[ISEQ20MarketCap] [numeric] (28, 6) NULL, 
[ISEQ20FreeFloat] [numeric] (9, 6) NULL, 
[ISEQOverallWeighting] [numeric] (9, 6) NULL, 
[ISEQOverallMarketCap] [numeric] (28, 6) NULL, 
[ISEQOverallBeta30] [numeric] (19, 6) NULL, 
[ISEQOverallBeta250] [numeric] (19, 6) NULL, 
[ISEQOverallFreefloat] [numeric] (9, 6) NULL, 
[ISEQOverallPrice] [numeric] (19, 6) NULL, 
[ISEQOverallShares] [numeric] (28, 6) NULL, 
[OverallIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[GeneralIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[FinancialIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[SmallCapIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ITEQIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ISEQ20IndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ESMIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExCapYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExEntitlementYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExRightsYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExSpecialYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[BatchID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactEtfSnapshot] on [DWH].[FactEtfSnapshot]'
GO
ALTER TABLE [DWH].[FactEtfSnapshot] ADD CONSTRAINT [PK_FactEtfSnapshot] PRIMARY KEY CLUSTERED  ([EtfSnapshotID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FactEtfSnapshot] on [DWH].[FactEtfSnapshot]'
GO
CREATE NONCLUSTERED INDEX [IX_FactEtfSnapshot] ON [DWH].[FactEtfSnapshot] ([DateID], [InstrumentID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EtfTradeLastTrade]'
GO
    
CREATE VIEW [ETL].[EtfTradeLastTrade] AS    
	/* LAST TRADE PRICE & DATE */    
		SELECT    
			D.AggregateDateID,     
			COALESCE( L1.InstrumentGlobalID, SNAP_KEY.InstrumentGlobalID ) AS InstrumentGlobalID,  
			COALESCE( L1.TradeDateID, V.LTPDateID) AS LTPDateID ,    
			COALESCE( L1.TradeTimeID, V.LTPTimeID) AS LTPTimeID,    
			COALESCE( L1.TradeTimestamp, V.LTPTime) AS LTPTime,    
			COALESCE( L1.UTCTradeTimeStamp, V.UtcLTPTime) AS UtcLTPTime,    
			COALESCE( L1.TradePrice, V.LTP ) AS LastPrice    
		FROM    
				ETL.AggregationDateList D  
			LEFT OUTER JOIN    
				ETL.EtfTradeLastTradeDateScoped L1    
			ON     
				D.AggregateDateID = L1.AggregateDateID    
			LEFT OUTER JOIN  
			/* MOST RECENT TRADE RECORDED IN SNAPSHOT */    
			(  
				SELECT  
					ETF.InstrumentGlobalID,  
					D.AggregateDateID,  
					MAX(F.DateID) AS DateID,  
					MAX(F.InstrumentID) AS InstrumentID  
				FROM  
						ETL.AggregationDateList D  
					INNER JOIN  
						DWH.FactEtfSnapshot F    
					ON D.AggregateDateID >= F.DateID  
					INNER JOIN  
						DWH.DimInstrumentEtf ETF  
					ON F.InstrumentID = ETF.InstrumentID    
				GROUP BY  
					D.AggregateDateID,  
					ETF.InstrumentGlobalID  
			) AS SNAP_KEY  
			ON D.AggregateDateID = SNAP_KEY.AggregateDateID  
			INNER JOIN  
				DWH.FactEtfSnapshot V  
			ON SNAP_KEY.DateID = V.DateID  
			AND SNAP_KEY.InstrumentID = V.InstrumentID  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[FactExchangeRate]'
GO
CREATE TABLE [DWH].[FactExchangeRate] 
( 
[ExchangeRateID] [int] NOT NULL IDENTITY(1, 15), 
[DateID] [int] NOT NULL, 
[CurrencyID] [smallint] NOT NULL, 
[ExchangeRate] [numeric] (19, 6) NOT NULL, 
[BatchID] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactExchangeRate] on [DWH].[FactExchangeRate]'
GO
ALTER TABLE [DWH].[FactExchangeRate] ADD CONSTRAINT [PK_FactExchangeRate] PRIMARY KEY CLUSTERED  ([ExchangeRateID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimEquityTradeJunk]'
GO
CREATE TABLE [DWH].[DimEquityTradeJunk] 
( 
[EquityTradeJunkID] [smallint] NOT NULL IDENTITY(1, 1), 
[TradeSideCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeSideName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeOrderTypeCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeOrderRestrictionCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeType] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeTypeCategory] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[PrincipalAgentCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[PrincipalAgentName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[AuctionFlagCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[AuctionFlagName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeFlagCombined] [varchar] (15) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeFlagCode1] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeFlagName1] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeFlagCode2] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeFlagName2] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeFlagCode3] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeFlagName3] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeFlagCode4] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeFlagName4] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeFlagCode5] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeFlagName5] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[Inferred] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_DimEquityTradeJunk_Inferred] DEFAULT ('N') 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimEquityTradeJunk] on [DWH].[DimEquityTradeJunk]'
GO
ALTER TABLE [DWH].[DimEquityTradeJunk] ADD CONSTRAINT [PK_DimEquityTradeJunk] PRIMARY KEY CLUSTERED  ([EquityTradeJunkID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EtfVolume]'
GO
 
  
  
CREATE VIEW [ETL].[EtfVolume] AS    
		SELECT    
			D.AggregateDateID,     
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
				ETL.AggregationDateList D  
			INNER JOIN    
				DWH.FactEtfTrade T    
			ON D.AggregateDateID = T.TradeDateID    
			AND T.TradeCancelled = 'N' 
			INNER JOIN  
				DWH.DimInstrumentEtf I  
			ON T.InstrumentID = I.InstrumentID  
			INNER JOIN    
				DWH.DimEquityTradeJunk JK    
			ON T.EquityTradeJunkID = JK.EquityTradeJunkID   
			/* 
			INNER JOIN    
				DWH.DimTradeModificationType MT    
			ON T.TradeModificationTypeID = MT.TradeModificationTypeID    
			AND MT.CancelTradeYN = 'N'  
			*/ 
			CROSS APPLY     
			(    
				SELECT    
					TOP 1    
					ExchangeRate    
				FROM    
					DWH.FactExchangeRate EX    
				WHERE    
					D.AggregateDateID >= EX.DateID     
				AND    
					T.CurrencyID = EX.CurrencyID    
				ORDER BY    
					EX.DateID DESC    
			) AS ExRate    
		WHERE    
				T.DelayedTradeYN = 'N'    
			OR    
				(    
						T.DelayedTradeYN = 'Y'    
					AND    
						T.PublishedDateTime < GETDATE()    
				)    
		GROUP BY    
			D.AggregateDateID,  
			I.InstrumentGlobalID  
  
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[FactEquityTrade]'
GO
CREATE TABLE [DWH].[FactEquityTrade] 
( 
[EquityTradeID] [int] NOT NULL IDENTITY(1, 1), 
[InstrumentID] [int] NOT NULL, 
[TradingSysTransNo] [int] NOT NULL, 
[TradeDateID] [int] NOT NULL, 
[TradeTimeID] [smallint] NOT NULL, 
[TradeTimestamp] [time] NOT NULL, 
[UTCTradeTimeStamp] [time] NOT NULL, 
[PublishDateID] [int] NOT NULL, 
[PublishTimeID] [smallint] NOT NULL, 
[PublishedDateTime] [datetime2] NOT NULL, 
[UTCPublishedDateTime] [datetime2] NOT NULL, 
[DelayedTradeYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[EquityTradeJunkID] [smallint] NOT NULL, 
[BrokerID] [smallint] NOT NULL, 
[TraderID] [smallint] NOT NULL, 
[CurrencyID] [smallint] NOT NULL, 
[TradePrice] [numeric] (19, 6) NOT NULL, 
[BidPrice] [numeric] (19, 6) NOT NULL, 
[OfferPrice] [numeric] (19, 6) NOT NULL, 
[TradeVolume] [bigint] NOT NULL, 
[TradeTurnover] [numeric] (19, 6) NOT NULL, 
[TradeModificationTypeID] [smallint] NOT NULL, 
[TradeCancelled] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_FactEquityTrade_TradeCancelled] DEFAULT ('N'), 
[InColumnStore] [bit] NOT NULL CONSTRAINT [DF_FactEquityTrade_InColumnStore] DEFAULT ((0)), 
[TradeFileID] [int] NOT NULL, 
[BatchID] [int] NOT NULL, 
[CancelBatchID] [int] NOT NULL 
) 
WITH 
( 
DATA_COMPRESSION = PAGE 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FactEquityTradeClustered] on [DWH].[FactEquityTrade]'
GO
CREATE UNIQUE CLUSTERED INDEX [IX_FactEquityTradeClustered] ON [DWH].[FactEquityTrade] ([TradeDateID], [TradingSysTransNo], [EquityTradeJunkID], [EquityTradeID]) WITH (DATA_COMPRESSION = PAGE)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactEquityTrade] on [DWH].[FactEquityTrade]'
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [PK_FactEquityTrade] PRIMARY KEY NONCLUSTERED  ([EquityTradeID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [FactEquityTradeNonClusteredColumnStoreIndex] on [DWH].[FactEquityTrade]'
GO
CREATE NONCLUSTERED COLUMNSTORE INDEX [FactEquityTradeNonClusteredColumnStoreIndex] ON [DWH].[FactEquityTrade] ([EquityTradeID], [InstrumentID], [TradingSysTransNo], [TradeDateID], [TradeTimeID], [TradeTimestamp], [UTCTradeTimeStamp], [PublishDateID], [PublishTimeID], [PublishedDateTime], [UTCPublishedDateTime], [DelayedTradeYN], [EquityTradeJunkID], [BrokerID], [TraderID], [CurrencyID], [TradePrice], [BidPrice], [OfferPrice], [TradeVolume], [TradeTurnover], [TradeModificationTypeID], [TradeCancelled], [InColumnStore], [TradeFileID], [BatchID], [CancelBatchID]) WHERE ([TradeDateID]<=(20170515))
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [FactEquityTradeLtpHelper] on [DWH].[FactEquityTrade]'
GO
CREATE NONCLUSTERED INDEX [FactEquityTradeLtpHelper] ON [DWH].[FactEquityTrade] ([InstrumentID], [PublishedDateTime], [TradeCancelled], [TradeDateID]) INCLUDE ([DelayedTradeYN], [EquityTradeID], [PublishDateID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EquityTradeDate]'
GO
CREATE TABLE [ETL].[EquityTradeDate] 
( 
[TradeDateID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[PossibleDuplicates]'
GO
  
   
CREATE VIEW [ETL].[PossibleDuplicates] AS   
	/* USES TRADE DATE TO CHECK FOR DUPLICATES */   
  
	/* Supported by Index: IX_FactEquityTrade_DuplicateCheck & IX_FactEtfTrade_DuplicateCheck */  
		SELECT   
			TradeDateID,   
			TradingSysTransNo   
		FROM   
				DWH.FactEquityTrade T   
		WHERE   
			TradeDateID IN ( SELECT TradeDateID FROM ETL.EquityTradeDate )   
		UNION   
		SELECT   
			TradeDateID,   
			TradingSysTransNo   
		FROM   
				DWH.FactEtfTrade T   
		WHERE   
			TradeDateID IN ( SELECT TradeDateID FROM ETL.EquityTradeDate )   
   
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[FactEquityIndexPrep]'
GO
CREATE TABLE [ETL].[FactEquityIndexPrep] 
( 
[IndexDateID] [int] NOT NULL, 
[IndexCode] [varchar] (15) COLLATE Latin1_General_CI_AS NOT NULL, 
[OpenValue] [numeric] (8, 3) NOT NULL, 
[LastValue] [numeric] (8, 3) NOT NULL, 
[ReturnValue] [numeric] (8, 3) NULL, 
[DailyLowValue] [numeric] (8, 3) NULL, 
[DailyHighValue] [numeric] (8, 3) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[FactEquityIndex]'
GO
CREATE TABLE [DWH].[FactEquityIndex] 
( 
[EquityIndexID] [int] NOT NULL IDENTITY(1, 1), 
[IndexDateID] [int] NOT NULL, 
[IndexTimeID] [smallint] NOT NULL, 
[OverallLast] [numeric] (8, 3) NULL, 
[OverallOpen] [numeric] (8, 3) NULL, 
[OverallHigh] [numeric] (8, 3) NULL, 
[OverallLow] [numeric] (8, 3) NULL, 
[OverallReturn] [numeric] (8, 3) NULL, 
[FinancialLast] [numeric] (8, 3) NULL, 
[FinancialOpen] [numeric] (8, 3) NULL, 
[FinancialHigh] [numeric] (8, 3) NULL, 
[FinancialLow] [numeric] (8, 3) NULL, 
[FinancialReturn] [numeric] (8, 3) NULL, 
[GeneralLast] [numeric] (8, 3) NULL, 
[GeneralOpen] [numeric] (8, 3) NULL, 
[GeneralHigh] [numeric] (8, 3) NULL, 
[GeneralLow] [numeric] (8, 3) NULL, 
[GeneralReturn] [numeric] (8, 3) NULL, 
[SmallCapLast] [numeric] (8, 3) NULL, 
[SmallCapOpen] [numeric] (8, 3) NULL, 
[SmallCapHigh] [numeric] (8, 3) NULL, 
[SmallCapLow] [numeric] (8, 3) NULL, 
[SmallCapReturn] [numeric] (8, 3) NULL, 
[ITEQlast] [numeric] (8, 3) NULL, 
[ITEQOpen] [numeric] (8, 3) NULL, 
[ITEQHigh] [numeric] (8, 3) NULL, 
[ITEQLow] [numeric] (8, 3) NULL, 
[ITEQReturn] [numeric] (8, 3) NULL, 
[ISEQ20Last] [numeric] (8, 3) NULL, 
[ISEQ20Open] [numeric] (8, 3) NULL, 
[ISEQ20High] [numeric] (8, 3) NULL, 
[ISEQ20Low] [numeric] (8, 3) NULL, 
[ISEQ20Return] [numeric] (8, 3) NULL, 
[ISEQ20INAVlast] [numeric] (8, 3) NULL, 
[ISEQ20INAVOpen] [numeric] (8, 3) NULL, 
[ISEQ20INAVHigh] [numeric] (8, 3) NULL, 
[ISEQ20INAVLow] [numeric] (8, 3) NULL, 
[ESMLast] [numeric] (8, 3) NULL, 
[ESMopen] [numeric] (8, 3) NULL, 
[ESMHigh] [numeric] (8, 3) NULL, 
[ESMLow] [numeric] (8, 3) NULL, 
[ESMReturn] [numeric] (8, 3) NULL, 
[ISEQ20InverseLast] [numeric] (8, 3) NULL, 
[ISEQ20InverseOpen] [numeric] (8, 3) NULL, 
[ISEQ20InverseHigh] [numeric] (8, 3) NULL, 
[ISEQ20InverseLow] [numeric] (8, 3) NULL, 
[ISEQ20InverseReturn] [numeric] (8, 3) NULL, 
[ISEQ20LeveragedLast] [numeric] (8, 3) NULL, 
[ISEQ20LeveragedOpen] [numeric] (8, 3) NULL, 
[ISEQ20LeveragedHigh] [numeric] (8, 3) NULL, 
[ISEQ20LeveragedLow] [numeric] (8, 3) NULL, 
[ISEQ20CappedLast] [numeric] (8, 3) NULL, 
[ISEQ20CappedOpen] [numeric] (8, 3) NULL, 
[ISEQ20CappedHigh] [numeric] (8, 3) NULL, 
[ISEQ20CappedLow] [numeric] (8, 3) NULL, 
[ISEQ20CappedReturn] [numeric] (8, 3) NULL, 
[BatchID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactEquityIndex] on [DWH].[FactEquityIndex]'
GO
ALTER TABLE [DWH].[FactEquityIndex] ADD CONSTRAINT [PK_FactEquityIndex] PRIMARY KEY CLUSTERED  ([EquityIndexID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FactEquityIndex] on [DWH].[FactEquityIndex]'
GO
CREATE NONCLUSTERED INDEX [IX_FactEquityIndex] ON [DWH].[FactEquityIndex] ([IndexDateID], [IndexTimeID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[AggrgeateFactEquityIndex]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 25/4/2017  
-- Description:	Aggregate the Equity Indexes - for upodate to FactEquityIndexSnapshot  
--				Note: cannot call storted proecedure dirrectly from SSIS due to meta-data issue - populating tbale for next step  
-- =============================================  
CREATE PROCEDURE [ETL].[AggrgeateFactEquityIndex]  
	@IndexDateID INT  
AS  
BEGIN  
	SET NOCOUNT ON;  
  
	/* FIND LAST ROWS */  
	;  
	WITH SamplesRequired AS (  
					SELECT  
						IndexDateID  
					FROM  
							DWH.FactEquityIndex O  
					WHERE  
						IndexDateID = @IndexDateID  
					GROUP BY  
						IndexDateID  
				)  
		SELECT  
			X.IndexDateID,  
			LastSample.EquityIndexID AS LastSampleEquityIndexID  
		INTO  
			#Samples  
		FROM  
				SamplesRequired AS X  
			CROSS APPLY (  
					SELECT  
						TOP 1  
						EquityIndexID  
					FROM  
						DWH.FactEquityIndex I  
					WHERE  
						X.IndexDateID = I.IndexDateID  
					ORDER BY  
						I.IndexTimeID DESC,  
						I.EquityIndexID DESC  
				) AS LastSample  
  
 /* Get Open values in #FIRST tmep table */ 
 /* Get Last & Return in #LAST tnep table */ 
 /* Gets gih and low in #AGG temp table */ 
 
				;  
 
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
					I.EquityIndexID = S.LastSampleEquityIndexID 
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
				ON I.EquityIndexID = S.LastSampleEquityIndexID  
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
				MIN(OverallLast) OverallDailyLow,  
				MIN(FinancialLast) FinancialDailyLow,  
				MIN(GeneralLast) GeneralDailyLow,  
				MIN(SmallCapLast) SamllCapDailyLow,  
				MIN(ITEQLast) ITEQDailyLow,  
				MIN(ISEQ20Last) ISEQ20DailyLow,  
				MIN(ISEQ20INAVLast) ISEQ20INAVDailyLow,  
				MIN(ESMLast) ESMDailyLow,  
				MIN(ISEQ20InverseLast) ISEQ20InverseDailyLow,  
				MIN(ISEQ20LeveragedLast) ISEQ20LeveragedDailyLow,  
				MIN(ISEQ20CappedLast) ISEQ20CappedDailyLow,  
  
				MAX(OverallLast) OverallDailyHigh,  
				MAX(FinancialLast) FinancialDailyHigh,  
				MAX(GeneralLast) GeneralDailyHigh,  
				MAX(SmallCapLast) SamllCapDailyHigh,  
				MAX(ITEQLast) ITEQDailyHigh,  
				MAX(ISEQ20Last) ISEQ20DailyHigh,  
				MAX(ISEQ20INAVLast) ISEQ20INAVDailyHigh,  
				MAX(ESMLast) ESMDailyHigh,  
				MAX(ISEQ20InverseLast) ISEQ20InverseDailyHigh,  
				MAX(ISEQ20LeveragedLast) ISEQ20LeveragedDailyHigh,  
				MAX(ISEQ20CappedLast) ISEQ20CappedDailyHigh  
			FROM  
				DWH.FactEquityIndex O  
			WHERE  
				IndexDateID = @IndexDateID  
			GROUP BY  
				IndexDateID  
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
  
			  
	DROP TABLE #Samples  
	DROP TABLE #FIRST  
	DROP TABLE #LAST  
	DROP TABLE #AGG  
  
END  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[FactEquityIndexSnapshotMerge]'
GO
CREATE TABLE [ETL].[FactEquityIndexSnapshotMerge] 
( 
[IndexDateID] [int] NULL, 
[IndexCode] [varchar] (15) COLLATE Latin1_General_CI_AS NULL, 
[OpenValue] [numeric] (8, 3) NULL, 
[LastValue] [numeric] (8, 3) NULL, 
[ReturnValue] [numeric] (8, 3) NULL, 
[DailyLowValue] [numeric] (8, 3) NULL, 
[DailyHighValue] [numeric] (8, 3) NULL, 
[IndexTypeID] [smallint] NULL, 
[InterestRate] [numeric] (5, 2) NULL, 
[MarketCap] [numeric] (38, 6) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[FactEquityIndexSnapshot]'
GO
CREATE TABLE [DWH].[FactEquityIndexSnapshot] 
( 
[EquityIndexID] [int] NOT NULL IDENTITY(1, 1), 
[DateID] [int] NOT NULL, 
[IndexTypeID] [smallint] NOT NULL, 
[OpenValue] [numeric] (19, 6) NULL, 
[CloseValue] [numeric] (19, 6) NULL, 
[ReturnIndex] [numeric] (19, 6) NULL, 
[MarketCap] [numeric] (28, 6) NULL, 
[DailyHigh] [numeric] (19, 6) NULL, 
[DailyLow] [numeric] (19, 6) NULL, 
[InterestRate] [numeric] (9, 6) NULL, 
[BatchID] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactEquityIndexSnapshot] on [DWH].[FactEquityIndexSnapshot]'
GO
ALTER TABLE [DWH].[FactEquityIndexSnapshot] ADD CONSTRAINT [PK_FactEquityIndexSnapshot] PRIMARY KEY CLUSTERED  ([EquityIndexID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[UpdateFactEquityIndexSnapshot]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 25/4/2017   
-- Description:	Update FactEquityIndexSnapshot with details in merge table   
-- =============================================   
CREATE PROCEDURE [ETL].[UpdateFactEquityIndexSnapshot]   
	@BatchID INT   
AS   
BEGIN   
--	SET NOCOUNT ON;   
   
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
				DailyLowValue,    
				DailyHighValue,    
				InterestRate,    
				@BatchID    
			);   
   
END   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimInstrument]'
GO
CREATE TABLE [DWH].[DimInstrument] 
( 
[InstrumentID] [int] NOT NULL IDENTITY(1, 1), 
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentName] [varchar] (256) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[SecurityType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[SEDOL] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentStatusID] [smallint] NOT NULL, 
[InstrumentStatusDate] [date] NOT NULL, 
[InstrumentListedDate] [date] NULL, 
[IssuerName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketID] [smallint] NOT NULL, 
[IssuerDomicile] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[FinancialYearEndDate] [date] NULL, 
[IncorporationDate] [date] NULL, 
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[TransparencyDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProspectusDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerDomicileDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[FeeCodeName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[WKN] [varchar] (6) COLLATE Latin1_General_CI_AS NOT NULL, 
[MNEM] [varchar] (4) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuedDate] [date] NULL, 
[IssuerSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NOT NULL, 
[CompanyGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[CompanyApprovalDate] [date] NULL, 
[CompanyApprovalType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NOT NULL, 
[StartDate] [datetime2] NOT NULL, 
[EndDate] [datetime2] NULL, 
[CurrentRowYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[BatchID] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimInstrument] on [DWH].[DimInstrument]'
GO
ALTER TABLE [DWH].[DimInstrument] ADD CONSTRAINT [PK_DimInstrument] PRIMARY KEY CLUSTERED  ([InstrumentID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[udfGetLastTradeDetailsEquity]'
GO
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 22/5/2017 
-- Description:	Get Last Trade Prices - equity  
-- ============================================= 
CREATE FUNCTION [ETL].[udfGetLastTradeDetailsEquity] 
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
				T.EquityTradeID, 
				T.TradeDateID, 
				T.TradeTimeID, 
				T.TradeTimestamp, 
				T.UTCTradeTimeStamp, 
				T.PublishedDateTime, 
				T.TradePrice 
			FROM 
					DWH.FactEquityTrade T 
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
				MAX(EquityTradeID) AS EquityTradeID 
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
			ON LT.EquityTradeID = T.EquityTradeID 
 
) 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[udfGetLastTradeDetailsEtf]'
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
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[FactEquityEtfLtpHelper]'
GO
CREATE TABLE [ETL].[FactEquityEtfLtpHelper] 
( 
[AggregationDateID] [int] NULL, 
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[PublishedDateTime] [datetime2] NOT NULL, 
[TradeDateID] [int] NOT NULL, 
[TradeTimeID] [smallint] NOT NULL, 
[TradeTimestamp] [time] NOT NULL, 
[UTCTradeTimeStamp] [time] NOT NULL, 
[TradePrice] [numeric] (19, 6) NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[BuilDLpHelper]'
GO
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 22/5/2017 
-- Description:	Calls query to put get last trade details for equity and ETF trade snapshot tables - both in ne helper table 
-- ============================================= 
CREATE PROCEDURE [ETL].[BuilDLpHelper] 
	@DateID INT 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	TRUNCATE TABLE ETL.FactEquityEtfLtpHelper 
 
	INSERT INTO 
			ETL.FactEquityEtfLtpHelper 
		SELECT 
			AggregationDateID, 
			InstrumentGlobalID, 
			PublishedDateTime, 
			TradeDateID, 
			TradeTimeID, 
			TradeTimestamp, 
			UTCTradeTimeStamp, 
			TradePrice			 
		FROM 
			ETL.udfGetLastTradeDetailsEquity(@DateID) AS LTP 
 
	INSERT INTO 
			ETL.FactEquityEtfLtpHelper 
		SELECT 
			AggregationDateID, 
			InstrumentGlobalID, 
			PublishedDateTime, 
			TradeDateID, 
			TradeTimeID, 
			TradeTimestamp, 
			UTCTradeTimeStamp, 
			TradePrice			 
		FROM 
			ETL.udfGetLastTradeDetailsEtf(@DateID) AS LTP 
 
 
END 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[BuildLtpHelper]'
GO
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 22/5/2017 
-- Description:	Calls query to put get last trade details for equity and ETF trade snapshot tables - both in ne helper table 
-- ============================================= 
CREATE PROCEDURE [ETL].[BuildLtpHelper] 
	@DateID INT 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	TRUNCATE TABLE ETL.FactEquityEtfLtpHelper 
 
	INSERT INTO 
			ETL.FactEquityEtfLtpHelper 
		SELECT 
			AggregationDateID, 
			InstrumentGlobalID, 
			PublishedDateTime, 
			TradeDateID, 
			TradeTimeID, 
			TradeTimestamp, 
			UTCTradeTimeStamp, 
			TradePrice			 
		FROM 
			ETL.udfGetLastTradeDetailsEquity(@DateID) AS LTP 
 
	INSERT INTO 
			ETL.FactEquityEtfLtpHelper 
		SELECT 
			AggregationDateID, 
			InstrumentGlobalID, 
			PublishedDateTime, 
			TradeDateID, 
			TradeTimeID, 
			TradeTimestamp, 
			UTCTradeTimeStamp, 
			TradePrice			 
		FROM 
			ETL.udfGetLastTradeDetailsEtf(@DateID) AS LTP 
 
 
END 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[FactEquitySnapshot]'
GO
CREATE TABLE [DWH].[FactEquitySnapshot] 
( 
[EquitySnapshotID] [int] NOT NULL IDENTITY(1, 1), 
[InstrumentID] [int] NOT NULL, 
[InstrumentStatusID] [smallint] NULL, 
[DateID] [int] NOT NULL, 
[LastExDivDateID] [int] NULL, 
[OCPDateID] [int] NULL, 
[OCPTimeID] [smallint] NULL, 
[OCPDateTime] [datetime2] NULL, 
[OCPTime] [time] NULL, 
[UtcOCPTime] [time] NULL, 
[LTPDateID] [int] NULL, 
[LTPTimeID] [smallint] NULL, 
[LTPDateTime] [datetime2] NULL, 
[LTPTime] [time] NULL, 
[UtcLTPTime] [time] NULL, 
[MarketID] [smallint] NULL, 
[TotalSharesInIssue] [numeric] (28, 6) NULL, 
[IssuedSharesToday] [numeric] (28, 6) NULL, 
[ExDivYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[OpenPrice] [numeric] (19, 6) NULL, 
[LowPrice] [numeric] (19, 6) NULL, 
[HighPrice] [numeric] (19, 6) NULL, 
[BidPrice] [numeric] (19, 6) NULL, 
[OfferPrice] [numeric] (19, 6) NULL, 
[ClosingAuctionBidPrice] [numeric] (19, 6) NULL, 
[ClosingAuctionOfferPrice] [numeric] (19, 6) NULL, 
[OCP] [numeric] (19, 6) NULL, 
[LTP] [numeric] (19, 6) NULL, 
[MarketCap] [numeric] (28, 6) NULL, 
[MarketCapEur] [numeric] (28, 6) NULL, 
[Turnover] [numeric] (19, 6) NULL, 
[TurnoverND] [numeric] (19, 6) NULL, 
[TurnoverEur] [numeric] (19, 6) NULL, 
[TurnoverNDEur] [numeric] (19, 6) NULL, 
[TurnoverOB] [numeric] (19, 6) NULL, 
[TurnoverOBEur] [numeric] (19, 6) NULL, 
[Volume] [bigint] NULL, 
[VolumeND] [bigint] NULL, 
[VolumeOB] [bigint] NULL, 
[Deals] [bigint] NULL, 
[DealsOB] [bigint] NULL, 
[DealsND] [bigint] NULL, 
[ISEQ20Shares] [numeric] (28, 6) NULL, 
[ISEQ20Price] [numeric] (19, 6) NULL, 
[ISEQ20Weighting] [numeric] (9, 6) NULL, 
[ISEQ20MarketCap] [numeric] (28, 6) NULL, 
[ISEQ20FreeFloat] [numeric] (19, 6) NULL, 
[ISEQOverallWeighting] [numeric] (9, 6) NULL, 
[ISEQOverallMarketCap] [numeric] (28, 6) NULL, 
[ISEQOverallBeta30] [numeric] (19, 6) NULL, 
[ISEQOverallBeta250] [numeric] (19, 6) NULL, 
[ISEQOverallFreefloat] [numeric] (19, 6) NULL, 
[ISEQOverallPrice] [numeric] (19, 6) NULL, 
[ISEQOverallShares] [numeric] (28, 6) NULL, 
[OverallIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[GeneralIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[FinancialIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[SmallCapIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ITEQIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ISEQ20IndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ESMIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExCapYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExEntitlementYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExRightsYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExSpecialYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[LseTurnover] [numeric] (19, 6) NULL, 
[LseVolume] [bigint] NULL, 
[ETFFMShares] [int] NULL, 
[BatchID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactEquitySnapshot] on [DWH].[FactEquitySnapshot]'
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [PK_FactEquitySnapshot] PRIMARY KEY CLUSTERED  ([EquitySnapshotID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FactEquitySnapshot] on [DWH].[FactEquitySnapshot]'
GO
CREATE NONCLUSTERED INDEX [IX_FactEquitySnapshot] ON [DWH].[FactEquitySnapshot] ([DateID], [InstrumentID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FactEquitySnapshot_1] on [DWH].[FactEquitySnapshot]'
GO
CREATE NONCLUSTERED INDEX [IX_FactEquitySnapshot_1] ON [DWH].[FactEquitySnapshot] ([InstrumentID], [DateID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EquityIndexMarketCapHelper]'
GO
  
  
CREATE VIEW [ETL].[EquityIndexMarketCapHelper] AS  
	WITH ISEQ20_Common  AS (  
				SELECT  
					DateID,  
					SUM(ISEQOverallMarketCap) AS MarketCap  
				FROM  
						DWH.FactEquitySnapshot F  
					INNER JOIN  
						ETL.AggregationDateList A  
					ON F.DateID = A.AggregateDateID  
				WHERE  
					ISEQ20IndexYN = 'Y'  
				GROUP BY  
					DateID  
			)  
		SELECT  
			DateID,  
			'IEOP' AS IndexCode,  
			SUM(ISEQOverallMarketCap) AS MarketCap  
		FROM  
				DWH.FactEquitySnapshot F  
			INNER JOIN  
				ETL.AggregationDateList A  
			ON F.DateID = A.AggregateDateID  
		WHERE  
			OverallIndexYN = 'Y'  
		GROUP BY  
			DateID  
  
		UNION ALL  
		SELECT  
			DateID,  
			'IEUP' AS IndexCode,  
			SUM(ISEQOverallMarketCap) AS MarketCap  
		FROM  
				DWH.FactEquitySnapshot F  
			INNER JOIN  
				ETL.AggregationDateList A  
			ON F.DateID = A.AggregateDateID  
		WHERE  
			FinancialIndexYN = 'Y'  
		GROUP BY  
			DateID  
		UNION ALL  
		SELECT  
			DateID,  
			'IEQP' AS IndexCode,  
			SUM(ISEQOverallMarketCap) AS MarketCap  
		FROM  
				DWH.FactEquitySnapshot F  
			INNER JOIN  
				ETL.AggregationDateList A  
			ON F.DateID = A.AggregateDateID  
		WHERE  
			GeneralIndexYN = 'Y'  
		GROUP BY  
			DateID  
		UNION ALL  
		SELECT  
			DateID,  
			'IEYP' AS IndexCode,  
			SUM(ISEQOverallMarketCap) AS MarketCap  
		FROM  
				DWH.FactEquitySnapshot F  
			INNER JOIN  
				ETL.AggregationDateList A  
			ON F.DateID = A.AggregateDateID  
		WHERE  
			SmallCapIndexYN = 'Y'  
		GROUP BY  
			DateID  
		UNION ALL  
  
		SELECT  
			DateID,  
			'IEOA' AS IndexCode,  
			SUM(ISEQOverallMarketCap) AS MarketCap  
		FROM  
				DWH.FactEquitySnapshot F  
			INNER JOIN  
				ETL.AggregationDateList A  
			ON F.DateID = A.AggregateDateID  
		WHERE  
			ESMIndexYN = 'Y'  
		GROUP BY  
			DateID  
		UNION ALL  
		SELECT  
			DateID,  
			'IEEP' AS IndexCode,  
			MarketCap  
		FROM  
			ISEQ20_Common    
		UNION ALL  
		SELECT  
			DateID,  
			'IEOD' AS IndexCode,  
			MarketCap  
		FROM  
			ISEQ20_Common    
		UNION ALL  
		SELECT  
			DateID,  
			'IEOC' AS IndexCode,  
			MarketCap  
		FROM  
			ISEQ20_Common    
		UNION ALL  
		SELECT  
			DateID,  
			'IEOE' AS IndexCode,  
			MarketCap  
		FROM  
			ISEQ20_Common    
	  
  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[FactEquityPriceSnapshot]'
GO
CREATE TABLE [DWH].[FactEquityPriceSnapshot] 
( 
[SampleDateID] [int] NOT NULL, 
[SampleTime] [time] NOT NULL, 
[InstrumentID] [int] NOT NULL, 
[LtpDateID] [int] NULL, 
[LtpTimeID] [smallint] NULL, 
[LTP] [numeric] (19, 6) NULL, 
[BatchID] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactEquityPriceSnapshot] on [DWH].[FactEquityPriceSnapshot]'
GO
ALTER TABLE [DWH].[FactEquityPriceSnapshot] ADD CONSTRAINT [PK_FactEquityPriceSnapshot] PRIMARY KEY CLUSTERED  ([SampleDateID], [SampleTime], [InstrumentID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimFile]'
GO
CREATE TABLE [DWH].[DimFile] 
( 
[FileID] [int] NOT NULL IDENTITY(1, 1), 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileTypeTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[SaftFileLetter] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL, 
[ExpectedTimeID] [smallint] NULL, 
[FileProcessedTime] [datetime2] NOT NULL, 
[FileProcessedStatus] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[ExpectedStartTime] [time] NULL, 
[ExpectedFinishTime] [time] NULL, 
[ContainsEndOfDayDetails] [char] (1) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimFile] on [DWH].[DimFile]'
GO
ALTER TABLE [DWH].[DimFile] ADD CONSTRAINT [PK_DimFile] PRIMARY KEY CLUSTERED  ([FileID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[AddFactPriceEquitySnapshot]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 10/5/2017  
-- Description:	Take a price sample from FactEquitySnapshot and FactEtfSnapshot for website  
-- =============================================  
CREATE PROCEDURE [ETL].[AddFactPriceEquitySnapshot]  
	@DateID INT,  
	@BatchID INT   
AS  
BEGIN  
	-- SET NOCOUNT ON added to prevent extra result sets from  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
	  
	DECLARE @DateChar CHAR(8) = CAST(@DateID AS CHAR)  
  
	/* GET THE TIME FROM THE DimFile TABLE */  
  
	DECLARE @SampleTime TIME  
	  
	SELECT  
		@SampleTime = MAX(ExpectedStartTime)  
	FROM  
		DWH.DimFile  
	WHERE  
			FileTypeTag = 'TxSaft'  
		AND  
			CHARINDEX(@DateChar,FileName) <> 0  
		AND  
			FileProcessedStatus = 'COMPLETE'  
  
	IF @SampleTime IS NOT NULL  
	BEGIN  
  
		/* BIT PRIMATIVE */  
  
		/* DELETE EXISITNG ROWS */  
  
		DELETE  
			F  
		FROM	  
			DWH.FactEquityPriceSnapshot F  
		WHERE  
			F.SampleDateID = @DateID  
		AND   
			F.SampleTime = @SampleTime  
  
		INSERT INTO  
				DWH.FactEquityPriceSnapshot  
			(  
				SampleDateID,   
				SampleTime,   
				InstrumentID,   
				LtpDateID,   
				LtpTimeID,   
				LTP,   
				BatchID  
			)  
			SELECT  
				@DateID,  
				@SampleTime,  
				InstrumentID,  
				LTPDateID,  
				LTPTimeID,  
				LTP,  
				@BatchID AS BatchID  
			FROM  
				DWH.FactEquitySnapshot  
			WHERE  
				DateID = @DateID  
			UNION ALL  
			SELECT			  
				@DateID,  
				@SampleTime,  
				InstrumentID,  
				LTPDateID,  
				LTPTimeID,  
				LTP,  
				@BatchID AS BatchID  
			FROM  
				DWH.FactEtfSnapshot	  
			WHERE  
				DateID = @DateID  
		  
	END  
  
END  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[XtUpdateType]'
GO
CREATE TABLE [ETL].[XtUpdateType] 
( 
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[UpdateType] [varchar] (10) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[XtDimInstrument]'
GO
CREATE TABLE [ETL].[XtDimInstrument] 
( 
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentName] [varchar] (450) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentType] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SecurityType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[SEDOL] [varchar] (7) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentStatusDate] [datetime] NULL, 
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CompanyGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[MarketName] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[WKN] [varchar] (6) COLLATE Latin1_General_CI_AS NULL, 
[MNEM] [varchar] (4) COLLATE Latin1_General_CI_AS NULL, 
[GeneralIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentListedDate] [datetime] NULL, 
[InstrumentSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NULL, 
[ISEQ20IndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[IssuerSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NULL, 
[ITEQIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[LastEXDivDate] [date] NULL, 
[OverallIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[FinancialIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[SmallCapIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[IssuedDate] [datetime] NULL, 
[UnitOfQuotation] [numeric] (23, 10) NULL, 
[ISEQ20Freefloat] [numeric] (23, 10) NULL, 
[ISEQOverallFreeFloat] [numeric] (23, 10) NULL, 
[CFIName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CFICode] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[TotalSharesInIssue] [numeric] (28, 6) NULL, 
[CompanyListedDate] [datetime] NULL, 
[CompanyApprovalDate] [datetime] NULL, 
[CompanyApprovalType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Note] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL, 
[TransparencyDirectiveYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[MarketAbuseDirectiveYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[ProspectusDirectiveYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryBusinessSector] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector1] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector2] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector3] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector4] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector5] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[IssuerGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[IssuerName] [varchar] (300) COLLATE Latin1_General_CI_AS NULL, 
[IssuerDomicile] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[FinancialYearEndDate] [datetime] NULL, 
[IncorporationDate] [datetime] NULL, 
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[TransparencyDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[ProspectusDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[IssuerDomicileDomesticYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[FeeCodeName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[ESMIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentDomesticYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentStatusID] [smallint] NULL, 
[CompanyStatusID] [smallint] NULL, 
[CurrencyID] [smallint] NULL, 
[QuotationCurrencyID] [smallint] NULL, 
[MarketID] [smallint] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimInstrumentEquity]'
GO
CREATE TABLE [DWH].[DimInstrumentEquity] 
( 
[InstrumentID] [int] NOT NULL, 
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentName] [varchar] (256) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[SecurityType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[SEDOL] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentStatusID] [smallint] NOT NULL, 
[InstrumentStatusDate] [date] NOT NULL, 
[InstrumentListedDate] [date] NULL, 
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[CompanyGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[CompanyListedDate] [date] NULL, 
[CompanyApprovalType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[CompanyApprovalDate] [date] NULL, 
[TransparencyDirectiveYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketAbuseDirectiveYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProspectusDirectiveYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketID] [smallint] NOT NULL, 
[IssuerDomicile] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[WKN] [varchar] (6) COLLATE Latin1_General_CI_AS NOT NULL, 
[MNEM] [varchar] (4) COLLATE Latin1_General_CI_AS NOT NULL, 
[PrimaryBusinessSector] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[SubBusinessSector1] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[SubBusinessSector2] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[SubBusinessSector3] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[SubBusinessSector4] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[SubBusinessSector5] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[OverallIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[GeneralIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[FinancialIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[SmallCapIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[ITEQIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[ISEQ20IndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[ESMIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FinancialYearEndDate] [date] NULL, 
[IncorporationDate] [date] NULL, 
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[TransparencyDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProspectusDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerDomicileDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[FeeCodeName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuedDate] [date] NULL, 
[CurrencyID] [smallint] NOT NULL, 
[UnitOfQuotation] [numeric] (19, 9) NOT NULL, 
[QuotationCurrencyID] [smallint] NOT NULL, 
[ISEQ20Freefloat] [numeric] (19, 6) NOT NULL, 
[ISEQOverallFreeFloat] [numeric] (19, 6) NOT NULL, 
[IssuerSedolMasterFileName] [varchar] (35) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[CFIName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[CFICode] [varchar] (6) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NOT NULL, 
[TotalSharesInIssue] [numeric] (28, 6) NOT NULL, 
[LastEXDivDate] [date] NULL, 
[CompanyStatusID] [smallint] NOT NULL, 
[Note] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[StartDate] [datetime2] NOT NULL, 
[EndDate] [datetime2] NULL, 
[CurrentRowYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[BatchID] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimInstrumentEquity] on [DWH].[DimInstrumentEquity]'
GO
ALTER TABLE [DWH].[DimInstrumentEquity] ADD CONSTRAINT [PK_DimInstrumentEquity] PRIMARY KEY CLUSTERED  ([InstrumentID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[UpdateDimInstrument]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 24/5/2017 
-- Description:	Update DimInstrument and variants.... 
-- ============================================= 
CREATE PROCEDURE [ETL].[UpdateDimInstrument] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	BEGIN TRY  
 
		BEGIN TRANSACTION 
 
		/* EXPIRE OLD SCD-2s */ 
		UPDATE 
			I 
		SET 
			CurrentRowYN = 'N', 
			EndDate = GETDATE() 
		FROM 
			ETL.XtUpdateType XT 
		INNER JOIN 
			DWH.DimInstrument I 
		ON XT.InstrumentGlobalID = I.InstrumentGlobalID 
		WHERE 
			XT.UpdateType = 'SCD-2' 
		AND 
			I.CurrentRowYN = 'Y' 
 
		UPDATE 
			I 
		SET 
			CurrentRowYN = 'N', 
			EndDate = GETDATE() 
		FROM 
			ETL.XtUpdateType XT 
		INNER JOIN 
			DWH.DimInstrumentEquity I 
		ON XT.InstrumentGlobalID = I.InstrumentGlobalID 
		WHERE 
			XT.UpdateType = 'SCD-2' 
		AND 
			I.CurrentRowYN = 'Y' 
 
		UPDATE 
			I 
		SET 
			CurrentRowYN = 'N', 
			EndDate = GETDATE() 
		FROM 
			ETL.XtUpdateType XT 
		INNER JOIN 
			DWH.DimInstrumentEtf I 
		ON XT.InstrumentGlobalID = I.InstrumentGlobalID 
		WHERE 
			XT.UpdateType = 'SCD-2' 
		AND 
			I.CurrentRowYN = 'Y' 
 
 
		/* INSERT NEW INSTRUMENTS / UPDATE TYPE 2s */ 
 
		INSERT INTO 
				DWH.DimInstrument 
			( 
				InstrumentGlobalID,  
				InstrumentName,  
				InstrumentType,  
				SecurityType,  
				ISIN,  
				SEDOL,  
				InstrumentStatusID,  
				InstrumentStatusDate,  
				InstrumentListedDate,  
				IssuerName,  
				IssuerGlobalID,  
				MarketID,  
				IssuerDomicile,  
				FinancialYearEndDate,  
				IncorporationDate,  
				LegalStructure,  
				AccountingStandard,  
				TransparencyDirectiveHomeMemberCountry,  
				ProspectusDirectiveHomeMemberCountry,  
				IssuerDomicileDomesticYN,  
				FeeCodeName,  
				WKN,  
				MNEM,  
				IssuedDate,  
				IssuerSedolMasterFileName,  
				CompanyGlobalID,  
				CompanyApprovalDate,  
				CompanyApprovalType,  
				InstrumentDomesticYN,  
				InstrumentSedolMasterFileName,  
				StartDate,  
				CurrentRowYN,  
				BatchID 
			) 
			SELECT 
				InstrumentGlobalID,  
				InstrumentName,  
				InstrumentType,  
				SecurityType,  
				ISIN,  
				SEDOL,  
				InstrumentStatusID,  
				InstrumentStatusDate,  
				InstrumentListedDate,  
				IssuerName,  
				IssuerGlobalID,  
				MarketID,  
				IssuerDomicile,  
				FinancialYearEndDate,  
				IncorporationDate,  
				LegalStructure,  
				AccountingStandard,  
				TransparencyDirectiveHomeMemberCountry,  
				ProspectusDirectiveHomeMemberCountry,  
				IssuerDomicileDomesticYN,  
				FeeCodeName,  
				WKN,  
				MNEM,  
				IssuedDate,  
				IssuerSedolMasterFileName,  
				CompanyGlobalID,  
				CompanyApprovalDate,  
				CompanyApprovalType,  
				InstrumentDomesticYN,  
				InstrumentSedolMasterFileName,  
				GETDATE(), 
				'Y',  
				-1 
			FROM 
				ETL.XtDimInstrument I 
			WHERE 
				InstrumentGlobalID IN ( 
							SELECT 
								InstrumentGlobalID  
							FROM 
								ETL.XtUpdateType 
							WHERE 
								UpdateType IN ( 'NEW', 'SCD-2' ) 
					) 
 
 
 
		INSERT INTO 
				DWH.DimInstrumentEquity 
			( 
				InstrumentID,  
				InstrumentGlobalID,  
				InstrumentName,  
				InstrumentType,  
				SecurityType,  
				ISIN,  
				SEDOL,  
				InstrumentStatusID,  
				InstrumentStatusDate,  
				InstrumentListedDate,  
				TradingSysInstrumentName,  
				IssuerName,  
				IssuerGlobalID,  
				CompanyGlobalID,  
				CompanyListedDate,  
				CompanyApprovalType,  
				CompanyApprovalDate,  
				TransparencyDirectiveYN,  
				MarketAbuseDirectiveYN,  
				ProspectusDirectiveYN,  
				MarketID,  
				IssuerDomicile,  
				WKN,  
				MNEM,  
				PrimaryBusinessSector,  
				SubBusinessSector1,  
				SubBusinessSector2,  
				SubBusinessSector3,  
				SubBusinessSector4,  
				SubBusinessSector5,  
				OverallIndexYN,  
				GeneralIndexYN,  
				FinancialIndexYN,  
				SmallCapIndexYN,  
				ITEQIndexYN,  
				ISEQ20IndexYN,  
				ESMIndexYN,  
				PrimaryMarket,  
				FinancialYearEndDate,  
				IncorporationDate,  
				LegalStructure,  
				AccountingStandard,  
				TransparencyDirectiveHomeMemberCountry,  
				ProspectusDirectiveHomeMemberCountry,  
				IssuerDomicileDomesticYN,  
				FeeCodeName,  
				IssuedDate,  
				CurrencyID,  
				UnitOfQuotation,  
				QuotationCurrencyID,  
				ISEQ20Freefloat,  
				ISEQOverallFreeFloat,  
				IssuerSedolMasterFileName,  
				InstrumentDomesticYN,  
				CFIName,  
				CFICode,  
				InstrumentSedolMasterFileName,  
				TotalSharesInIssue,  
				LastEXDivDate,  
				CompanyStatusID,  
				Note,  
				StartDate,  
				CurrentRowYN,  
				BatchID 
			) 
			SELECT 
				InstrumentID = ( 
							SELECT	 
								I2.InstrumentID 		 
							FROM 
								DWH.DimInstrument I2 
							WHERE 
								I.InstrumentGlobalID = I2.InstrumentGlobalID 
							AND 
								I2.CurrentRowYN = 'Y' 
						), 
				InstrumentGlobalID,  
				InstrumentName,  
				InstrumentType,  
				SecurityType,  
				ISIN,  
				SEDOL,  
				InstrumentStatusID,  
				InstrumentStatusDate,  
				InstrumentListedDate,  
				TradingSysInstrumentName,  
				IssuerName,  
				IssuerGlobalID,  
				CompanyGlobalID,  
				CompanyListedDate,  
				CompanyApprovalType,  
				CompanyApprovalDate,  
				TransparencyDirectiveYN,  
				MarketAbuseDirectiveYN,  
				ProspectusDirectiveYN,  
				MarketID,  
				IssuerDomicile,  
				WKN,  
				MNEM,  
				PrimaryBusinessSector,  
				SubBusinessSector1,  
				SubBusinessSector2,  
				SubBusinessSector3,  
				SubBusinessSector4,  
				SubBusinessSector5,  
				OverallIndexYN,  
				GeneralIndexYN,  
				FinancialIndexYN,  
				SmallCapIndexYN,  
				ITEQIndexYN,  
				ISEQ20IndexYN,  
				ESMIndexYN,  
				PrimaryMarket,  
				FinancialYearEndDate,  
				IncorporationDate,  
				LegalStructure,  
				AccountingStandard,  
				TransparencyDirectiveHomeMemberCountry,  
				ProspectusDirectiveHomeMemberCountry,  
				IssuerDomicileDomesticYN,  
				FeeCodeName,  
				IssuedDate,  
				CurrencyID,  
				UnitOfQuotation,  
				QuotationCurrencyID,  
				ISEQ20Freefloat,  
				ISEQOverallFreeFloat,  
				IssuerSedolMasterFileName,  
				InstrumentDomesticYN,  
				CFIName,  
				CFICode,  
				InstrumentSedolMasterFileName,  
				TotalSharesInIssue,  
				LastEXDivDate,  
				CompanyStatusID,  
				Note,  
				GETDATE(), 
				'Y',  
				-1 
			FROM 
				ETL.XtDimInstrument I 
			WHERE 
				InstrumentType <> 'ETF' 
			AND 
				InstrumentGlobalID IN ( 
							SELECT 
								InstrumentGlobalID  
							FROM 
								ETL.XtUpdateType 
							WHERE 
								UpdateType IN ( 'NEW', 'SCD-2' ) 
					) 
 
 
		INSERT INTO 
				DWH.DimInstrumentEtf	 
			( 
				InstrumentID,  
				InstrumentGlobalID,  
				InstrumentName,  
				InstrumentType,  
				SecurityType,  
				ISIN,  
				SEDOL,  
				InstrumentStatusID,  
				InstrumentStatusDate,  
				InstrumentListedDate,  
				TradingSysInstrumentName,  
				IssuerName,  
				IssuerGlobalID,  
				CompanyGlobalID,  
				CompanyListedDate,  
				CompanyApprovalType,  
				CompanyApprovalDate,  
				TransparencyDirectiveYN,  
				MarketAbuseDirectiveYN,  
				ProspectusDirectiveYN,  
				MarketID,  
				IssuerDomicile,  
				WKN,  
				MNEM,  
				PrimaryBusinessSector,  
				SubBusinessSector1,  
				SubBusinessSector2,  
				SubBusinessSector3,  
				SubBusinessSector4,  
				SubBusinessSector5,  
				OverallIndexYN,  
				GeneralIndexYN,  
				FinancialIndexYN,  
				SmallCapIndexYN,  
				ITEQIndexYN,  
				ISEQ20IndexYN,  
				ESMIndexYN,  
				PrimaryMarket,  
				FinancialYearEndDate,  
				IncorporationDate,  
				LegalStructure,  
				AccountingStandard,  
				TransparencyDirectiveHomeMemberCountry,  
				ProspectusDirectiveHomeMemberCountry,  
				IssuerDomicileDomesticYN,  
				FeeCodeName,  
				IssuedDate,  
				CurrencyID,  
				UnitOfQuotation,  
				QuotationCurrencyID,  
				ISEQ20Freefloat,  
				ISEQOverallFreeFloat,  
				IssuerSedolMasterFileName,  
				InstrumentDomesticYN,  
				CFIName,  
				CFICode,  
				InstrumentSedolMasterFileName,  
				TotalSharesInIssue,  
				LastEXDivDate,  
				CompanyStatusID,  
				Note,  
				StartDate,  
				CurrentRowYN,  
				BatchID 
			) 
			SELECT 
				InstrumentID = ( 
							SELECT	 
								I2.InstrumentID 		 
							FROM 
								DWH.DimInstrument I2 
							WHERE 
								I.InstrumentGlobalID = I2.InstrumentGlobalID 
							AND 
								I2.CurrentRowYN = 'Y' 
						), 
				InstrumentGlobalID,  
				InstrumentName,  
				InstrumentType,  
				SecurityType,  
				ISIN,  
				SEDOL,  
				InstrumentStatusID,  
				InstrumentStatusDate,  
				InstrumentListedDate,  
				TradingSysInstrumentName,  
				IssuerName,  
				IssuerGlobalID,  
				CompanyGlobalID,  
				CompanyListedDate,  
				CompanyApprovalType,  
				CompanyApprovalDate,  
				TransparencyDirectiveYN,  
				MarketAbuseDirectiveYN,  
				ProspectusDirectiveYN,  
				MarketID,  
				IssuerDomicile,  
				WKN,  
				MNEM,  
				PrimaryBusinessSector,  
				SubBusinessSector1,  
				SubBusinessSector2,  
				SubBusinessSector3,  
				SubBusinessSector4,  
				SubBusinessSector5,  
				OverallIndexYN,  
				GeneralIndexYN,  
				FinancialIndexYN,  
				SmallCapIndexYN,  
				ITEQIndexYN,  
				ISEQ20IndexYN,  
				ESMIndexYN,  
				PrimaryMarket,  
				FinancialYearEndDate,  
				IncorporationDate,  
				LegalStructure,  
				AccountingStandard,  
				TransparencyDirectiveHomeMemberCountry,  
				ProspectusDirectiveHomeMemberCountry,  
				IssuerDomicileDomesticYN,  
				FeeCodeName,  
				IssuedDate,  
				CurrencyID,  
				UnitOfQuotation,  
				QuotationCurrencyID,  
				ISEQ20Freefloat,  
				ISEQOverallFreeFloat,  
				IssuerSedolMasterFileName,  
				InstrumentDomesticYN,  
				CFIName,  
				CFICode,  
				InstrumentSedolMasterFileName,  
				TotalSharesInIssue,  
				LastEXDivDate,  
				CompanyStatusID,  
				Note,  
				GETDATE(), 
				'Y',  
				-1 
			FROM 
				ETL.XtDimInstrument I 
			WHERE 
				InstrumentType = 'ETF' 
			AND 
				InstrumentGlobalID IN ( 
							SELECT 
								InstrumentGlobalID  
							FROM 
								ETL.XtUpdateType 
							WHERE 
								UpdateType IN ( 'NEW', 'SCD-2' ) 
					) 
 
 
		/* SCD TYPE 1s */ 
 
		UPDATE 
			I 
		SET 
			SecurityType = I_upd.SecurityType, 
			InstrumentStatusID = I_upd.InstrumentStatusID, 
			InstrumentStatusDate = I_upd.InstrumentStatusDate, 
			InstrumentListedDate = I_upd.InstrumentListedDate, 
			CompanyApprovalType = I_upd.CompanyApprovalType, 
			CompanyApprovalDate = I_upd.CompanyApprovalDate, 
			IssuerDomicile = I_upd.IssuerDomicile, 
			WKN = I_upd.WKN, 
			MNEM = I_upd.MNEM, 
			FinancialYearEndDate = I_upd.FinancialYearEndDate, 
			IncorporationDate = I_upd.IncorporationDate, 
			LegalStructure = I_upd.LegalStructure, 
			AccountingStandard = I_upd.AccountingStandard, 
			TransparencyDirectiveHomeMemberCountry = I_upd.TransparencyDirectiveHomeMemberCountry, 
			ProspectusDirectiveHomeMemberCountry = I_upd.ProspectusDirectiveHomeMemberCountry, 
			IssuerDomicileDomesticYN = I_upd.IssuerDomicileDomesticYN, 
			FeeCodeName = I_upd.FeeCodeName, 
			IssuerSedolMasterFileName = I_upd.IssuerSedolMasterFileName, 
			InstrumentDomesticYN = I_upd.InstrumentDomesticYN, 
			InstrumentSedolMasterFileName = I_upd.InstrumentSedolMasterFileName 
		FROM 
				ETL.XtUpdateType XT 
			INNER JOIN 
				DWH.DimInstrument I 
			ON XT.InstrumentGlobalID = I.InstrumentGlobalID 
			INNER JOIN 
				ETL.XtDimInstrument I_upd 
			ON I.InstrumentGlobalID = I_upd.InstrumentGlobalID 
		WHERE 
			XT.UpdateType = 'SCD-1' 
 
 
		UPDATE 
			DWH.DimInstrumentEquity 
		SET 
			SecurityType = I_upd.SecurityType, 
			InstrumentStatusID = I_upd.InstrumentStatusID, 
			InstrumentStatusDate = I_upd.InstrumentStatusDate, 
			InstrumentListedDate = I_upd.InstrumentListedDate, 
			CompanyListedDate = I_upd.CompanyListedDate, 
			CompanyApprovalType = I_upd.CompanyApprovalType, 
			CompanyApprovalDate = I_upd.CompanyApprovalDate, 
			IssuerDomicile = I_upd.IssuerDomicile, 
			WKN = I_upd.WKN, 
			MNEM = I_upd.MNEM, 
			PrimaryBusinessSector = I_upd.PrimaryBusinessSector, 
			SubBusinessSector1 = I_upd.SubBusinessSector1, 
			SubBusinessSector2 = I_upd.SubBusinessSector2, 
			SubBusinessSector3 = I_upd.SubBusinessSector3, 
			SubBusinessSector4 = I_upd.SubBusinessSector4, 
			SubBusinessSector5 = I_upd.SubBusinessSector5, 
			FinancialYearEndDate = I_upd.FinancialYearEndDate, 
			IncorporationDate = I_upd.IncorporationDate, 
			LegalStructure = I_upd.LegalStructure, 
			AccountingStandard = I_upd.AccountingStandard, 
			TransparencyDirectiveHomeMemberCountry = I_upd.TransparencyDirectiveHomeMemberCountry, 
			ProspectusDirectiveHomeMemberCountry = I_upd.ProspectusDirectiveHomeMemberCountry, 
			IssuerDomicileDomesticYN = I_upd.IssuerDomicileDomesticYN, 
			FeeCodeName = I_upd.FeeCodeName, 
			IssuedDate = I_upd.IssuedDate, 
			CurrencyID = I_upd.CurrencyID, 
			UnitOfQuotation = I_upd.UnitOfQuotation, 
			QuotationCurrencyID = I_upd.QuotationCurrencyID, 
			IssuerSedolMasterFileName = I_upd.IssuerSedolMasterFileName, 
			InstrumentDomesticYN = I_upd.InstrumentDomesticYN, 
			CFIName = I_upd.CFIName, 
			CFICode = I_upd.CFICode, 
			InstrumentSedolMasterFileName = I_upd.InstrumentSedolMasterFileName, 
			LastEXDivDate = I_upd.LastEXDivDate, 
			CompanyStatusID = I_upd.CompanyStatusID, 
			Note = I_upd.Note 
		FROM 
				ETL.XtUpdateType XT 
			INNER JOIN 
				DWH.DimInstrumentEtf I 
			ON XT.InstrumentGlobalID = I.InstrumentGlobalID 
			INNER JOIN 
				ETL.XtDimInstrument I_upd 
			ON I.InstrumentGlobalID = I_upd.InstrumentGlobalID 
		WHERE 
			XT.UpdateType = 'SCD-1' 
 
 
		UPDATE 
			DWH.DimInstrumentEtf 
		SET 
			SecurityType = I_upd.SecurityType, 
			InstrumentStatusID = I_upd.InstrumentStatusID, 
			InstrumentStatusDate = I_upd.InstrumentStatusDate, 
			InstrumentListedDate = I_upd.InstrumentListedDate, 
			CompanyListedDate = I_upd.CompanyListedDate, 
			CompanyApprovalType = I_upd.CompanyApprovalType, 
			CompanyApprovalDate = I_upd.CompanyApprovalDate, 
			IssuerDomicile = I_upd.IssuerDomicile, 
			WKN = I_upd.WKN, 
			MNEM = I_upd.MNEM, 
			PrimaryBusinessSector = I_upd.PrimaryBusinessSector, 
			SubBusinessSector1 = I_upd.SubBusinessSector1, 
			SubBusinessSector2 = I_upd.SubBusinessSector2, 
			SubBusinessSector3 = I_upd.SubBusinessSector3, 
			SubBusinessSector4 = I_upd.SubBusinessSector4, 
			SubBusinessSector5 = I_upd.SubBusinessSector5, 
			FinancialYearEndDate = I_upd.FinancialYearEndDate, 
			IncorporationDate = I_upd.IncorporationDate, 
			LegalStructure = I_upd.LegalStructure, 
			AccountingStandard = I_upd.AccountingStandard, 
			TransparencyDirectiveHomeMemberCountry = I_upd.TransparencyDirectiveHomeMemberCountry, 
			ProspectusDirectiveHomeMemberCountry = I_upd.ProspectusDirectiveHomeMemberCountry, 
			IssuerDomicileDomesticYN = I_upd.IssuerDomicileDomesticYN, 
			FeeCodeName = I_upd.FeeCodeName, 
			IssuedDate = I_upd.IssuedDate, 
			CurrencyID = I_upd.CurrencyID, 
			UnitOfQuotation = I_upd.UnitOfQuotation, 
			QuotationCurrencyID = I_upd.QuotationCurrencyID, 
			IssuerSedolMasterFileName = I_upd.IssuerSedolMasterFileName, 
			InstrumentDomesticYN = I_upd.InstrumentDomesticYN, 
			CFIName = I_upd.CFIName, 
			CFICode = I_upd.CFICode, 
			InstrumentSedolMasterFileName = I_upd.InstrumentSedolMasterFileName, 
			LastEXDivDate = I_upd.LastEXDivDate, 
			CompanyStatusID = I_upd.CompanyStatusID, 
			Note = I_upd.Note 
		FROM 
				ETL.XtUpdateType XT 
			INNER JOIN 
				DWH.DimInstrumentEtf I 
			ON XT.InstrumentGlobalID = I.InstrumentGlobalID 
			INNER JOIN 
				ETL.XtDimInstrument I_upd 
			ON I.InstrumentGlobalID = I_upd.InstrumentGlobalID 
		WHERE 
			XT.UpdateType = 'SCD-1' 
 
 
 
		COMMIT 
	END TRY 
 
	BEGIN CATCH 
		PRINT 'NOT LOOKING GOOD!!!' 
 
		ROLLBACK 
 
	END CATCH 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[ValidateDwhDimInstrument]'
GO
 
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 25/5/2017   
-- Description:	Validates DimInstrument  
-- =============================================   
CREATE PROCEDURE [ETL].[ValidateDwhDimInstrument]    
AS   
BEGIN   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
 
	SELECT 
		-1 AS Code, 
		'There are inconsistencies in the Instrument Dimension. The numer of rows in the DimInstrument table does not match the total in the DimInstrumentEquity and DimInstrumentEtf tables' AS Message 
	WHERE 
			(	SELECT COUNT(*) FROM DWH.DimInstrument	)  
		<> 
			(( SELECT COUNT(*) FROM DWH.DimInstrumentEquity ) + ( SELECT COUNT(*) FROM DWH.DimInstrumentEtf )) 
	UNION  
	SELECT 
		-2, 
		'DimInstrument with missing DimInstrumentEquity or DimInstrumentEtf entry. Review InstrumentID [' + STR(InstrumentID) + ']' 
	FROM 
		DWH.DimInstrument 
	WHERE 
			InstrumentID NOT IN ( SELECT InstrumentID FROM DWH.DimInstrumentEquity ) 
		AND 
			InstrumentID NOT IN ( SELECT InstrumentID FROM DWH.DimInstrumentEtf ) 
	UNION 
	SELECT 
		-3, 
		'DimInstrument without Current row. Review InstrumentGlobalID [' + STR(InstrumentID) + ']' 
	FROM 
		DWH.DimInstrument 
	WHERE 
		InstrumentGlobalID NOT IN ( SELECT InstrumentGlobalID FROM DWH.DimInstrument WHERE CurrentRowYN = 'Y' ) 
	 
 
   
END   
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[FactMarketAggregationSnapshot]'
GO
CREATE TABLE [DWH].[FactMarketAggregationSnapshot] 
( 
[DateID] [int] NOT NULL, 
[MarketAggregationID] [tinyint] NOT NULL, 
[TurnoverEur] [numeric] (19, 6) NOT NULL, 
[Volume] [bigint] NOT NULL, 
[TurnoverEurConditional] [numeric] (19, 6) NOT NULL, 
[VolumeConditional] [bigint] NOT NULL, 
[BatchID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactMarketAggregation_1] on [DWH].[FactMarketAggregationSnapshot]'
GO
ALTER TABLE [DWH].[FactMarketAggregationSnapshot] ADD CONSTRAINT [PK_FactMarketAggregation_1] PRIMARY KEY CLUSTERED  ([DateID], [MarketAggregationID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FactMarketAggregation] on [DWH].[FactMarketAggregationSnapshot]'
GO
CREATE NONCLUSTERED INDEX [IX_FactMarketAggregation] ON [DWH].[FactMarketAggregationSnapshot] ([DateID], [MarketAggregationID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimStatus]'
GO
CREATE TABLE [DWH].[DimStatus] 
( 
[StatusID] [smallint] NOT NULL IDENTITY(1, 1), 
[StatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[ConditionalTradingYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimStatus] on [DWH].[DimStatus]'
GO
ALTER TABLE [DWH].[DimStatus] ADD CONSTRAINT [PK_DimStatus] PRIMARY KEY CLUSTERED  ([StatusID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimMarketAggregation]'
GO
CREATE TABLE [DWH].[DimMarketAggregation] 
( 
[MarketAggregationID] [tinyint] NOT NULL IDENTITY(1, 1), 
[MarketCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[ReportingMarketCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimMarketAggregation] on [DWH].[DimMarketAggregation]'
GO
ALTER TABLE [DWH].[DimMarketAggregation] ADD CONSTRAINT [PK_DimMarketAggregation] PRIMARY KEY CLUSTERED  ([MarketAggregationID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimMarket]'
GO
CREATE TABLE [DWH].[DimMarket] 
( 
[MarketID] [smallint] NOT NULL IDENTITY(1, 1), 
[MarketCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[ReportingMarketCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimMarket] on [DWH].[DimMarket]'
GO
ALTER TABLE [DWH].[DimMarket] ADD CONSTRAINT [PK_DimMarket] PRIMARY KEY CLUSTERED  ([MarketID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[ApplyFactMarketAggrgation]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 21/3/2017  
-- Description:	Apply market aggregations  
-- =============================================  
CREATE PROCEDURE [DWH].[ApplyFactMarketAggrgation]  
	@DateID INT,  
	@BatchID INT  
AS  
BEGIN  
	SET NOCOUNT ON;  
  
	SELECT  
		MA.MarketAggregationID,  
		F.DateID,  
		SUM(F.TurnoverEur) AS TurnoverEur,  
		SUM(F.Volume) AS Volume,  
		SUM(IIF(ConditionalTradingYN = 'Y', F.TurnoverEur, 0)) AS TurnoverEurConditional,  
		SUM(IIF(ConditionalTradingYN = 'Y', F.Volume, 0)) AS VolumeConditional  
	INTO  
		#Aggregations  
	FROM  
			DWH.DimInstrumentEquity I  
		INNER JOIN  
			DWH.FactEquitySnapshot F  
		ON I.InstrumentID = F.InstrumentID  
		INNER JOIN  
			DWH.DimStatus S  
		ON F.InstrumentStatusID = S.StatusID  
		INNER JOIN  
			DWH.DimMarket MK  
		ON I.MarketID = MK.MarketID  
		INNER JOIN  
			DWH.DimMarketAggregation MA  
		ON MK.MarketCode = MA.MarketCode   
	WHERE  
		F.DateID = @DateID  
	GROUP BY  
		MA.MarketAggregationID,  
		F.DateID  
	UNION ALL  
	SELECT  
		( /* Slightly dangerous query pattern - ccan lead to performance issues if abused */  
			SELECT   
				MAX(MarketAggregationID)   
			FROM   
				DWH.DimMarketAggregation  
			WHERE  
				MarketCode = 'ETF'  
		) AS MarketID,  
		F.DateID,  
		SUM(F.TurnoverEur) AS TurnoverEur,  
		SUM(F.Volume) AS Volume,  
		SUM(IIF(ConditionalTradingYN = 'Y', F.TurnoverEur, 0)) AS TurnoverEurConditional,  
		SUM(IIF(ConditionalTradingYN = 'Y', F.Volume, 0)) AS VolumeConditional  
	FROM  
			DWH.DimInstrumentEtf I  
		INNER JOIN  
			DWH.FactEtfSnapshot F  
		ON I.InstrumentID = F.InstrumentID  
		INNER JOIN  
			DWH.DimStatus S  
		ON F.InstrumentStatusID = S.StatusID  
	WHERE  
		F.DateID = @DateID  
	GROUP BY  
		F.DateID  
  
  
	UPDATE  
		#Aggregations  
	SET  
		TurnoverEur = ISNULL(TurnoverEur,0),  
		Volume = ISNULL(Volume,0),  
		TurnoverEurConditional = ISNULL(TurnoverEurConditional,0),  
		VolumeConditional = ISNULL(VolumeConditional,0)  
  
  
	DELETE  
		#Aggregations  
	WHERE  
		TurnoverEur = 0   
	AND  
		Volume = 0  
	AND  
		TurnoverEurConditional = 0  
	AND  
		VolumeConditional = 0  
  
  
	/* UPDATE EXISTING */  
	  
	UPDATE	  
		F  
	SET  
		TurnoverEur = T.TurnoverEur,   
		Volume = T.Volume,   
		TurnoverEurConditional = T.TurnoverEurConditional,   
		VolumeConditional = T.VolumeConditional,  
		BatchID = @BatchID  
	FROM  
			DWH.FactMarketAggregationSnapshot F  
		INNER JOIN  
			#Aggregations T  
		ON   
			F.MarketAggregationID = T.MarketAggregationID  
		AND  
			F.DateID = T.DateID  
  
  
	/* INSERT */  
  
	INSERT INTO  
			DWH.FactMarketAggregationSnapshot  
		(  
			DateID,   
			MarketAggregationID,   
			TurnoverEur,   
			Volume,   
			TurnoverEurConditional,   
			VolumeConditional,  
			BatchID  
		)  
		SELECT  
			DateID,   
			MarketAggregationID,   
			TurnoverEur,   
			Volume,   
			TurnoverEurConditional,   
			VolumeConditional,  
			@BatchID  
		FROM  
			#Aggregations T  
		WHERE  
			NOT EXISTS (  
				SELECT  
					*  
				FROM				  
					DWH.FactMarketAggregationSnapshot F  
				WHERE  
					F.MarketAggregationID = T.MarketAggregationID  
				AND  
					F.DateID = T.DateID  
				)  
				  
  
END  
  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimBatch]'
GO
CREATE TABLE [DWH].[DimBatch] 
( 
[BatchID] [int] NOT NULL IDENTITY(1, 1), 
[StartTime] [datetime] NOT NULL CONSTRAINT [DF_DimBatch_StartTime] DEFAULT (getdate()), 
[EndTime] [datetime] NULL, 
[ErrorFreeYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_DimBatch_ErrorFreeYN] DEFAULT ('Y'), 
[BatchType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ETLVersion] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimBatch] on [DWH].[DimBatch]'
GO
ALTER TABLE [DWH].[DimBatch] ADD CONSTRAINT [PK_DimBatch] PRIMARY KEY CLUSTERED  ([BatchID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[GetBatchid]'
GO
    
    
-- =============================================    
-- Author:		Ian Meade    
-- Create date: 19/1/2017    
-- Description:	Gets current batch     
--				WARNING --- SCALAR FUNCTIONS ARE NOT SUITABLE FOR LARGE NUMBERS OF ROWS - USE ONLY FOR SMALL RESULT SETS    
-- =============================================    
CREATE FUNCTION [DWH].[GetBatchid]    
(    
)    
RETURNS INT    
AS    
BEGIN    
	-- Declare the return variable here    
	DECLARE @BatchId INT = 0    
    
	SELECT    
		@BatchId = MAX(BatchID)     
	FROM    
		DWH.DimBatch		    
    
	-- Return the result of the function    
	RETURN @BatchId    
    
END    
    
    
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[GetBatchIsErrorFree]'
GO
   
    
    
-- =============================================    
-- Author:		Ian Meade    
-- Create date: 06/3/2017    
-- Description:	Gets error status of current batch     
--				WARNING --- SCALAR FUNCTIONS ARE NOT SUITABLE FOR LARGE NUMBERS OF ROWS - USE ONLY FOR SMALL RESULT SETS    
-- =============================================    
CREATE FUNCTION [DWH].[GetBatchIsErrorFree]    
(    
)    
RETURNS CHAR(1)    
AS    
BEGIN    
	-- Declare the return variable here    
	DECLARE @ErrorFreeYN CHAR(1)   
    
   
	SELECT   
		@ErrorFreeYN = ErrorFreeYN   
	FROM   
		DWH.DimBatch   
	WHERE   
		BatchID = DWH.GetBatchid()   
   
	-- Return the result of the function    
	RETURN @ErrorFreeYN    
    
END    
    
    
   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[OOP]'
GO
CREATE TABLE [ETL].[OOP] 
( 
[AggregateDate] [date] NOT NULL, 
[A_ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_OFFICIAL_OPENING_PRICE] [numeric] (19, 6) NOT NULL, 
[PriceVersions] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[OCP]'
GO
CREATE TABLE [ETL].[OCP] 
( 
[AggregateDate] [date] NOT NULL, 
[A_ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_OFFICIAL_CLOSING_PRICE] [numeric] (19, 6) NOT NULL, 
[A_TRADE_TIME_OCP] [datetime] NOT NULL, 
[A_TRADE_TIME_OCP_LOCAL] [datetime] NOT NULL, 
[PriceVersions] [int] NOT NULL, 
[TimeVersions] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EquityOfficalPrices]'
GO
 
 
  
  
     
CREATE VIEW [ETL].[EquityOfficalPrices] AS     
	/* OFFICAL CLOSING / OPENING PRICES */    
		SELECT    
			D.AggregateDate,    
			D.AggregateDateID,    
			OCP.A_ISIN AS ISIN,  
    
			/* OCP */    
			OCP = COALESCE( OCP.A_OFFICIAL_CLOSING_PRICE, LastOCP.OCP, NULL ),    
    
			/* NO LOCAL TIME CONVERSION */    
			OCP_DATEID = COALESCE( CAST(CONVERT(CHAR,OCP.A_TRADE_TIME_OCP_LOCAL,112) AS INT), LastOCP.OCPDateID, NULL ),    
			OCP_TIME = COALESCE( CONVERT(TIME,OCP.A_TRADE_TIME_OCP_LOCAL,112), LastOCP.OCPTime, NULL),    
			OCP_TIME_UTC = COALESCE( CONVERT(TIME,OCP.A_TRADE_TIME_OCP,112), LastOCP.UtcOCPTime, NULL),    
			OCP_TIME_ID = COALESCE( CAST(REPLACE(LEFT(CONVERT(CHAR,OCP.A_TRADE_TIME_OCP_LOCAL,114),5),':','') AS INT), LastOCP.OCPTimeID, NULL ),    
			OCP_DATETIME = COALESCE( A_TRADE_TIME_OCP_LOCAL, LastOCP.OCPDateTime ), 
			/* OOP */    
			OOP = COALESCE( OOP.A_OFFICIAL_OPENING_PRICE, LastOCP.OCP, NULL )    
    
		FROM    
				ETL.AggregationDateList D  
			LEFT OUTER JOIN    
			/* OCP FOR TODAYS */    
				ETL.OCP OCP    
			ON     
				D.AggregateDate = OCP.AggregateDate    
			OUTER APPLY    
			/* MOST RECENT OCP RECORDED IN SNAPSHOT */    
			(    
				SELECT    
					TOP 1    
					F.OCP,    
					F.DateID,    
					F.OCPDateID,    
					F.OCPTimeID,    
					F.OCPTime,    
					F.UtcOCPTime, 
					F.OCPDateTime 
				FROM    
						DWH.FactEquitySnapshot AS F    
					INNER JOIN    
						DWH.DimInstrument I   
					ON F.InstrumentID = I.InstrumentID    
				WHERE    
					D.AggregateDateID > F.DateID    
				AND    
					OCP.A_ISIN = I.ISIN    
				ORDER BY    
					F.DateID DESC    
			) AS LastOCP    
			LEFT OUTER JOIN    
				ETL.OOP OOP    
			ON     
				D.AggregateDate = OOP.AggregateDate    
			AND		  
				OCP.A_ISIN = OOP.A_ISIN    
    
   
   
   
  
  
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EquityTradeLastTradeDateScoped]'
GO
  
  
CREATE VIEW [ETL].[EquityTradeLastTradeDateScoped] AS     
	/* NO LOOCAL TIMES ETC.. */    
	/* NO DELAYED TRADE ACCOMODATED */    
		SELECT    
			LastTrade.AggregateDateID,     
			LastTrade.InstrumentGlobalID,    
			T.TradeDateID,    
			T.TradeTimeID,    
			T.TradeTimestamp,    
			T.UTCTradeTimeStamp,    
			MAX(T.TradePrice) AS TradePrice    
		FROM    
				DWH.FactEquityTrade T    
			INNER JOIN    
				DWH.DimInstrumentEquity Equity    
			ON T.InstrumentID = Equity.InstrumentID    
			INNER JOIN    
				ETL.AggregationDateList D  
			ON     
				T.TradeDateID = D.AggregateDateID    
			INNER JOIN    
				DWH.DimTradeModificationType MOD    
			ON T.TradeModificationTypeID = MOD.TradeModificationTypeID    
			AND MOD.TradeModificationTypeName <> 'CANCEL'    
			INNER JOIN    
			(    
				SELECT    
					D.AggregateDateID,     
					Equity.InstrumentGlobalID,     
					MAX(TradeTimestamp) AS TradeTimestamp,    
					COUNT(*) CNT,    
					MIN(TradeTimestamp) AS T1    
				FROM    
						DWH.FactEquityTrade T    
					INNER JOIN    
						DWH.DimInstrumentEquity Equity    
					ON T.InstrumentID = Equity.InstrumentID    
					INNER JOIN    
						ETL.AggregationDateList D  
					ON     
						T.TradeDateID = D.AggregateDateID    
					INNER JOIN    
						DWH.DimTradeModificationType MOD    
					ON T.TradeModificationTypeID = MOD.TradeModificationTypeID    
					AND MOD.TradeModificationTypeName <> 'CANCEL'    
				WHERE    
					T.DelayedTradeYN = 'N'    
				GROUP BY    
					D.AggregateDateID,     
					Equity.InstrumentGlobalID  
			) AS LastTrade    
			ON    
				T.TradeDateID = LastTrade.AggregateDateID    
			AND    
				Equity.InstrumentGlobalID = LastTrade.InstrumentGlobalID  
			AND    
				T.TradeTimestamp = LastTrade.TradeTimestamp    
		WHERE    
			T.DelayedTradeYN = 'N'    
		GROUP BY    
			LastTrade.AggregateDateID,     
			LastTrade.InstrumentGlobalID,    
			T.TradeDateID,    
			T.TradeTimeID,    
			T.TradeTimestamp,    
			T.UTCTradeTimeStamp    
    
    
    
    
   
   
   
  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EquityTradeLastTrade]'
GO
  
    
CREATE VIEW [ETL].[EquityTradeLastTrade] AS    
	/* LAST TRADE PRICE & DATE */    
		SELECT    
			D.AggregateDateID,     
			COALESCE( L1.InstrumentGlobalID, SNAP_KEY.InstrumentGlobalID ) AS InstrumentGlobalID,  
			COALESCE( L1.TradeDateID, V.LTPDateID) AS LTPDateID ,    
			COALESCE( L1.TradeTimeID, V.LTPTimeID) AS LTPTimeID,    
			COALESCE( L1.TradeTimestamp, V.LTPTime) AS LTPTime,    
			COALESCE( L1.UTCTradeTimeStamp, V.UtcLTPTime) AS UtcLTPTime,    
			COALESCE( L1.TradePrice, V.LTP ) AS LastPrice    
		FROM    
				ETL.AggregationDateList D  
			LEFT OUTER JOIN    
				ETL.EquityTradeLastTradeDateScoped L1    
			ON     
				D.AggregateDateID = L1.AggregateDateID    
			LEFT OUTER JOIN  
			/* MOST RECENT TRADE RECORDED IN SNAPSHOT */    
			(  
				SELECT  
					Equity.InstrumentGlobalID,  
					D.AggregateDateID,  
					MAX(F.DateID) AS DateID,  
					MAX(F.InstrumentID) AS InstrumentID  
				FROM  
						ETL.AggregationDateList D  
					INNER JOIN  
						DWH.FactEquitySnapshot F    
					ON D.AggregateDateID >= F.DateID  
					INNER JOIN  
						DWH.DimInstrumentEquity Equity  
					ON F.InstrumentID = Equity.InstrumentID    
				GROUP BY  
					D.AggregateDateID,  
					Equity.InstrumentGlobalID  
			) AS SNAP_KEY  
			ON D.AggregateDateID = SNAP_KEY.AggregateDateID  
			INNER JOIN  
				DWH.FactEquitySnapshot V  
			ON SNAP_KEY.DateID = V.DateID  
			AND SNAP_KEY.InstrumentID = V.InstrumentID  
  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EquityVolume]'
GO
 
  
  
  
  
CREATE VIEW [ETL].[EquityVolume] AS    
		SELECT    
			D.AggregateDateID,     
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
				ETL.AggregationDateList D  
			INNER JOIN    
				DWH.FactEquityTrade T    
			ON D.AggregateDateID = T.TradeDateID    
			AND T.TradeCancelled = 'N' 
			INNER JOIN  
				DWH.DimInstrumentEquity I  
			ON T.InstrumentID = I.InstrumentID  
			INNER JOIN    
				DWH.DimEquityTradeJunk JK    
			ON T.EquityTradeJunkID = JK.EquityTradeJunkID   
			/* 
			INNER JOIN    
				DWH.DimTradeModificationType MT    
			ON T.TradeModificationTypeID = MT.TradeModificationTypeID    
			AND MT.CancelTradeYN = 'N'  
			*/ 
			CROSS APPLY     
			(    
				SELECT    
					TOP 1    
					ExchangeRate    
				FROM    
					DWH.FactExchangeRate EX    
				WHERE    
					D.AggregateDateID >= EX.DateID     
				AND    
					T.CurrencyID = EX.CurrencyID    
				ORDER BY    
					EX.DateID DESC    
			) AS ExRate    
		WHERE   				 
				T.DelayedTradeYN = 'N'    
			OR    
				(    
						T.DelayedTradeYN = 'Y'    
					AND    
						T.PublishedDateTime < GETDATE()    
				)    
		GROUP BY    
			D.AggregateDateID,  
			I.InstrumentGlobalID  
  
  
  
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[StateStreet_ISEQ20_NAV]'
GO
CREATE TABLE [ETL].[StateStreet_ISEQ20_NAV] 
( 
[ValuationDateID] [int] NULL, 
[NAV_per_unit] [numeric] (19, 4) NULL, 
[Units_In_Issue] [numeric] (19, 2) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Report].[RefEquityFeeBand]'
GO
CREATE TABLE [Report].[RefEquityFeeBand] 
( 
[FeeBandID] [smallint] NOT NULL IDENTITY(1, 1), 
[FeeBandName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[Min] [int] NOT NULL, 
[Max] [int] NOT NULL, 
[Fee] [numeric] (9, 6) NOT NULL, 
[FeeType] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_RefEquityFeeBand] on [Report].[RefEquityFeeBand]'
GO
ALTER TABLE [Report].[RefEquityFeeBand] ADD CONSTRAINT [PK_RefEquityFeeBand] PRIMARY KEY CLUSTERED  ([FeeBandID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Report].[RawTcC810]'
GO
CREATE TABLE [Report].[RawTcC810] 
( 
[T7_ODS_FileListRawTcFileID] [int] NOT NULL, 
[RawTc810Id] [int] NOT NULL, 
[REPORT_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[REPORT_EFF_DATE] [date] NULL, 
[REPORT_PROCESS_DATE] [date] NULL, 
[ENV_ONE] [tinyint] NULL, 
[ENV_TWO] [tinyint] NULL, 
[CLRMEM_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[CLRMEM_SETTLE_LOC] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[CLRMEM_SETTLE_ACC] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[EXCHMEMB_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[OWNER_EXMEMB_INST_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[OWNER_EXMEMB_BR_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[INSTRU_ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[UNITS] [tinyint] NULL, 
[TRANS_TIME] [bigint] NULL, 
[PARTA_SUBGRP_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[PARTA_USR_NO] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[UNIQ_TRADE_NO] [int] NULL, 
[TRADE_NO_SUFX] [tinyint] NULL, 
[TRANS_TYPE] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[ORIGIN_TYPE] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[CROSS_IND] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[SETTLE_IND] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[OTC_TRADE_TIME] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[ORDER_INSTR_ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[ORD_NO] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[EXECUTOR_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[INTERMEM_ORD_NO] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[FREE] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[ACC_TYPE_CODE] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[ACC_TYPE_NO] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[BUY_SELL_IND] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[NETTING_TYPE] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[MATCHED_QTY] [decimal] (28, 10) NULL, 
[MATCHED_PRICE] [decimal] (28, 10) NULL, 
[SETTLE_AMOUNT] [decimal] (28, 10) NULL, 
[SETTLE_DATE] [date] NULL, 
[SETTLE_CODE] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[ACCRUED_INTEREST] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[ACCRUED_INTEREST_DAY] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[EXCHMEM_INST_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[EXCHMEM_BR_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[PART_USR_GRP_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[PART_USR_NO] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[COUNTER_EXCHMEM_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[COUNTER_EXCHMEM_BR_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[COUNTER_CRL_SET_MEM_ID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[COUNTER_SETL_LOC] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[COUNTER_SETL_ACC] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[COUNTER_KASSEN_NO] [int] NULL, 
[DEPOSITORY_TYPE] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[TRANS_FEE] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[TRANS_FEE_CURRENCY] [varchar] (30) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_RawTcC810] on [Report].[RawTcC810]'
GO
ALTER TABLE [Report].[RawTcC810] ADD CONSTRAINT [PK_RawTcC810] PRIMARY KEY CLUSTERED  ([T7_ODS_FileListRawTcFileID], [RawTc810Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[FactInstrumentStatusHistory]'
GO
CREATE TABLE [DWH].[FactInstrumentStatusHistory] 
( 
[InstrumentStatusHistoryID] [int] NOT NULL IDENTITY(1, 1), 
[InstrumentID] [int] NOT NULL, 
[InstrumemtStatusID] [smallint] NOT NULL, 
[OldInstrumentStatusID] [smallint] NOT NULL, 
[InstrumemtStatusDateID] [int] NOT NULL, 
[InstrumemtStatusTimeID] [smallint] NOT NULL, 
[InstrumemtStatusTime] [time] NOT NULL, 
[StatusCreatedDateID] [int] NOT NULL, 
[StatusCreatedTimeID] [smallint] NOT NULL, 
[StatusCreatedTime] [time] NOT NULL, 
[BatchID] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactInstrumentStatusHistory] on [DWH].[FactInstrumentStatusHistory]'
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] ADD CONSTRAINT [PK_FactInstrumentStatusHistory] PRIMARY KEY CLUSTERED  ([InstrumentStatusHistoryID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[FactEtfSnapshotMerge]'
GO
CREATE TABLE [ETL].[FactEtfSnapshotMerge] 
( 
[InstrumentID] [int] NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[CurrencyID] [smallint] NULL, 
[SourceTable] [varchar] (6) COLLATE Latin1_General_CI_AS NULL, 
[AggregationDate] [date] NULL, 
[AggregationDateID] [int] NULL, 
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[OCP] [numeric] (19, 6) NULL, 
[OCPDateID] [int] NULL, 
[OCPTime] [time] NULL, 
[OCPTimeID] [int] NULL, 
[OpenPrice] [numeric] (19, 6) NULL, 
[UtcOCPTime] [time] NULL, 
[LastPrice] [numeric] (19, 6) NULL, 
[LTPDateID] [int] NULL, 
[LTPTimeID] [smallint] NULL, 
[LTPTime] [time] NULL, 
[UtcLTPTime] [time] NULL, 
[LowPrice] [numeric] (19, 6) NULL, 
[HighPrice] [numeric] (19, 6) NULL, 
[Deals] [int] NULL, 
[DealsOB] [int] NULL, 
[DealsND] [int] NULL, 
[Volume] [int] NULL, 
[VolumeOB] [int] NULL, 
[VolumeND] [int] NULL, 
[Turnover] [numeric] (38, 6) NULL, 
[TurnoverOB] [numeric] (38, 6) NULL, 
[TurnoverND] [numeric] (38, 6) NULL, 
[TurnoverEur] [numeric] (38, 11) NULL, 
[TurnoverObEur] [numeric] (38, 19) NULL, 
[TurnoverNdEur] [numeric] (38, 19) NULL, 
[BidPrice] [numeric] (19, 6) NULL, 
[OfferPrice] [numeric] (19, 6) NULL, 
[ClosingAuctionBidPrice] [numeric] (19, 6) NULL, 
[ClosingAuctionOfferPrice] [numeric] (19, 6) NULL, 
[TotalSharesInIssue] [numeric] (28, 6) NULL, 
[ExchangeRate] [numeric] (19, 6) NULL, 
[MarketCap] [numeric] (38, 6) NULL, 
[MarketCapEur] [numeric] (38, 6) NULL, 
[BatchID] [int] NULL, 
[MarketID] [smallint] NULL, 
[ISEQ20Freefloat] [numeric] (19, 6) NULL, 
[ISEQ20IndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[ISEQOverallFreeFloat] [numeric] (19, 6) NULL, 
[OverallIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[GeneralIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[FinancialIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[SmallCapIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[ITEQIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[ESMIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentStatusID] [smallint] NULL, 
[LastEXDivDate] [date] NULL, 
[LtpDateTime] [datetime2] NULL, 
[OcpDateTime] [datetime] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[FactEquitySnapshotMerge]'
GO
CREATE TABLE [ETL].[FactEquitySnapshotMerge] 
( 
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentID] [int] NOT NULL, 
[InstrumentStatusID] [smallint] NULL, 
[DateID] [int] NOT NULL, 
[LastExDivDateID] [int] NULL, 
[OCPDateID] [int] NULL, 
[OCPTimeID] [smallint] NULL, 
[OCPTime] [time] NULL, 
[UtcOCPTime] [time] NULL, 
[LTPDateID] [int] NULL, 
[LTPTimeID] [smallint] NULL, 
[LTPTime] [time] NULL, 
[UtcLTPTime] [time] NULL, 
[MarketID] [smallint] NULL, 
[TotalSharesInIssue] [numeric] (28, 6) NULL, 
[IssuedSharesToday] [numeric] (28, 6) NULL, 
[ExDivYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[OpenPrice] [numeric] (19, 6) NULL, 
[LowPrice] [numeric] (19, 6) NULL, 
[HighPrice] [numeric] (19, 6) NULL, 
[BidPrice] [numeric] (19, 6) NULL, 
[OfferPrice] [numeric] (19, 6) NULL, 
[ClosingAuctionBidPrice] [numeric] (19, 6) NULL, 
[ClosingAuctionOfferPrice] [numeric] (19, 6) NULL, 
[OCP] [numeric] (19, 6) NULL, 
[LTP] [numeric] (19, 6) NULL, 
[MarketCap] [numeric] (28, 6) NULL, 
[MarketCapEur] [numeric] (28, 6) NULL, 
[Turnover] [numeric] (19, 6) NULL, 
[TurnoverND] [numeric] (19, 6) NULL, 
[TurnoverEur] [numeric] (19, 6) NULL, 
[TurnoverNDEur] [numeric] (19, 6) NULL, 
[TurnoverOB] [numeric] (19, 6) NULL, 
[TurnoverOBEur] [numeric] (19, 6) NULL, 
[Volume] [bigint] NULL, 
[VolumeND] [bigint] NULL, 
[VolumeOB] [bigint] NULL, 
[Deals] [int] NULL, 
[DealsOB] [int] NULL, 
[DealsND] [int] NULL, 
[ISEQ20Shares] [numeric] (28, 6) NULL, 
[ISEQ20Price] [numeric] (19, 6) NULL, 
[ISEQ20Weighting] [numeric] (9, 6) NULL, 
[ISEQ20MarketCap] [numeric] (28, 6) NULL, 
[ISEQ20FreeFloat] [numeric] (19, 6) NULL, 
[ISEQOverallWeighting] [numeric] (9, 6) NULL, 
[ISEQOverallMarketCap] [numeric] (28, 6) NULL, 
[ISEQOverallBeta30] [numeric] (19, 6) NULL, 
[ISEQOverallBeta250] [numeric] (19, 6) NULL, 
[ISEQOverallFreefloat] [numeric] (19, 6) NULL, 
[ISEQOverallPrice] [numeric] (19, 6) NULL, 
[ISEQOverallShares] [numeric] (28, 6) NULL, 
[OverallIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[GeneralIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[FinancialIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[SmallCapIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ITEQIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ISEQ20IndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ESMIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExCapYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExEntitlementYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExRightsYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExSpecialYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[LseTurnover] [int] NULL, 
[LseVolume] [numeric] (19, 6) NULL, 
[ETFFMShares] [int] NULL, 
[BatchID] [int] NULL, 
[LtpDateTime] [datetime2] NULL, 
[OcpDateTime] [datetime] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimTrader]'
GO
CREATE TABLE [DWH].[DimTrader] 
( 
[TraderID] [smallint] NOT NULL IDENTITY(1, 1), 
[TraderCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[BrokerCode] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL, 
[TraderType] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[Infered] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_DimTrader_Infered] DEFAULT ('N') 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimTrader] on [DWH].[DimTrader]'
GO
ALTER TABLE [DWH].[DimTrader] ADD CONSTRAINT [PK_DimTrader] PRIMARY KEY CLUSTERED  ([TraderID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimTime]'
GO
CREATE TABLE [DWH].[DimTime] 
( 
[TimeID] [smallint] NOT NULL, 
[Time] [time] (2) NOT NULL, 
[TimeHourText] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL, 
[TimeMinuteText] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimTime] on [DWH].[DimTime]'
GO
ALTER TABLE [DWH].[DimTime] ADD CONSTRAINT [PK_DimTime] PRIMARY KEY CLUSTERED  ([TimeID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimIndexType]'
GO
CREATE TABLE [DWH].[DimIndexType] 
( 
[IndexTypeID] [smallint] NOT NULL IDENTITY(1, 1), 
[IndexCode] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[IndexName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[ISIN] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL, 
[SEDOL] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[ReturnISIN] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL, 
[ReturnSEDOL] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimIndex] on [DWH].[DimIndexType]'
GO
ALTER TABLE [DWH].[DimIndexType] ADD CONSTRAINT [PK_DimIndex] PRIMARY KEY CLUSTERED  ([IndexTypeID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimDate]'
GO
CREATE TABLE [DWH].[DimDate] 
( 
[DateID] [int] NOT NULL, 
[DateText] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[Day] [date] NOT NULL, 
[WorkingDayYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[CurrentDateYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[Year] [smallint] NOT NULL, 
[MonthNo] [smallint] NOT NULL, 
[MonthName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[QuarterNo] [smallint] NOT NULL, 
[QuarterText] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[YearQuarterNo] [int] NOT NULL, 
[YearQuarterText] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[MonthDayNo] [smallint] NOT NULL, 
[DayText] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[MonthToDateYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[YearToDateYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradingStartTime] [time] NOT NULL, 
[TradingEndTime] [time] NOT NULL, 
[YearWeekNo] [int] NULL, 
[YearMonthNo] [int] NULL, 
[YearMonthText] [varchar] (8) COLLATE Latin1_General_CI_AS NULL, 
[YearStart] [int] NULL, 
[YearEnd] [int] NULL, 
[LastYearEnd] [int] NULL, 
[QuarterStart] [int] NULL, 
[QuarterEnd] [int] NULL, 
[LastQuarterEnd] [int] NULL, 
[MonthStart] [int] NULL, 
[MonthEnd] [int] NULL, 
[LastMonthEnd] [int] NULL, 
[WeekStart] [int] NULL, 
[WeekEnd] [int] NULL, 
[DaysYTD] [smallint] NULL, 
[DaysMTD] [smallint] NULL, 
[DaysQTD] [smallint] NULL, 
[PreviousDateID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimDate] on [DWH].[DimDate]'
GO
ALTER TABLE [DWH].[DimDate] ADD CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED  ([DateID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimCurrency]'
GO
CREATE TABLE [DWH].[DimCurrency] 
( 
[CurrencyID] [smallint] NOT NULL IDENTITY(1, 1), 
[CurrencySymbol] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[CurrencyISOCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[CurrencyName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[CurrencyCountry] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimCurrency] on [DWH].[DimCurrency]'
GO
ALTER TABLE [DWH].[DimCurrency] ADD CONSTRAINT [PK_DimCurrency] PRIMARY KEY CLUSTERED  ([CurrencyID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimBroker]'
GO
CREATE TABLE [DWH].[DimBroker] 
( 
[BrokerID] [smallint] NOT NULL IDENTITY(1, 1), 
[BrokerCode] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL, 
[BrokerName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[BondTurnoverYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[StatusValidYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketMakerYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[CrestCode] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[MemberPackYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[DailyOfficialListYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[EBCFee] [numeric] (19, 6) NOT NULL, 
[Location] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[MemberType] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[Telephone] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[Fax] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[Address] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[Website] [varchar] (255) COLLATE Latin1_General_CI_AS NOT NULL, 
[StartDate] [datetime2] NOT NULL, 
[EndDate] [datetime2] NULL, 
[CurrentRowYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[BatchID] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimBroker] on [DWH].[DimBroker]'
GO
ALTER TABLE [DWH].[DimBroker] ADD CONSTRAINT [PK_DimBroker] PRIMARY KEY CLUSTERED  ([BrokerID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[ClosingPrice]'
GO
CREATE TABLE [ETL].[ClosingPrice] 
( 
[AggregateDate] [date] NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[CLOSING_AUCT_BID_PRICE] [numeric] (19, 6) NULL, 
[CLOSING_AUCT_ASK_PRICE] [numeric] (19, 6) NULL, 
[BidPriceVersions] [int] NULL, 
[OfferPriceVersions] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[BidOfferPrice]'
GO
CREATE TABLE [ETL].[BidOfferPrice] 
( 
[AggregateDate] [date] NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[PRICE_TIMESTAMP_NO] [int] NULL, 
[BEST_BID_PRICE] [numeric] (19, 6) NULL, 
[BEST_ASK_PRICE] [numeric] (19, 6) NULL, 
[BidPriceVersions] [int] NULL, 
[OfferPriceVersions] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[ClearAllTables]'
GO
-- =============================================    
-- Author:		Ian Meade    
-- Create date: 24/1/2017    
-- Description:	Clear the DWH and reset IDs    
-- =============================================    
CREATE PROCEDURE [DWH].[ClearAllTables]    
AS    
BEGIN    
	SET NOCOUNT ON;    
    
	DELETE ProcessControl.dbo.ProcessMessage 
 
	/* TRUNCATE TABLES */    
	TRUNCATE TABLE DWH.FactEquitySnapshot    
	TRUNCATE TABLE DWH.FactEquityTrade    
	TRUNCATE TABLE DWH.FactEtfSnapshot    
	TRUNCATE TABLE DWH.FactEtfTrade    
	TRUNCATE TABLE DWH.FactExchangeRate    
	TRUNCATE TABLE DWH.FactInstrumentStatusHistory    
	TRUNCATE TABLE DWH.FactMarketAggregationSnapshot  
	TRUNCATE TABLE DWH.FactEquityIndex  
	TRUNCATE TABLE DWH.FactEquityIndexSnapshot  
	TRUNCATE TABLE DWH.FactEquityPriceSnapshot  
  
	/* EMPTY TABLES REFERENCED BY FOREIGN KEYS */    
	DELETE DWH.DimInstrumentEquity    
	DELETE DWH.DimInstrumentEtf   
	DELETE DWH.DimInstrument   
	DELETE DWH.DimIndexType  
	DELETE DWH.DimMarket    
	DELETE DWH.DimMarketAggregation  
	DELETE DWH.DimBatch    
	DELETE DWH.DimBroker    
	DELETE DWH.DimCurrency    
	DELETE DWH.DimDate    
	DELETE DWH.DimEquityTradeJunk    
	DELETE DWH.DimFile    
	DELETE DWH.DimStatus    
	DELETE DWH.DimTime    
	DELETE DWH.DimTradeModificationType    
	DELETE DWH.DimTrader    
    
	/* RESET IDENTITIES FOR DELETED TABLES */    
	DBCC CHECKIDENT ('DWH.DimIndexType',RESEED,0);      
	DBCC CHECKIDENT ('DWH.DimMarket',RESEED,0);     
	DBCC CHECKIDENT ('DWH.DimBatch',RESEED,0);      
	DBCC CHECKIDENT ('DWH.DimBroker',RESEED,0);      
	DBCC CHECKIDENT ('DWH.DimCurrency',RESEED,0);      
	DBCC CHECKIDENT ('DWH.DimEquityTradeJunk',RESEED,0);     
	DBCC CHECKIDENT ('DWH.DimFile',RESEED,0);      
    
	DBCC CHECKIDENT ('DWH.DimFile',RESEED,0);      
	DBCC CHECKIDENT ('DWH.DimInstrument',RESEED,0);    
	DBCC CHECKIDENT ('DWH.DimStatus',RESEED,0);      
	DBCC CHECKIDENT ('DWH.DimTradeModificationType',RESEED,0);      
	DBCC CHECKIDENT ('DWH.DimTrader',RESEED,0);      
	DBCC CHECKIDENT ('DWH.DimMarketAggregation',RESEED,0);      
    
    
	/* SPECIAL DUMMY ENTRIES */    
	SET IDENTITY_INSERT DWH.DimBatch ON    
    
	/* GENERIC NOT A BATCH - EG A NORMAL TRADE HAS A -1 FOR THE CANCELED BATCH - A CANCELED TRADE HAS A REAL BATCH */    
	INSERT INTO    
			DWH.DimBatch     
		(    
			BatchID,     
			StartTime,     
			EndTime,     
			ErrorFreeYN,     
			ETLVersion    
		)    
		VALUES    
		(    
			-1,    
			'19991231',    
			'20000101',    
			'Y',    
			'NA'    
		)    
    
	/* SPECIAL BATCH FOR DSS MIGRATION */    
	INSERT INTO    
			DWH.DimBatch     
		(    
			BatchID,     
			StartTime,     
			EndTime,     
			ErrorFreeYN,     
			ETLVersion    
		)    
		VALUES    
		(    
			-2,    
			'19991231',    
			'20000101',    
			'Y',    
			'DSS Migration - T7'    
		)    
    
	SET IDENTITY_INSERT DWH.DimBatch OFF    
    
 
	/* PUSHING THROUGH THE STORED PROCEDURE */ 
 
	/* NOT A DATE - EG NO PUBLICATION DATE */    
	/* 
	INSERT INTO    
			DWH.DimDate     
		(    
			DateID,     
			DateText,     
			Day,     
			WorkingDayYN,     
			Year,     
			MonthNo,     
			MonthName,     
			QuarterNo,     
			QuarterText,     
			YearQuarterNo,     
			YearQuarterText,     
			MonthDayNo,     
			DayText,     
			MonthToDateYN,     
			YearToDateYN,     
			TradingStartTime,     
			TradingEndTime    
		)    
		VALUES    
		(    
			-1,    
			'NA',    
			'0001010119991231',    
			'N',    
			1,    
			0,    
			'NA',    
			0,    
			'NA',    
			0,    
			'NA',    
			0,    
			'NA',    
			'N',    
			'N',    
			'00:00',    
			'00:00'    
		)    
   */ 
   
	/* EXTRA TABLES - THESE ARE NOT PART OF THE DWH MODEL */    
	TRUNCATE TABLE ETL.EquityTradeDate  
	TRUNCATE TABLE ETL.OOP  
	TRUNCATE TABLE ETL.FactEtfSnapshotMerge  
	TRUNCATE TABLE ETL.OCP  
	TRUNCATE TABLE ETL.ClosingPrice  
	TRUNCATE TABLE ETL.BidOfferPrice  
	TRUNCATE TABLE ETL.AggregationDateList  
	TRUNCATE TABLE ETL.FactEquitySnapshotMerge  
	TRUNCATE TABLE ETL.FactEquityIndexPrep  
	TRUNCATE TABLE ETL.FactEquityIndexSnapshotMerge  
	TRUNCATE TABLE ETL.StateStreet_ISEQ20_NAV  
  
	TRUNCATE TABLE Report.RefEquityFeeBand    
	TRUNCATE TABLE Report.RawTcC810  
   
END    
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[udfGetAggregationInstruments]'
GO
  
  
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 8/5/2017  
-- Description:	Get a list of Equity/ETf instrument to aggregate for pased in date  
-- =============================================  
CREATE FUNCTION [ETL].[udfGetAggregationInstruments]  
(	  
	@DateID AS INT  
)  
RETURNS TABLE   
AS  
RETURN   
(  
	SELECT  
		I.StartDate,  
		I.EndDate,  
		D.Day AS AggregationDate,  
		@DateID AS AggregationDateID,  
		I.InstrumentID,  
		I.ISIN,  
		I.InstrumentGlobalID,  
		I.InstrumentType,  
		COALESCE(EQ.CurrencyID, ETF.CurrencyID) AS CurrencyID,  
		IIF(EQ.InstrumentID IS NOT NULL, 'EQUITY','ETF') AS SourceTable  
	FROM  
			DWH.DimInstrument I  
		INNER JOIN  
			DWH.DimStatus S  
		ON I.InstrumentStatusID = S.StatusID  
		LEFT OUTER JOIN  
			DWH.DimInstrumentEquity EQ  
		ON I.InstrumentID = EQ.InstrumentID  
		LEFT OUTER JOIN  
			DWH.DimInstrumentEtf ETF  
		ON I.InstrumentID = ETF.InstrumentID  
		INNER JOIN  
			DWH.DimDate D  
		ON D.DateID = @DateID  
	WHERE  
			I.InstrumentID IN (  
					/* Most recent instrument on choosen date */  
					SELECT  
						MAX(InstrumentID) AS InstrumentID  
					FROM  
						DWH.DimInstrument  
					WHERE  
						InstrumentType IN ( 'EQUITY', 'ETF' )	  
					AND  
						D.Day BETWEEN CAST(StartDate AS DATE) AND ISNULL(EndDate, '2099/01/01' )  
					GROUP BY  
						InstrumentGlobalID  
				)  
		AND  
			S.StatusName IN ( 'Listed', 'Suspended', 'ConditionalDealings' )  
  
  
)  
  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[EndBatch]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 16/1/2017   
-- Description:	End an ETL batch   
-- =============================================   
CREATE PROCEDURE [DWH].[EndBatch]   
	@BatchID INT  
AS   
BEGIN   
	-- SET NOCOUNT ON added to prevent extra result sets from   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
	/* Close the specified batch */   
	/* Do not change the error status */   
	UPDATE   
		DWH.DimBatch   
	SET   
		EndTime = GETDATE()   
	WHERE   
		BatchID = @BatchID  
   
END   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[ErrorBatch]'
GO
-- =============================================    
-- Author:		Ian Meade    
-- Create date: 06/3/2017    
-- Description:	Mark a batch as an error batch   
-- =============================================    
CREATE PROCEDURE [DWH].[ErrorBatch]    
AS    
BEGIN    
	-- SET NOCOUNT ON added to prevent extra result sets from    
	-- interfering with SELECT statements.    
	SET NOCOUNT ON;    
    
	/* Close the current batch / highest number */    
	/* Do not chnage the error status */    
	UPDATE    
		DWH.DimBatch    
	SET    
		ErrorFreeYN = 'N'   
	WHERE    
		BatchID = (    
				SELECT     
					MAX(BatchID)     
				FROM     
					DWH.DimBatch    
			)    
    
    
    
END    
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[StartBatch]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 16/1/2017   
-- Description:	Start an ETL batch   
-- =============================================   
CREATE PROCEDURE [DWH].[StartBatch]   
	@BatchType VARCHAR(50),  
	@EtlVersion varchar(20)   
AS   
BEGIN   
	-- SET NOCOUNT ON added to prevent extra result sets from   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
	/* Close any existing batch */   
	UPDATE   
		DWH.DimBatch   
	SET   
		EndTime = GETDATE(),   
		ErrorFreeYN = 'N'   
	WHERE   
			BatchType = @BatchType   
		AND  
			EndTime IS NULL   
   
	/* Create a new batch */   
	INSERT INTO	   
			DWH.DimBatch   
		(   
			BatchType,  
			ETLVersion   
		)   
		OUTPUT   
			inserted.BatchID   
		VALUES   
		(   
			@BatchType,  
			@EtlVersion   
		)   
   
END   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[UpdateDimFile]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 20/1/2017   
-- Description:	Update DimFile    
-- =============================================   
CREATE PROCEDURE [DWH].[UpdateDimFile]   
	@FileName VARCHAR(50),    
	@FileTypeTag VARCHAR(50),    
	@SaftFileLetter CHAR(1),    
	@FileProcessedStatus VARCHAR(50)   
AS   
BEGIN   
	SET NOCOUNT ON;   
   
	DECLARE @File TABLE (   
				FileName VARCHAR(50),    
				FileTypeTag VARCHAR(50),    
				SaftFileLetter CHAR(1),    
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
PRINT N'Creating [ETL].[UpdateFactEquitySnapshot]'
GO
    
CREATE PROCEDURE [ETL].[UpdateFactEquitySnapshot] AS     
/* UPDATE SNAPSHOT WITH LATEST TS SET OF CHANGES */  
/* DEFINED TO BE ONE DATE IN MERGE TABLE EACH TIME PRODCURE IS CALLED */  
  
BEGIN    
	SET NOCOUNT ON   
 
	/* MAKE NULLABLE FIELD 0 */ 
	UPDATE 
		ETL.FactEquitySnapshotMerge  
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
		/* Only update soem fields */    
    
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
			--MarketCap = E.MarketCap,    
			--MarketCapEur = E.MarketCapEur,    
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
			ISEQ20Price,    
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
    
    
END    
  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[UpdateFactEtfSnapshot]'
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
							I2.ISIN = @WISDOM_ISIN  
						AND  
							DWH2.ETFSharesInIssue IS NOT NULL  
						AND  
							DWH.DateID > DWH2.DateID  
					ORDER BY  
						DWH.DateID DESC  
				) AS PREV  
	WHERE  
		I.ISIN = @WISDOM_ISIN  
			  
  
END   
  
  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[ValidatePriceFileBidOffer]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 14/3/2017   
-- Description:	Validates T7 price details   
-- =============================================   
CREATE PROCEDURE [ETL].[ValidatePriceFileBidOffer]    
AS   
BEGIN   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
	SELECT   
		77 AS Code,   
		'ISIN in Price file not found in Instrument Dimension [' + ISIN + ']' AS Message   
	FROM   
		(   
			SELECT   
				ISIN   
			FROM   
				[ETL].[BidOfferPrice]   
			UNION   
			SELECT   
				ISIN   
			FROM   
				[ETL].[ClosingPrice]   
			UNION   
			SELECT   
				A_ISIN   
			FROM   
				[ETL].[OCP]   
			UNION   
			SELECT   
				A_ISIN   
			FROM   
				[ETL].[OOP]   
		) Price   
	WHERE   
		ISIN NOT IN (   
				SELECT   
					ISIN   
				FROM   
					DWH.DimInstrumentEquity   
				WHERE   
					CurrentRowYN = 'Y'   
				UNION   
				SELECT   
					ISIN   
				FROM   
					DWH.DimInstrumentEtf   
				WHERE   
					CurrentRowYN = 'Y'				   
			)   
   
END   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[bestCompanyDetails]'
GO
CREATE VIEW [ETL].[bestCompanyDetails] AS   
	/* Gets the most recenty copy of company detials in the DHW   
		Used if the XT data set has no current comnpany    
	*/   
WITH   
	Company AS (   
		/* UNION COMPANY FIELDS FROM BOTH DATA SETS */   
		SELECT   
			*   
		FROM   
			DWH.DimInstrumentEquity   
		UNION ALL   
		SELECT   
			*   
		FROM   
			DWH.DimInstrumentEtf   
	),   
	MostRecentCompany AS (   
		SELECT   
			CompanyGlobalID,   
			MAX(StartDate) AS StartDate,   
			MAX(InstrumentID) AS InstrumentID   
		FROM   
			[DWH].[DimInstrumentEquity]   
		GROUP BY   
			CompanyGlobalID   
	)   
	SELECT		   
		*   
	FROM   
		Company C   
	WHERE   
		EXISTS (   
				SELECT	   
					*   
				FROM   
					MostRecentCompany MRC   
				WHERE   
					C.InstrumentID = MRC.InstrumentID   
			)   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EquityMarketCap]'
GO
  
  
   
CREATE VIEW [ETL].[EquityMarketCap] AS    
		SELECT    
			D.AggregateDateID,     
			E.InstrumentID,     
			E.TotalSharesInIssue,   
			ExRate.ExchangeRate    
		FROM  
				DWH.DimInstrumentEquity E   
			CROSS JOIN			    
				ETL.AggregationDateList D  
			CROSS APPLY     
			(    
				SELECT    
					TOP 1    
					ExchangeRate    
				FROM    
					DWH.FactExchangeRate EX    
				WHERE    
					D.AggregateDateID >= EX.DateID     
				AND    
					E.CurrencyID = EX.CurrencyID    
				ORDER BY    
					EX.DateID DESC    
			) AS ExRate    
    
    
   
  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EquityTradeHighLow]'
GO
 
  
  
   
   
   
CREATE VIEW [ETL].[EquityTradeHighLow] AS   
		SELECT   
			I.ISIN,   
			T.TradeDateID,   
			COUNT(*) CNT,   
			MIN(T.TradePrice) AS LowPrice,   
			MAX(T.TradePrice) AS HighPrice   
		FROM   
				ETL.AggregationDateList D  
			LEFT OUTER JOIN    
				DWH.FactEquityTrade T   
			ON D.AggregateDateID = T.TradeDateID  
			INNER JOIN   
				DWH.DimInstrumentEquity I   
			ON T.InstrumentID = I.InstrumentID   
		WHERE   
			T.TradeCancelled = 'N' 
		GROUP BY   
			I.ISIN,   
			T.TradeDateID   
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EtfMarketCap]'
GO
  
   
CREATE VIEW [ETL].[EtfMarketCap] AS    
		SELECT    
			D.AggregateDateID,     
			E.InstrumentID,     
			E.TotalSharesInIssue,   
			ExRate.ExchangeRate    
		FROM  
				DWH.DimInstrumentEtf E   
			CROSS JOIN			    
				ETL.AggregationDateList D  
			CROSS APPLY     
			(    
				SELECT    
					TOP 1    
					ExchangeRate    
				FROM    
					DWH.FactExchangeRate EX    
				WHERE    
					D.AggregateDateID >= EX.DateID     
				AND    
					E.CurrencyID = EX.CurrencyID    
				ORDER BY    
					EX.DateID DESC    
			) AS ExRate    
    
    
   
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EtfOfficalPrices]'
GO
 
 
  
     
CREATE VIEW [ETL].[EtfOfficalPrices] AS     
	/* OFFICAL CLOSING / OPENING PRICES */    
		SELECT    
			D.AggregateDate,    
			D.AggregateDateID,    
			OCP.A_ISIN AS ISIN,  
    
			/* OCP */    
			OCP = COALESCE( OCP.A_OFFICIAL_CLOSING_PRICE, LastOCP.OCP, NULL ),    
    
			/* NO LOCAL TIME CONVERSION */    
			OCP_DATEID = COALESCE( CAST(CONVERT(CHAR,OCP.A_TRADE_TIME_OCP_LOCAL,112) AS INT), LastOCP.OCPDateID, NULL ),    
			OCP_TIME = COALESCE( CONVERT(TIME,OCP.A_TRADE_TIME_OCP_LOCAL,112), LastOCP.OCPTime, NULL),    
			OCP_TIME_UTC = COALESCE( CONVERT(TIME,OCP.A_TRADE_TIME_OCP,112), LastOCP.UtcOCPTime, NULL),    
			OCP_TIME_ID = COALESCE( CAST(REPLACE(LEFT(CONVERT(CHAR,OCP.A_TRADE_TIME_OCP_LOCAL,114),5),':','') AS INT), LastOCP.OCPTimeID, NULL ),    
			OCP_DATETIME = COALESCE( A_TRADE_TIME_OCP_LOCAL, LastOCP.OCPDateTime ), 
    
			/* OOP */    
			OOP = COALESCE( OOP.A_OFFICIAL_OPENING_PRICE, LastOCP.OCP, NULL )    
    
		FROM    
				ETL.AggregationDateList D  
			LEFT OUTER JOIN    
			/* OCP FOR TODAYS */    
				ETL.OCP OCP    
			ON     
				D.AggregateDate = OCP.AggregateDate    
			OUTER APPLY    
			/* MOST RECENT OCP RECORDED IN SNAPSHOT */    
			(    
				SELECT    
					TOP 1    
					F.OCP,    
					F.DateID,    
					F.OCPDateID,    
					F.OCPTimeID,    
					F.OCPTime,    
					F.UtcOCPTime, 
					F.OCPDateTime  
				FROM    
						DWH.FactEtfSnapshot AS F    
					INNER JOIN    
						DWH.DimInstrument I   
					ON F.InstrumentID = I.InstrumentID    
				WHERE    
					D.AggregateDateID > F.DateID    
				AND    
					OCP.A_ISIN = I.ISIN    
				ORDER BY    
					F.DateID DESC    
			) AS LastOCP    
			LEFT OUTER JOIN    
				ETL.OOP OOP    
			ON     
				D.AggregateDate = OOP.AggregateDate    
			AND		  
				OCP.A_ISIN = OOP.A_ISIN    
    
   
   
   
  
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EtfTradeHighLow]'
GO
 
  
  
  
   
CREATE VIEW [ETL].[EtfTradeHighLow] AS    
		SELECT    
			I.InstrumentGlobalID,    
			T.TradeDateID,    
			COUNT(*) CNT,    
			MIN(T.TradePrice) AS LowPrice,    
			MAX(T.TradePrice) AS HighPrice    
		FROM    
				ETL.AggregationDateList D  
			LEFT OUTER JOIN    
				DWH.FactEtfTrade T    
			ON D.AggregateDateID = T.TradeDateID  
			INNER JOIN    
				DWH.DimInstrumentEtf I    
			ON T.InstrumentID = I.InstrumentID    
			INNER JOIN    
				DWH.DimTradeModificationType TM    
			ON T.TradeModificationTypeID = TM.TradeModificationTypeID    
		WHERE    
			T.TradeCancelled = 'N' 
		GROUP BY    
			I.InstrumentGlobalID,    
			T.TradeDateID    
    
    
   
  
  
  
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimCorporateActionType]'
GO
CREATE TABLE [DWH].[DimCorporateActionType] 
( 
[CorporateActionTypeID] [smallint] NOT NULL IDENTITY(1, 1), 
[CorporateActionCode] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[CoporateActionName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[CorporateActionSubType] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[CorporateActionStatusCode] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[CorporateActionStatusName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimCorporateActionType] on [DWH].[DimCorporateActionType]'
GO
ALTER TABLE [DWH].[DimCorporateActionType] ADD CONSTRAINT [PK_DimCorporateActionType] PRIMARY KEY CLUSTERED  ([CorporateActionTypeID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[FactCorporateAction]'
GO
CREATE TABLE [DWH].[FactCorporateAction] 
( 
[CorporateActionId] [smallint] NOT NULL IDENTITY(1, 1), 
[CoporateActionGID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[CorporateActionTypeID] [smallint] NULL, 
[InstrumentID] [int] NULL, 
[EffectiveDateID] [int] NULL, 
[RecordDateID] [int] NULL, 
[ExDateID] [int] NULL, 
[LatestDateForApplicationNilPaidID] [int] NULL, 
[LatestDateForFinalApplicationID] [int] NULL, 
[LatestSplittingDateNote] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CorporateActionStatusDateID] [int] NULL, 
[Conditional] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[Unconditional] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ReverseTakeover] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[CurrentNumberOfSharesInIssue] [decimal] (23, 10) NULL, 
[NumberOfNewShares] [decimal] (23, 10) NULL, 
[ExPrice] [decimal] (23, 10) NULL, 
[Price] [decimal] (23, 10) NULL, 
[SharePrice] [decimal] (23, 10) NULL, 
[Details] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL, 
[AdditionalDescription] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL, 
[Note] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL, 
[BatchID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactCorporateAction] on [DWH].[FactCorporateAction]'
GO
ALTER TABLE [DWH].[FactCorporateAction] ADD CONSTRAINT [PK_FactCorporateAction] PRIMARY KEY CLUSTERED  ([CorporateActionId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[FactDividend]'
GO
CREATE TABLE [DWH].[FactDividend] 
( 
[DividendID] [smallint] NOT NULL IDENTITY(1, 1), 
[CoporateActionGID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[CorporateActionTypeID] [smallint] NULL, 
[InstrumentID] [int] NULL, 
[NextMeetingDateID] [int] NULL, 
[ExDateID] [int] NULL, 
[PaymentDateID] [int] NULL, 
[RecordDateID] [int] NULL, 
[CurrencyID] [smallint] NULL, 
[Coupon] [decimal] (23, 10) NULL, 
[DividendPerShare] [decimal] (23, 10) NULL, 
[DividendRatePercent] [decimal] (23, 10) NULL, 
[FXRate] [decimal] (23, 10) NULL, 
[GrossDivEuro] [decimal] (23, 10) NULL, 
[GrossDividend] [decimal] (23, 10) NULL, 
[TaxAmount] [decimal] (23, 10) NULL, 
[TaxDescription] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[TaxRatePercent] [decimal] (23, 10) NULL, 
[AdditionalDescription] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL, 
[Note] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL, 
[BatchID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactDividend] on [DWH].[FactDividend]'
GO
ALTER TABLE [DWH].[FactDividend] ADD CONSTRAINT [PK_FactDividend] PRIMARY KEY CLUSTERED  ([DividendID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SecurityTest]'
GO
   
CREATE PROCEDURE [dbo].[SecurityTest]   
AS   
BEGIN   
	-- SET NOCOUNT ON added to prevent extra result sets from   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
	SELECT 1   
END   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [DWH].[FactInstrumentStatusHistory]'
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK  ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimBatch] FOREIGN KEY ([BatchID]) REFERENCES [DWH].[DimBatch] ([BatchID]) 
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK  ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimDate] FOREIGN KEY ([InstrumemtStatusDateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK  ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimDate1] FOREIGN KEY ([StatusCreatedDateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK  ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimInstrument] FOREIGN KEY ([InstrumentID]) REFERENCES [DWH].[DimInstrument] ([InstrumentID]) 
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK  ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimStatus] FOREIGN KEY ([InstrumemtStatusID]) REFERENCES [DWH].[DimStatus] ([StatusID]) 
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK  ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimTime] FOREIGN KEY ([InstrumemtStatusTimeID]) REFERENCES [DWH].[DimTime] ([TimeID]) 
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK  ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimTime1] FOREIGN KEY ([StatusCreatedTimeID]) REFERENCES [DWH].[DimTime] ([TimeID]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [DWH].[FactEquitySnapshot]'
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [FK_FactEquitySnapshot_DimBatch] FOREIGN KEY ([BatchID]) REFERENCES [DWH].[DimBatch] ([BatchID]) 
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [FK_FactEquitySnapshot_DimDate] FOREIGN KEY ([DateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [FK_FactEquitySnapshot_DimDate1] FOREIGN KEY ([LastExDivDateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [FK_FactEquitySnapshot_DimDate2] FOREIGN KEY ([OCPDateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [FK_FactEquitySnapshot_DimDate3] FOREIGN KEY ([LTPDateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [FK_FactEquitySnapshot_DimInstrumentEquity] FOREIGN KEY ([InstrumentID]) REFERENCES [DWH].[DimInstrumentEquity] ([InstrumentID]) 
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [FK_FactEquitySnapshot_DimStatus] FOREIGN KEY ([InstrumentStatusID]) REFERENCES [DWH].[DimStatus] ([StatusID]) 
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [FK_FactEquitySnapshot_DimTime] FOREIGN KEY ([OCPTimeID]) REFERENCES [DWH].[DimTime] ([TimeID]) 
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [FK_FactEquitySnapshot_DimTime1] FOREIGN KEY ([LTPTimeID]) REFERENCES [DWH].[DimTime] ([TimeID]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [DWH].[FactEtfSnapshot]'
GO
ALTER TABLE [DWH].[FactEtfSnapshot] ADD CONSTRAINT [FK_FactEtfSnapshot_DimBatch] FOREIGN KEY ([BatchID]) REFERENCES [DWH].[DimBatch] ([BatchID]) 
GO
ALTER TABLE [DWH].[FactEtfSnapshot] ADD CONSTRAINT [FK_FactEtfSnapshot_DimDate] FOREIGN KEY ([DateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactEtfSnapshot] ADD CONSTRAINT [FK_FactEtfSnapshot_DimDate1] FOREIGN KEY ([LastExDivDateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactEtfSnapshot] ADD CONSTRAINT [FK_FactEtfSnapshot_DimDate2] FOREIGN KEY ([OCPDateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactEtfSnapshot] ADD CONSTRAINT [FK_FactEtfSnapshot_DimDate3] FOREIGN KEY ([LTPDateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactEtfSnapshot] ADD CONSTRAINT [FK_FactEtfSnapshot_DimInstrumentEtf] FOREIGN KEY ([InstrumentID]) REFERENCES [DWH].[DimInstrumentEtf] ([InstrumentID]) 
GO
ALTER TABLE [DWH].[FactEtfSnapshot] ADD CONSTRAINT [FK_FactEtfSnapshot_DimStatus] FOREIGN KEY ([InstrumentStatusID]) REFERENCES [DWH].[DimStatus] ([StatusID]) 
GO
ALTER TABLE [DWH].[FactEtfSnapshot] ADD CONSTRAINT [FK_FactEtfSnapshot_DimTime] FOREIGN KEY ([OCPTimeID]) REFERENCES [DWH].[DimTime] ([TimeID]) 
GO
ALTER TABLE [DWH].[FactEtfSnapshot] ADD CONSTRAINT [FK_FactEtfSnapshot_DimTime1] FOREIGN KEY ([LTPTimeID]) REFERENCES [DWH].[DimTime] ([TimeID]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [DWH].[FactEtfTrade]'
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [FK_FactEtfTrade_DimBatch] FOREIGN KEY ([BatchID]) REFERENCES [DWH].[DimBatch] ([BatchID]) 
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [FK_FactEtfTrade_DimBatch1] FOREIGN KEY ([CancelBatchID]) REFERENCES [DWH].[DimBatch] ([BatchID]) 
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [FK_FactEtfTrade_DimBroker] FOREIGN KEY ([BrokerID]) REFERENCES [DWH].[DimBroker] ([BrokerID]) 
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [FK_FactEtfTrade_DimCurrency] FOREIGN KEY ([CurrencyID]) REFERENCES [DWH].[DimCurrency] ([CurrencyID]) 
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [FK_FactEtfTrade_DimDate] FOREIGN KEY ([TradeDateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimEtfTradeJunk] FOREIGN KEY ([EquityTradeJunkID]) REFERENCES [DWH].[DimEquityTradeJunk] ([EquityTradeJunkID]) 
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [FK_FactEtfTrade_DimFile] FOREIGN KEY ([TradeFileID]) REFERENCES [DWH].[DimFile] ([FileID]) 
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [FK_FactEtfTrade_DimInstrument] FOREIGN KEY ([InstrumentID]) REFERENCES [DWH].[DimInstrument] ([InstrumentID]) 
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [FK_FactEtfTrade_DimTime1] FOREIGN KEY ([TradeTimeID]) REFERENCES [DWH].[DimTime] ([TimeID]) 
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [FK_FactEtfTrade_DimTradeModificationType] FOREIGN KEY ([TradeModificationTypeID]) REFERENCES [DWH].[DimTradeModificationType] ([TradeModificationTypeID]) 
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [FK_FactEtfTrade_DimTrader] FOREIGN KEY ([TraderID]) REFERENCES [DWH].[DimTrader] ([TraderID]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [DWH].[FactExchangeRate]'
GO
ALTER TABLE [DWH].[FactExchangeRate] ADD CONSTRAINT [FK_FactExchangeRate_DimBatch] FOREIGN KEY ([BatchID]) REFERENCES [DWH].[DimBatch] ([BatchID]) 
GO
ALTER TABLE [DWH].[FactExchangeRate] ADD CONSTRAINT [FK_FactExchangeRate_DimCurrency] FOREIGN KEY ([CurrencyID]) REFERENCES [DWH].[DimCurrency] ([CurrencyID]) 
GO
ALTER TABLE [DWH].[FactExchangeRate] ADD CONSTRAINT [FK_FactExchangeRate_DimDate] FOREIGN KEY ([DateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [DWH].[FactEquityIndex]'
GO
ALTER TABLE [DWH].[FactEquityIndex] ADD CONSTRAINT [FK_FactEquityIndex_DimDate] FOREIGN KEY ([IndexDateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactEquityIndex] ADD CONSTRAINT [FK_FactEquityIndex_DimTime] FOREIGN KEY ([IndexTimeID]) REFERENCES [DWH].[DimTime] ([TimeID]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [DWH].[FactEquityIndexSnapshot]'
GO
ALTER TABLE [DWH].[FactEquityIndexSnapshot] ADD CONSTRAINT [FK_FactEquityIndexSnapshot_DimDate] FOREIGN KEY ([DateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactEquityIndexSnapshot] ADD CONSTRAINT [FK_FactEquityIndexSnapshot_DimIndexType] FOREIGN KEY ([IndexTypeID]) REFERENCES [DWH].[DimIndexType] ([IndexTypeID]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [DWH].[DimInstrumentEquity]'
GO
ALTER TABLE [DWH].[DimInstrumentEquity] ADD CONSTRAINT [FK_DimInstrumentEquity_DimInstrument] FOREIGN KEY ([InstrumentID]) REFERENCES [DWH].[DimInstrument] ([InstrumentID]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [DWH].[DimInstrumentEtf]'
GO
ALTER TABLE [DWH].[DimInstrumentEtf] ADD CONSTRAINT [FK_DimInstrumentEtf_DimInstrument] FOREIGN KEY ([InstrumentID]) REFERENCES [DWH].[DimInstrument] ([InstrumentID]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [DWH].[DimInstrument]'
GO
ALTER TABLE [DWH].[DimInstrument] ADD CONSTRAINT [FK_DimInstrument_DimStatus] FOREIGN KEY ([InstrumentStatusID]) REFERENCES [DWH].[DimStatus] ([StatusID]) 
GO
ALTER TABLE [DWH].[DimInstrument] ADD CONSTRAINT [FK_DimInstrument_DimMarket] FOREIGN KEY ([MarketID]) REFERENCES [DWH].[DimMarket] ([MarketID]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering permissions on SCHEMA:: [DWH]'
GO
GRANT CONTROL ON SCHEMA:: [DWH] TO [EtlRunner]
GO
GRANT SELECT ON SCHEMA:: [DWH] TO [ReportRunner]
GO
GRANT EXECUTE ON SCHEMA:: [DWH] TO [ReportRunner]
GO
GRANT SELECT ON SCHEMA:: [DWH] TO [ReportWriter]
GO
GRANT EXECUTE ON SCHEMA:: [DWH] TO [ReportWriter]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering permissions on SCHEMA:: [ETL]'
GO
GRANT CONTROL ON SCHEMA:: [ETL] TO [EtlRunner]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering permissions on SCHEMA:: [Report]'
GO
GRANT ALTER ON SCHEMA:: [Report] TO [EtlRunner]
GO
GRANT SELECT ON SCHEMA:: [Report] TO [EtlRunner]
GO
GRANT INSERT ON SCHEMA:: [Report] TO [EtlRunner]
GO
GRANT DELETE ON SCHEMA:: [Report] TO [EtlRunner]
GO
GRANT UPDATE ON SCHEMA:: [Report] TO [EtlRunner]
GO
GRANT EXECUTE ON SCHEMA:: [Report] TO [EtlRunner]
GO
GRANT SELECT ON SCHEMA:: [Report] TO [ReportRunner]
GO
GRANT EXECUTE ON SCHEMA:: [Report] TO [ReportRunner]
GO
GRANT CONTROL ON SCHEMA:: [Report] TO [ReportWriter]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
GRANT CREATE DEFAULT TO [EtlRunner]
GRANT CREATE FUNCTION TO [EtlRunner]
GRANT CREATE PROCEDURE TO [EtlRunner]
GRANT CREATE RULE TO [EtlRunner]
GRANT CREATE TABLE TO [EtlRunner]
GRANT CREATE VIEW TO [EtlRunner]
GRANT CREATE DEFAULT TO [ReportWriter]
GRANT CREATE FUNCTION TO [ReportWriter]
GRANT CREATE PROCEDURE TO [ReportWriter]
GRANT CREATE RULE TO [ReportWriter]
GRANT CREATE TABLE TO [ReportWriter]
GRANT CREATE VIEW TO [ReportWriter]
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
