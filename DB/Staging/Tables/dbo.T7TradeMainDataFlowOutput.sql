CREATE TABLE [dbo].[T7TradeMainDataFlowOutput]
(
[A_BUY_SELL_FLAG] [varchar] (1) COLLATE Latin1_General_CI_AS NULL,
[A_ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL,
[A_PRICE_CURRENCY] [varchar] (3) COLLATE Latin1_General_CI_AS NULL,
[A_AUCTION_TRADE_FLAG] [varchar] (2) COLLATE Latin1_General_CI_AS NULL,
[A_MEMBER_ID] [varchar] (10) COLLATE Latin1_General_CI_AS NULL,
[A_ACCOUNT_TYPE] [varchar] (3) COLLATE Latin1_General_CI_AS NULL,
[A_ORDER_TYPE] [varchar] (3) COLLATE Latin1_General_CI_AS NULL,
[A_ORDER_RESTRICTION] [varchar] (1) COLLATE Latin1_General_CI_AS NULL,
[A_MOD_REASON_CODE] [varchar] (3) COLLATE Latin1_General_CI_AS NULL,
[A_OTC_TRADE_FLAG_1] [varchar] (3) COLLATE Latin1_General_CI_AS NULL,
[A_OTC_TRADE_FLAG_2] [varchar] (3) COLLATE Latin1_General_CI_AS NULL,
[A_OTC_TRADE_FLAG_3] [varchar] (3) COLLATE Latin1_General_CI_AS NULL,
[A_TRADER_ID] [varchar] (10) COLLATE Latin1_General_CI_AS NULL,
[TradeDateID] [int] NULL,
[TradeTimeID] [smallint] NULL,
[TradeTimestamp] [time] NULL,
[UTCTradeTimeStamp] [time] NULL,
[PublishDateID] [int] NULL,
[PublishTimeID] [smallint] NULL,
[TradingSysTransNo] [int] NULL,
[TradePrice] [numeric] (19, 6) NULL,
[BidPrice] [numeric] (19, 6) NULL,
[OfferPrice] [numeric] (19, 6) NULL,
[TradeVolume] [numeric] (19, 6) NULL,
[TradeTurnover] [numeric] (19, 6) NULL,
[DelayedTradeYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL,
[DwhFileID] [int] NULL,
[EquityTradeJunkID] [smallint] NULL,
[InstrumentID] [int] NULL,
[InstrumentType] [varchar] (12) COLLATE Latin1_General_CI_AS NULL,
[BrokerID] [smallint] NULL,
[TraderID] [smallint] NULL,
[CurrencyID] [smallint] NULL,
[TradeModificationTypeID] [smallint] NULL,
[BatchID] [int] NULL,
[CancelBatchID] [int] NULL
) ON [PRIMARY]
GO