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
[TradeFileID] [int] NULL,
[BatchID] [int] NULL,
[CancelBatchID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [PK_FactEquityTrade] PRIMARY KEY CLUSTERED  ([EquityTradeID]) ON [PRIMARY]
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
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimTime1] FOREIGN KEY ([TradeTimeID]) REFERENCES [DWH].[DimTime] ([TimeID])
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimTradeModificationType] FOREIGN KEY ([TradeModificationTypeID]) REFERENCES [DWH].[DimTradeModificationType] ([TradeModificationTypeID])
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [FK_FactEquityTrade_DimTrader] FOREIGN KEY ([TraderID]) REFERENCES [DWH].[DimTrader] ([TraderID])
GO
