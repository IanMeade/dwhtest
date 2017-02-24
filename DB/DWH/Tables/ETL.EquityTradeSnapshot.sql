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
) ON [PRIMARY]
GO
