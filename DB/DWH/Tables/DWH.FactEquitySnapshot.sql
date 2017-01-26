CREATE TABLE [DWH].[FactEquitySnapshot]
(
[EquitySnapshotID] [int] NOT NULL IDENTITY(1, 1),
[InstrumentID] [int] NOT NULL,
[InstrumentStatusID] [smallint] NOT NULL,
[DateID] [int] NOT NULL,
[LastExDivDateID] [int] NOT NULL,
[OCPDateID] [int] NOT NULL,
[OCPTimeID] [smallint] NOT NULL,
[OCPTime] [time] NOT NULL,
[LTPDateID] [int] NOT NULL,
[LTPTimeID] [smallint] NOT NULL,
[LTPTime] [time] NOT NULL,
[MarketID] [smallint] NOT NULL,
[TotalSharesInIssue] [numeric] (28, 6) NOT NULL,
[IssuedSharesToday] [numeric] (28, 6) NOT NULL,
[ExDivYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[OpenPrice] [numeric] (19, 6) NOT NULL,
[LowPrice] [numeric] (19, 6) NOT NULL,
[HighPrice] [numeric] (19, 6) NOT NULL,
[BidPrice] [numeric] (19, 6) NOT NULL,
[OfferPrice] [numeric] (19, 6) NOT NULL,
[OCP] [numeric] (19, 6) NOT NULL,
[LTP] [numeric] (19, 6) NOT NULL,
[MarketCap] [numeric] (28, 6) NOT NULL,
[MarketCapEur] [numeric] (28, 6) NOT NULL,
[Turnover] [numeric] (19, 6) NOT NULL,
[TurnoverND] [numeric] (19, 6) NOT NULL,
[TurnoverEur] [numeric] (19, 6) NOT NULL,
[TurnoverNDEur] [numeric] (19, 6) NOT NULL,
[TurnoverOB] [numeric] (19, 6) NOT NULL,
[TurnoverOBEur] [numeric] (19, 6) NOT NULL,
[Volume] [bigint] NOT NULL,
[VolumeND] [bigint] NOT NULL,
[VolumeOB] [bigint] NOT NULL,
[Deals] [int] NOT NULL,
[DealsOB] [int] NOT NULL,
[DealsND] [int] NOT NULL,
[ISEQ20Shares] [numeric] (28, 6) NOT NULL,
[ISEQ20Price] [numeric] (19, 6) NOT NULL,
[ISEQ20Weighting] [numeric] (9, 6) NOT NULL,
[ISEQ20MarketCap] [numeric] (28, 6) NOT NULL,
[ISEQ20FreeFloat] [numeric] (9, 6) NOT NULL,
[ISEQOverallWeighting] [numeric] (9, 6) NOT NULL,
[ISEQOverallMarketCap] [numeric] (28, 6) NOT NULL,
[ISEQOverallBeta30] [numeric] (19, 6) NOT NULL,
[ISEQOverallBeta250] [numeric] (19, 6) NOT NULL,
[ISEQOverallFreefloat] [numeric] (9, 6) NOT NULL,
[ISEQOverallPrice] [numeric] (19, 6) NOT NULL,
[ISEQOverallShares] [numeric] (28, 6) NOT NULL,
[OverallIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[GeneralIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[FinancialIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[SmallCapIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ITEQIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ISEQ20IndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ESMIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ExCapYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ExEntitlementYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ExRightsYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ExSpecialYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [PK_FactEquitySnapshot] PRIMARY KEY CLUSTERED  ([EquitySnapshotID]) ON [PRIMARY]
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
