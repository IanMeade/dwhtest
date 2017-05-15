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
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [PK_FactEquitySnapshot] PRIMARY KEY CLUSTERED  ([EquitySnapshotID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FactEquitySnapshot] ON [DWH].[FactEquitySnapshot] ([DateID], [InstrumentID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FactEquitySnapshot_1] ON [DWH].[FactEquitySnapshot] ([InstrumentID], [DateID]) ON [PRIMARY]
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
