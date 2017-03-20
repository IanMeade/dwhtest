CREATE TABLE [dbo].[TradeAggregationsFactEquityTradeSnapshot]
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
[Turnover] [numeric] (38, 6) NULL,
[TurnoverOB] [numeric] (38, 6) NULL,
[TurnoverND] [numeric] (38, 6) NULL,
[TurnoverEur] [numeric] (38, 11) NULL,
[TurnoverObEur] [numeric] (38, 11) NULL,
[TurnoverNdEur] [numeric] (38, 11) NULL
) ON [PRIMARY]
GO