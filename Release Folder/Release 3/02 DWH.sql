/* 
Run this script on a database with the schema represented by: 
 
        DWH    -  This database will be modified. The scripts folder will not be modified. 
 
to synchronize it with a database with the schema represented by: 
 
        T7-DDT-01.DWH 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 28/03/2017 15:00:45 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [DWH]
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
PRINT N'Altering members of role EtlRunner'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering members of role ReportRunner'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering members of role ReportWriter'
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
PRINT N'Creating [DWH].[DimBatch]'
GO
CREATE TABLE [DWH].[DimBatch] 
( 
[BatchID] [int] NOT NULL IDENTITY(1, 1), 
[StartTime] [datetime] NOT NULL CONSTRAINT [DF_DimBatch_StartTime] DEFAULT (getdate()), 
[EndTime] [datetime] NULL, 
[ErrorFreeYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_DimBatch_ErrorFreeYN] DEFAULT ('Y'), 
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
[TradeVolume] [int] NOT NULL, 
[TradeTurnover] [numeric] (19, 6) NOT NULL, 
[TradeModificationTypeID] [smallint] NOT NULL, 
[InColumnStore] [bit] NOT NULL CONSTRAINT [DF_FactEquityTrade_InColumnStore] DEFAULT ((0)), 
[TradeFileID] [int] NOT NULL, 
[BatchID] [int] NOT NULL, 
[CancelBatchID] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactEquityTrade] on [DWH].[FactEquityTrade]'
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [PK_FactEquityTrade] PRIMARY KEY CLUSTERED  ([EquityTradeID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FactEquityTrade_DuplicateCheck] on [DWH].[FactEquityTrade]'
GO
CREATE NONCLUSTERED INDEX [IX_FactEquityTrade_DuplicateCheck] ON [DWH].[FactEquityTrade] ([TradeDateID], [TradingSysTransNo])
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
[TradeFileID] [int] NOT NULL, 
[BatchID] [int] NOT NULL CONSTRAINT [DF_FactEtfTrade_BatchID] DEFAULT ((0)), 
[CancelBatchID] [int] NULL, 
[InColumnStore] [bit] NOT NULL 
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
PRINT N'Creating [DWH].[DimMarket]'
GO
CREATE TABLE [DWH].[DimMarket] 
( 
[MarketID] [smallint] NOT NULL IDENTITY(1, 1), 
[MarketCode] [varchar] (15) COLLATE Latin1_General_CI_AS NOT NULL, 
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
[FinancialYearEndDate] [date] NOT NULL, 
[IncorporationDate] [date] NOT NULL, 
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
[CompanyApprovalDate] [date] NOT NULL, 
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
[CompanyListedDate] [date] NOT NULL, 
[CompanyApprovalType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[CompanyApprovalDate] [date] NOT NULL, 
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
[FinancialYearEndDate] [date] NOT NULL, 
[IncorporationDate] [date] NOT NULL, 
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[TransparencyDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProspectusDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerDomicileDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[FeeCodeName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuedDate] [date] NOT NULL, 
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
[CompanyListedDate] [date] NOT NULL, 
[CompanyApprovalType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[CompanyApprovalDate] [date] NOT NULL, 
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
[FinancialYearEndDate] [date] NOT NULL, 
[IncorporationDate] [date] NOT NULL, 
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[TransparencyDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProspectusDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerDomicileDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[FeeCodeName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuedDate] [date] NOT NULL, 
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
WITH 
( 
DATA_COMPRESSION = PAGE 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactEquitySnapshot] on [DWH].[FactEquitySnapshot]'
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [PK_FactEquitySnapshot] PRIMARY KEY CLUSTERED  ([EquitySnapshotID]) WITH (DATA_COMPRESSION = PAGE)
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
[TradingEndTime] [time] NOT NULL 
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
[DailyOfficalListYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[EBCFee] [numeric] (19, 6) NOT NULL, 
[Location] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[MemberType] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
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
[TradeFlagName5] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL 
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
PRINT N'Creating [DWH].[DimFile]'
GO
CREATE TABLE [DWH].[DimFile] 
( 
[FileID] [int] NOT NULL IDENTITY(1, 1), 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileTypeTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[SaftFileLetter] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileProcessedTime] [datetime2] NOT NULL, 
[FilePrcocessedStatus] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
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
PRINT N'Creating [DWH].[DimTrader]'
GO
CREATE TABLE [DWH].[DimTrader] 
( 
[TraderID] [smallint] NOT NULL IDENTITY(1, 1), 
[TraderCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[BrokerCode] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL, 
[TraderType] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[Infered] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL 
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
PRINT N'Creating [DWH].[FactEtfSnapshot]'
GO
CREATE TABLE [DWH].[FactEtfSnapshot] 
( 
[EtfSnapshotID] [int] NOT NULL IDENTITY(1, 1), 
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
PRINT N'Creating [DWH].[FactExchangeRate]'
GO
CREATE TABLE [DWH].[FactExchangeRate] 
( 
[ExchangeRateID] [int] NOT NULL IDENTITY(1, 1), 
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
PRINT N'Creating [DWH].[FactMarketAggregation]'
GO
CREATE TABLE [DWH].[FactMarketAggregation] 
( 
[DateID] [int] NOT NULL, 
[MarketAggregationID] [tinyint] NOT NULL, 
[TurnoverEur] [numeric] (19, 6) NOT NULL, 
[Volume] [bigint] NOT NULL, 
[TurnoverEurConditional] [numeric] (19, 6) NOT NULL, 
[VolumeConditional] [bigint] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactMarketAggregation_1] on [DWH].[FactMarketAggregation]'
GO
ALTER TABLE [DWH].[FactMarketAggregation] ADD CONSTRAINT [PK_FactMarketAggregation_1] PRIMARY KEY CLUSTERED  ([DateID], [MarketAggregationID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FactMarketAggregation] on [DWH].[FactMarketAggregation]'
GO
CREATE NONCLUSTERED INDEX [IX_FactMarketAggregation] ON [DWH].[FactMarketAggregation] ([DateID], [MarketAggregationID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [DWH].[DimMarketAggregation]'
GO
CREATE TABLE [DWH].[DimMarketAggregation] 
( 
[MarketAggregationID] [tinyint] NOT NULL IDENTITY(1, 1), 
[MarketCode] [varchar] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
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
PRINT N'Creating [DWH].[ApplyFactMarketAggrgation]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 21/3/2017 
-- Description:	Apply market aggregations 
-- ============================================= 
CREATE PROCEDURE [DWH].[ApplyFactMarketAggrgation] 
	@DateID INT 
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
		VolumeConditional = T.VolumeConditional 
	FROM 
			DWH.FactMarketAggregation F 
		INNER JOIN 
			#Aggregations T 
		ON  
			F.MarketAggregationID = T.MarketAggregationID 
		AND 
			F.DateID = T.DateID 
 
 
	/* INSERT */ 
 
	INSERT INTO 
			DWH.FactMarketAggregation 
		( 
			DateID,  
			MarketAggregationID,  
			TurnoverEur,  
			Volume,  
			TurnoverEurConditional,  
			VolumeConditional 
		) 
		SELECT 
			DateID,  
			MarketAggregationID,  
			TurnoverEur,  
			Volume,  
			TurnoverEurConditional,  
			VolumeConditional 
		FROM 
			#Aggregations T 
		WHERE 
			NOT EXISTS ( 
				SELECT 
					* 
				FROM				 
					DWH.FactMarketAggregation F 
				WHERE 
					F.MarketAggregationID = T.MarketAggregationID 
				AND 
					F.DateID = T.DateID 
				) 
				 
 
