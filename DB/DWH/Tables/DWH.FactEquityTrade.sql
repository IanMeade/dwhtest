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
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
ALTER TABLE [DWH].[FactEquityTrade] ADD CONSTRAINT [PK_FactEquityTrade] PRIMARY KEY NONCLUSTERED  ([EquityTradeID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED COLUMNSTORE INDEX [FactEquityTradeNonClusteredColumnStoreIndex] ON [DWH].[FactEquityTrade] ([EquityTradeID], [InstrumentID], [TradingSysTransNo], [TradeDateID], [TradeTimeID], [TradeTimestamp], [UTCTradeTimeStamp], [PublishDateID], [PublishTimeID], [PublishedDateTime], [UTCPublishedDateTime], [DelayedTradeYN], [EquityTradeJunkID], [BrokerID], [TraderID], [CurrencyID], [TradePrice], [BidPrice], [OfferPrice], [TradeVolume], [TradeTurnover], [TradeModificationTypeID], [TradeCancelled], [InColumnStore], [TradeFileID], [BatchID], [CancelBatchID]) WHERE ([TradeDateID]<=(20170515)) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [FactEquityTradeLtpHelper] ON [DWH].[FactEquityTrade] ([InstrumentID], [PublishedDateTime], [TradeCancelled], [TradeDateID]) INCLUDE ([DelayedTradeYN], [EquityTradeID], [PublishDateID]) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_FactEquityTradeClustered] ON [DWH].[FactEquityTrade] ([TradeDateID], [TradingSysTransNo], [EquityTradeJunkID], [EquityTradeID]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
