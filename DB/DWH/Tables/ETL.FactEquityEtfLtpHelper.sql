CREATE TABLE [ETL].[FactEquityEtfLtpHelper]
(
[AggregationDateID] [int] NULL,
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeDateID] [int] NOT NULL,
[TradeTimeID] [smallint] NOT NULL,
[TradeTimestamp] [time] NOT NULL,
[UTCTradeTimeStamp] [time] NOT NULL,
[TradePrice] [numeric] (19, 6) NOT NULL,
[LTPDateTime] [datetime2] NULL,
[PublishedDateTime] [datetime2] NULL
) ON [PRIMARY]
GO
