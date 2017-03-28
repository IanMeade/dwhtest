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
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [PK_FactEtfTrade] PRIMARY KEY CLUSTERED  ([EtfTradeID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FactEtfTrade_DuplicateCheck] ON [DWH].[FactEtfTrade] ([TradeDateID], [TradingSysTransNo]) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimEtfTradeJunk] FOREIGN KEY ([EquityTradeJunkID]) REFERENCES [DWH].[DimEquityTradeJunk] ([EquityTradeJunkID])
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
