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
ALTER TABLE [DWH].[FactEtfTrade] ADD CONSTRAINT [PK_FactEtfTrade] PRIMARY KEY CLUSTERED  ([EtfTradeID]) ON [PRIMARY]
GO