END 
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[FactEtfSnapshotMerge]'
GO
CREATE TABLE [ETL].[FactEtfSnapshotMerge] 
( 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentID] [int] NOT NULL, 
[CurrentInstrumentID] [int] NOT NULL, 
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
PRINT N'Creating [ETL].[FactEquitySnapshotMerge]'
GO
CREATE TABLE [ETL].[FactEquitySnapshotMerge] 
( 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentID] [int] NOT NULL, 
[CurrentInstrumentID] [int] NOT NULL, 
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
PRINT N'Creating [ETL].[EquityTradeDate]'
GO
CREATE TABLE [ETL].[EquityTradeDate] 
( 
[TradeDateID] [int] NULL 
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
[A_TRADE_TIME_OCP_GMT] [datetime] NOT NULL, 
[PriceVersions] [int] NOT NULL, 
[TimeVersions] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EquityTradeSnapshot]'
GO
CREATE TABLE [ETL].[EquityTradeSnapshot] 
( 
[AggregateDate] [date] NULL, 
[AggregateDateID] [int] NULL, 
[InstrumentID] [int] NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentType] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[OCP] [numeric] (19, 6) NULL, 
[OCP_DATEID] [int] NULL, 
[OCP_TIME] [time] NULL, 
[OCP_TIME_ID] [int] NULL, 
[OOP] [numeric] (19, 6) NULL, 
[LastPriceTimeID] [smallint] NULL, 
[LastPrice] [numeric] (19, 6) NULL, 
[LowPrice] [int] NULL, 
[HighPrice] [int] NULL, 
[Deals] [int] NULL, 
[DealsOB] [int] NULL, 
[DealsND] [int] NULL, 
[TradeVolume] [int] NULL, 
[TradeVolumeOB] [int] NULL, 
[TradeVolumeND] [int] NULL, 
[TradeTurnover] [numeric] (38, 6) NULL, 
[TradeTurnoverOB] [numeric] (38, 6) NULL, 
[TradeTurnoverND] [numeric] (38, 6) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[ClosingPrice]'
GO
CREATE TABLE [ETL].[ClosingPrice] 
( 
[AggregateDate] [date] NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[PRICE_TIMESTAMP_NO] [int] NULL, 
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
PRINT N'Creating [DWH].[DimIndex]'
GO
CREATE TABLE [DWH].[DimIndex] 
( 
[IndexID] [smallint] NOT NULL IDENTITY(1, 1), 
[IndexCode] [char] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[IndexName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[ISIN] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL, 
[SEDOL] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[ReturnISIN] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL, 
[ReturnSEDOL] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DimIndex] on [DWH].[DimIndex]'
GO
ALTER TABLE [DWH].[DimIndex] ADD CONSTRAINT [PK_DimIndex] PRIMARY KEY CLUSTERED  ([IndexID])
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
   
	/* TRUNCATE TABLES */   
	TRUNCATE TABLE DWH.FactEquitySnapshot   
	TRUNCATE TABLE DWH.FactEquityTrade   
	TRUNCATE TABLE DWH.FactEtfSnapshot   
	TRUNCATE TABLE DWH.FactEtfTrade   
	TRUNCATE TABLE DWH.FactExchangeRate   
	TRUNCATE TABLE DWH.FactInstrumentStatusHistory   
	TRUNCATE TABLE DWH.FactMarketAggregation 
 
	/* EMPTY TABLES REFERENCED BY FOREIGN KEYS */   
	DELETE DWH.DimInstrumentEquity   
	DELETE DWH.DimInstrumentEtf  
	DELETE DWH.DimInstrument  
	DELETE DWH.DimIndex   
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
	DBCC CHECKIDENT ('DWH.DimIndex',RESEED,0);     
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
   
	/* NOT A DATE - EG NO PUBLICATION DATE */   
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
			'19991231',   
			'N',   
			1999,   
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
   
	/* Need to add using dimension manager */  
	/*  
	/* DUMMY CURRENCIES */   
	INSERT INTO   
			DWH.FactExchangeRate   
		(   
			DateID, CurrencyID, ExchangeRate, BatchID   
		)   
		VALUES    
		( -1,	1,	1,	-1 ),   
		( -1,	2,	1,	-1 ),   
		( -1,	3,	1,	-1 ),   
		( -1,	4,	1,	-1 ),   
		( -1,	5,	1,	-1 ),   
		( -1,	6,	1,	-1 ),   
		( -1,	7,	1,	-1 ),   
		( -1,	8,	1,	-1 ),   
		( -1,	9,	1,	-1 ),   
		( -1,	10,	1,	-1 ),   
		( -1,	11,	1,	-1 )   
	*/  
  
	/* EXTRA TABLES - THESE ARE NOT PART OF THE DWH MODEL */   
	TRUNCATE TABLE ETL.AggregationDateList   
	TRUNCATE TABLE ETL.BidOfferPrice   
	TRUNCATE TABLE ETL.ClosingPrice   
	TRUNCATE TABLE ETL.EquityTradeSnapshot   
	TRUNCATE TABLE ETL.OCP   
	TRUNCATE TABLE ETL.OOP   
	TRUNCATE TABLE Report.RefEquityFeeBand   
	TRUNCATE TABLE ETL.EquityTradeDate  
	TRUNCATE TABLE ETL.FactEquitySnapshotMerge  
	TRUNCATE TABLE ETL.FactEtfSnapshotMerge  
  
END   
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
		EndTime = GETDATE() 
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
		EndTime IS NULL 
 
	/* Create a new batch */ 
	INSERT INTO	 
			DWH.DimBatch 
		( 
			ETLVersion 
		) 
		OUTPUT 
			inserted.BatchID 
		VALUES 
		( 
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
	@FilePrcocessedStatus VARCHAR(50) 
AS 
BEGIN 
	SET NOCOUNT ON; 
 
	DECLARE @File TABLE ( 
				FileName VARCHAR(50),  
				FileTypeTag VARCHAR(50),  
				SaftFileLetter CHAR(1),  
				FilePrcocessedStatus VARCHAR(50) 
		) 
	INSERT INTO 
			@File 
		VALUES 
			( 
				@FileName, 
				@FileTypeTag, 
				@SaftFileLetter, 
				@FilePrcocessedStatus 
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
					FilePrcocessedStatus = I.FilePrcocessedStatus 
		WHEN NOT MATCHED THEN 
			INSERT  
					( FileName, FileType, FileTypeTag, SaftFileLetter, FileProcessedTime, FilePrcocessedStatus ) 
 
				VALUES  
					( I.FileName, I.FileTypeTag, I.FileTypeTag, I.SaftFileLetter, GETDATE(), I.FilePrcocessedStatus ) 
		OUTPUT 		 
			$ACTION, INSERTED.FileID; 
 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[UpdateFactEquitySnapshot]'
GO
 
CREATE PROCEDURE [ETL].[UpdateFactEquitySnapshot] AS  
 
BEGIN 
	/* STATS SECTION NOT POPULATED BY ETL YET */ 
 
 
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
		ISEQOverallMarketCap = E.ISEQOverallMarketCap, 
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
		BatchID = E.BatchID 
	FROM 
			DWH.FactEquitySnapshot DWH 
		INNER JOIN 
			DWH.DimInstrumentEquity I 
		ON DWH.InstrumentID = I.InstrumentID 
		INNER JOIN		 
			ETL.FactEquitySnapshotMerge E 
		ON  
			I.ISIN = E.ISIN 
		AND 
			DWH.DateID = E.DateID 
 
 
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
			LTPDateID, 
			LTPTimeID, 
			LTPTime, 
			UtcLTPTime, 
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
							I.ISIN = E.ISIN 
						AND 
							DWH.DateID = E.DateID 
				)			 
 
 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[UpdateFactEtfSnapshot]'
GO
 
CREATE PROCEDURE [ETL].[UpdateFactEtfSnapshot] AS  
 
BEGIN 
	/* STATS SECTION NOT POPULATED BY ETL YET */ 
 
 
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
		ISEQOverallMarketCap = E.ISEQOverallMarketCap, 
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
PRINT N'Creating [ETL].[ActiveInstrumentsDates]'
GO
 
 
 
 
 
CREATE VIEW [ETL].[ActiveInstrumentsDates] AS 
		/* NEEDS TO BE REWORKED WHEN XT DATA IS AVAILABLE */ 
		SELECT 
			DL.AggregateDate, 
			DL.AggregateDateID, 
			I.InstrumentID, 
			I.ISIN, 
			I.InstrumentType, 
			/* MIGHT BE BETTER TO USE THE INSTRUMENT TYPE */ 
			IIF( EQUITY.InstrumentID IS NOT NULL, 'EQUITY', 'ETF' ) AS SourceTable, 
			ISNULL(EQUITY.CurrencyID, ETF.CurrencyID ) AS CurrencyID 
		FROM 
				DWH.DimInstrument I 
			INNER JOIN 
				DWH.DimStatus S 
			ON I.InstrumentStatusID = S.StatusID 
			LEFT OUTER JOIN 
				DWH.DimInstrumentEquity EQUITY 
			ON I.InstrumentID = EQUITY.InstrumentID 
			LEFT OUTER JOIN 
				DWH.DimInstrumentEtf ETF 
			ON I.InstrumentID = ETF.InstrumentID 
			CROSS JOIN 
				ETL.AggregationDateList DL 
		WHERE 
				I.CurrentRowYN = 'Y' 
			AND 
				S.StatusName = 'LISTED' 
						 
 
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
			AID.AggregateDate,   
			AID.AggregateDateID,   
			AID.InstrumentID,   
			AID.ISIN,   
			AID.CurrencyID, 
			E.TotalSharesInIssue, 
			ExRate.ExchangeRate  
		FROM  
				ETL.ActiveInstrumentsDates AID 			 
			INNER JOIN  
				dwh.DimInstrumentEquity E 
			ON AID.InstrumentID = E.InstrumentID 
			CROSS APPLY   
			(  
				SELECT  
					TOP 1  
					ExchangeRate  
				FROM  
					DWH.FactExchangeRate EX  
				WHERE  
					AID.AggregateDateID >= EX.DateID   
				AND  
					AID.CurrencyID = EX.CurrencyID  
				ORDER BY  
					EX.DateID DESC  
			) AS ExRate  
  
  
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
			D.ISIN,  
  
			/* OCP */  
			OCP = COALESCE( OCP.A_OFFICIAL_CLOSING_PRICE, LastOCP.OCP, NULL ),  
  
			/* NO LOCAL TIME CONVERSION */  
			OCP_DATEID = COALESCE( CAST(CONVERT(CHAR,OCP.A_TRADE_TIME_OCP_GMT,112) AS INT), LastOCP.OCPDateID, NULL ),  
			OCP_TIME = COALESCE( CONVERT(TIME,OCP.A_TRADE_TIME_OCP_GMT,112), LastOCP.OCPTime, NULL),  
			OCP_TIME_UTC = COALESCE( CONVERT(TIME,OCP.A_TRADE_TIME_OCP,112), LastOCP.UtcOCPTime, NULL),  
			OCP_TIME_ID = COALESCE( CAST(REPLACE(LEFT(CONVERT(CHAR,OCP.A_TRADE_TIME_OCP_GMT,114),5),':','') AS INT), LastOCP.OCPTimeID, NULL ),  
  
			/* OOP */  
			OOP = COALESCE( OOP.A_OFFICIAL_OPENING_PRICE, LastOCP.OCP, NULL )  
  
		FROM  
				ETL.ActiveInstrumentsDates D  
			LEFT OUTER JOIN  
			/* OCP FOR TODAYS */  
				ETL.OCP OCP  
			ON   
				D.AggregateDate = OCP.AggregateDate  
			AND   
				D.ISIN = OCP.A_ISIN  
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
					F.UtcOCPTime  
				FROM  
						DWH.FactEquitySnapshot AS F  
					INNER JOIN  
						DWH.DimInstrument I 
					ON F.InstrumentID = I.InstrumentID  
				WHERE  
					D.AggregateDateID > F.DateID  
				AND  
					D.ISIN = I.ISIN  
				ORDER BY  
					F.DateID DESC  
			) AS LastOCP  
			LEFT OUTER JOIN  
				ETL.OOP OOP  
			ON   
				D.AggregateDate = OOP.AggregateDate  
			AND   
				D.ISIN = OOP.A_ISIN  
  
 
 
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
				DWH.FactEquityTrade T  
			INNER JOIN  
				DWH.DimInstrumentEquity I  
			ON T.InstrumentID = I.InstrumentID  
			AND I.CurrentRowYN = 'Y'  
			INNER JOIN  
				DWH.DimTradeModificationType TM  
			ON T.TradeModificationTypeID = TM.TradeModificationTypeID  
		WHERE  
			TM.CancelTradeYN <> 'N' 
		GROUP BY  
			I.ISIN,  
			T.TradeDateID  
  
  
 
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
			LastTrade.ISIN,   
			T.TradeDateID,   
			T.TradeTimeID,   
			T.TradeTimestamp,   
			T.UTCTradeTimeStamp,   
			MAX(T.TradePrice) AS TradePrice   
		FROM   
				DWH.FactEquityTrade T   
			INNER JOIN   
				DWH.DimInstrumentEquity EQUITY   
			ON T.InstrumentID = EQUITY.InstrumentID   
			INNER JOIN   
				ETL.ActiveInstrumentsDates AID   
			ON    
				EQUITY.ISIN = AID.ISIN   
			AND   
				T.TradeDateID = AID.AggregateDateID   
			INNER JOIN   
				DWH.DimTradeModificationType MOD   
			ON T.TradeModificationTypeID = MOD.TradeModificationTypeID   
			AND MOD.CancelTradeYN <> 'N'  
			INNER JOIN   
			(   
				SELECT   
					AID.AggregateDateID,    
					AID.ISIN,    
					MAX(TradeTimestamp) AS TradeTimestamp,   
					COUNT(*) CNT,   
					MIN(TradeTimestamp) AS T1   
				FROM   
						DWH.FactEquityTrade T   
					INNER JOIN   
						DWH.DimInstrumentEquity EQUITY   
					ON T.InstrumentID = EQUITY.InstrumentID   
					INNER JOIN   
						ETL.ActiveInstrumentsDates AID   
					ON    
						EQUITY.ISIN = AID.ISIN   
					AND   
						T.TradeDateID = AID.AggregateDateID   
					INNER JOIN   
						DWH.DimTradeModificationType MOD   
					ON T.TradeModificationTypeID = MOD.TradeModificationTypeID   
					AND MOD.CancelTradeYN <> 'N' 
				WHERE   
					T.DelayedTradeYN = 'N'   
				GROUP BY   
					AID.AggregateDateID,    
					AID.ISIN   
			) AS LastTrade   
			ON   
				T.TradeDateID = LastTrade.AggregateDateID   
			AND   
				EQUITY.ISIN = LastTrade.ISIN   
			AND   
				T.TradeTimestamp = LastTrade.TradeTimestamp   
		WHERE   
			T.DelayedTradeYN = 'N'   
		GROUP BY   
			LastTrade.AggregateDateID,    
			LastTrade.ISIN,   
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
			AID.AggregateDate,   
			AID.AggregateDateID,   
			AID.InstrumentID,   
			AID.ISIN,   
			COALESCE( L1.TradeDateID, LastTrade.LTPDateID) AS LTPDateID ,  
			COALESCE( L1.TradeTimeID, LastTrade.LTPTimeID) AS LTPTimeID,  
			COALESCE( L1.TradeTimestamp, LastTrade.LTPTime) AS LTPTime,  
			COALESCE( L1.UTCTradeTimeStamp, LastTrade.UtcLTPTime) AS UtcLTPTime,  
			COALESCE( L1.TradePrice, LastTrade.LTP ) AS LastPrice  
		FROM  
				ETL.ActiveInstrumentsDates AID  
			LEFT OUTER JOIN  
				ETL.EquityTradeLastTradeDateScoped L1  
			ON   
				AID.AggregateDateID = L1.AggregateDateID  
			AND   
				AID.ISIN = L1.ISIN  
			/* MOST RECENT TRADE RECORDED IN SNAPSHOT */  
			OUTER APPLY  
			(  
				SELECT  
					TOP 1  
  
					F.LTP,  
					F.LTPDateID,  
					F.LTPTimeID,  
					F.LTPTime,  
					F.UtcLTPTime  
				FROM  
						DWH.FactEquitySnapshot F  
					INNER JOIN  
						DWH.DimInstrumentEquity EQUITY  
					ON F.InstrumentID = EQUITY.InstrumentID  
				WHERE  
					AID.AggregateDateID > F.DateID  
				AND  
					AID.ISIN = EQUITY.ISIN  
				ORDER BY  
					F.DateID ASC  
			) AS LastTrade  
  
  
  
  
  
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EquityVolume]'
GO
   
CREATE VIEW [ETL].[EquityVolume] AS   
		SELECT   
			AID.AggregateDate,    
			AID.AggregateDateID,    
			AID.InstrumentID,    
			AID.ISIN,    
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
			SUM( TradeTurnover * ExRate.ExchangeRate ) AS TurnoverEur,   
			SUM( IIF( JK.TradeTypeCategory = 'OB',TradeTurnover * ExRate.ExchangeRate ,0) ) AS TurnoverObEur,   
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,TradeTurnover * ExRate.ExchangeRate ) ) AS TurnoverNdEur,   
			MIN(ExRate.ExchangeRate ) EXR   
   
		FROM   
				ETL.ActiveInstrumentsDates AID   
			INNER JOIN   
				DWH.FactEquityTrade T   
			ON AID.InstrumentID = T.InstrumentID   
			AND AID.AggregateDateID = T.TradeDateID   
			INNER JOIN   
				DWH.DimEquityTradeJunk JK   
			ON T.EquityTradeJunkID = JK.EquityTradeJunkID   
			INNER JOIN   
				DWH.DimTradeModificationType MT   
			ON T.TradeModificationTypeID = MT.TradeModificationTypeID   
			AND MT.CancelTradeYN <> 'N' 
			CROSS APPLY    
			(   
				SELECT   
					TOP 1   
					ExchangeRate   
				FROM   
					DWH.FactExchangeRate EX   
				WHERE   
					AID.AggregateDateID >= EX.DateID    
				AND   
					AID.CurrencyID = EX.CurrencyID   
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
			AID.AggregateDate,    
			AID.AggregateDateID,    
			AID.InstrumentID,    
			AID.ISIN   
   
   
   
   
   
  
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EtfMarketCap]'
GO
 
