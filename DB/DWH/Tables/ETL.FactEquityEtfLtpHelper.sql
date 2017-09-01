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
) ON [PRIMARY]
GO