CREATE VIEW [ETL].[EtfMarketCap] AS  
		SELECT  
			AID.AggregateDate,   
			AID.AggregateDateID,   
			AID.InstrumentID,   
			AID.ISIN,   
			AID.CurrencyID, 
			E.TotalSharesInIssue, 
			ExRate.ExchangeRate  
		FROM  
				ETL.ActiveInstrumentsDates AID 			 
			INNER JOIN  
				dwh.DimInstrumentEtf E 
			ON AID.InstrumentID = E.InstrumentID 
			CROSS APPLY   
			(  
				SELECT  
					TOP 1  
					ExchangeRate  
				FROM  
					DWH.FactExchangeRate EX  
				WHERE  
					AID.AggregateDateID >= EX.DateID   
				AND  
					AID.CurrencyID = EX.CurrencyID  
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
			D.ISIN,  
  
			/* OCP */  
			OCP = COALESCE( OCP.A_OFFICIAL_CLOSING_PRICE, LastOCP.OCP, NULL ),  
  
			/* NO LOCAL TIME CONVERSION */  
			OCP_DATEID = COALESCE( CAST(CONVERT(CHAR,OCP.A_TRADE_TIME_OCP_GMT,112) AS INT), LastOCP.OCPDateID, NULL ),  
			OCP_TIME = COALESCE( CONVERT(TIME,OCP.A_TRADE_TIME_OCP_GMT,112), LastOCP.OCPTime, NULL),  
			OCP_TIME_UTC = COALESCE( CONVERT(TIME,OCP.A_TRADE_TIME_OCP,112), LastOCP.UtcOCPTime, NULL),  
			OCP_TIME_ID = COALESCE( CAST(REPLACE(LEFT(CONVERT(CHAR,OCP.A_TRADE_TIME_OCP_GMT,114),5),':','') AS INT), LastOCP.OCPTimeID, NULL ),  
  
			/* OOP */  
			OOP = COALESCE( OOP.A_OFFICIAL_OPENING_PRICE, LastOCP.OCP, NULL )  
  
		FROM  
				ETL.ActiveInstrumentsDates D  
			LEFT OUTER JOIN  
			/* OCP FOR TODAYS */  
				ETL.OCP OCP  
			ON   
				D.AggregateDate = OCP.AggregateDate  
			AND   
				D.ISIN = OCP.A_ISIN  
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
					F.UtcOCPTime  
				FROM  
						DWH.FactEtfSnapshot AS F  
					INNER JOIN  
						DWH.DimInstrument I 
					ON F.InstrumentID = I.InstrumentID  
				WHERE  
					D.AggregateDateID > F.DateID  
				AND  
					D.ISIN = I.ISIN  
				ORDER BY  
					F.DateID DESC  
			) AS LastOCP  
			LEFT OUTER JOIN  
				ETL.OOP OOP  
			ON   
				D.AggregateDate = OOP.AggregateDate  
			AND   
				D.ISIN = OOP.A_ISIN  
  
 
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EtfTradeHighLow]'
GO
 
  
CREATE VIEW [ETL].[EtfTradeHighLow] AS   
		SELECT   
			I.ISIN,   
			T.TradeDateID,   
			COUNT(*) CNT,   
			MIN(T.TradePrice) AS LowPrice,   
			MAX(T.TradePrice) AS HighPrice   
		FROM   
				DWH.FactEtfTrade T   
			INNER JOIN   
				DWH.DimInstrumentEtf I   
			ON T.InstrumentID = I.InstrumentID   
			AND I.CurrentRowYN = 'Y'   
			INNER JOIN   
				DWH.DimTradeModificationType TM   
			ON T.TradeModificationTypeID = TM.TradeModificationTypeID   
		WHERE   
			TM.CancelTradeYN <> 'N' 
		GROUP BY   
			I.ISIN,   
			T.TradeDateID   
   
   
  
 
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
			LastTrade.ISIN,  
			T.TradeDateID,  
			T.TradeTimeID,  
			T.TradeTimestamp,  
			T.UTCTradeTimeStamp,  
			MAX(T.TradePrice) AS TradePrice  
		FROM  
				DWH.FactEtfTrade T  
			INNER JOIN  
				DWH.DimInstrumentEtf Etf  
			ON T.InstrumentID = Etf.InstrumentID  
			INNER JOIN  
				ETL.ActiveInstrumentsDates AID  
			ON   
				Etf.ISIN = AID.ISIN  
			AND  
				T.TradeDateID = AID.AggregateDateID  
			INNER JOIN  
				DWH.DimTradeModificationType MOD  
			ON T.TradeModificationTypeID = MOD.TradeModificationTypeID  
			AND MOD.TradeModificationTypeName <> 'CANCEL'  
			INNER JOIN  
			(  
				SELECT  
					AID.AggregateDateID,   
					AID.ISIN,   
					MAX(TradeTimestamp) AS TradeTimestamp,  
					COUNT(*) CNT,  
					MIN(TradeTimestamp) AS T1  
				FROM  
						DWH.FactEtfTrade T  
					INNER JOIN  
						DWH.DimInstrumentEtf Etf  
					ON T.InstrumentID = Etf.InstrumentID  
					INNER JOIN  
						ETL.ActiveInstrumentsDates AID  
					ON   
						Etf.ISIN = AID.ISIN  
					AND  
						T.TradeDateID = AID.AggregateDateID  
					INNER JOIN  
						DWH.DimTradeModificationType MOD  
					ON T.TradeModificationTypeID = MOD.TradeModificationTypeID  
					AND MOD.TradeModificationTypeName <> 'CANCEL'  
				WHERE  
					T.DelayedTradeYN = 'N'  
				GROUP BY  
					AID.AggregateDateID,   
					AID.ISIN  
			) AS LastTrade  
			ON  
				T.TradeDateID = LastTrade.AggregateDateID  
			AND  
				Etf.ISIN = LastTrade.ISIN  
			AND  
				T.TradeTimestamp = LastTrade.TradeTimestamp  
		WHERE  
			T.DelayedTradeYN = 'N'  
		GROUP BY  
			LastTrade.AggregateDateID,   
			LastTrade.ISIN,  
			T.TradeDateID,  
			T.TradeTimeID,  
			T.TradeTimestamp,  
			T.UTCTradeTimeStamp  
  
  
  
  
 
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EtfTradeLastTrade]'
GO
 
 
  
  
  
CREATE VIEW [ETL].[EtfTradeLastTrade] AS  
	/* LAST TRADE PRICE & DATE */  
		SELECT  
			AID.AggregateDate,   
			AID.AggregateDateID,   
			AID.InstrumentID,   
			AID.ISIN,   
			COALESCE( L1.TradeDateID, LastTrade.LTPDateID) AS LTPDateID ,  
			COALESCE( L1.TradeTimeID, LastTrade.LTPTimeID) AS LTPTimeID,  
			COALESCE( L1.TradeTimestamp, LastTrade.LTPTime) AS LTPTime,  
			COALESCE( L1.UTCTradeTimeStamp, LastTrade.UtcLTPTime) AS UtcLTPTime,  
			COALESCE( L1.TradePrice, LastTrade.LTP ) AS LastPrice  
		FROM  
				ETL.ActiveInstrumentsDates AID  
			LEFT OUTER JOIN  
				ETL.EtfTradeLastTradeDateScoped L1  
			ON   
				AID.AggregateDateID = L1.AggregateDateID  
			AND   
				AID.ISIN = L1.ISIN  
			/* MOST RECENT TRADE RECORDED IN SNAPSHOT */  
			OUTER APPLY  
			(  
				SELECT  
					TOP 1  
  
					F.LTP,  
					F.LTPDateID,  
					F.LTPTimeID,  
					F.LTPTime,  
					F.UtcLTPTime  
				FROM  
						DWH.FactEtfSnapshot F  
					INNER JOIN  
						DWH.DimInstrumentEtf Etf  
					ON F.InstrumentID = Etf.InstrumentID  
				WHERE  
					AID.AggregateDateID > F.DateID  
				AND  
					AID.ISIN = Etf.ISIN  
				ORDER BY  
					F.DateID ASC  
			) AS LastTrade  
  
  
  
  
  
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [ETL].[EtfVolume]'
GO
 
  
CREATE VIEW [ETL].[EtfVolume] AS   
		SELECT   
			AID.AggregateDate,    
			AID.AggregateDateID,    
			AID.InstrumentID,    
			AID.ISIN,    
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
			SUM( TradeTurnover * ExRate.ExchangeRate ) AS TurnoverEur,   
			SUM( IIF( JK.TradeTypeCategory = 'OB',TradeTurnover * ExRate.ExchangeRate ,0) ) AS TurnoverObEur,   
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,TradeTurnover * ExRate.ExchangeRate ) ) AS TurnoverNdEur,   
			MIN(ExRate.ExchangeRate ) EXR   
   
		FROM   
				ETL.ActiveInstrumentsDates AID   
			INNER JOIN   
				DWH.FactEtfTrade T   
			ON AID.InstrumentID = T.InstrumentID   
			AND AID.AggregateDateID = T.TradeDateID   
			INNER JOIN   
				DWH.DimEquityTradeJunk JK   
			ON T.EquityTradeJunkID = JK.EquityTradeJunkID  
			INNER JOIN   
				DWH.DimTradeModificationType MT   
			ON T.TradeModificationTypeID = MT.TradeModificationTypeID   
			AND MT.CancelTradeYN <> 'N' 
			CROSS APPLY    
			(   
				SELECT   
					TOP 1   
					ExchangeRate   
				FROM   
					DWH.FactExchangeRate EX   
				WHERE   
					AID.AggregateDateID >= EX.DateID    
				AND   
					AID.CurrencyID = EX.CurrencyID   
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
			AID.AggregateDate,    
			AID.AggregateDateID,    
			AID.InstrumentID,    
			AID.ISIN   
   
   
   
   
   
  
  
 
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
PRINT N'Adding foreign keys to [DWH].[FactEquityTrade]'
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimBatch] FOREIGN KEY ([BatchID]) REFERENCES [DWH].[DimBatch] ([BatchID]) 
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimBatch1] FOREIGN KEY ([CancelBatchID]) REFERENCES [DWH].[DimBatch] ([BatchID]) 
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimBroker] FOREIGN KEY ([BrokerID]) REFERENCES [DWH].[DimBroker] ([BrokerID]) 
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimCurrency] FOREIGN KEY ([CurrencyID]) REFERENCES [DWH].[DimCurrency] ([CurrencyID]) 
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimDate] FOREIGN KEY ([TradeDateID]) REFERENCES [DWH].[DimDate] ([DateID]) 
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimEquityTradeJunk] FOREIGN KEY ([EquityTradeJunkID]) REFERENCES [DWH].[DimEquityTradeJunk] ([EquityTradeJunkID]) 
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimFile] FOREIGN KEY ([TradeFileID]) REFERENCES [DWH].[DimFile] ([FileID]) 
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimInstrument] FOREIGN KEY ([InstrumentID]) REFERENCES [DWH].[DimInstrument] ([InstrumentID]) 
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimTime1] FOREIGN KEY ([TradeTimeID]) REFERENCES [DWH].[DimTime] ([TimeID]) 
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimTradeModificationType] FOREIGN KEY ([TradeModificationTypeID]) REFERENCES [DWH].[DimTradeModificationType] ([TradeModificationTypeID]) 
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimTrader] FOREIGN KEY ([TraderID]) REFERENCES [DWH].[DimTrader] ([TraderID]) 
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
PRINT N'Altering permissions on SCHEMA:: [Report]'
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
