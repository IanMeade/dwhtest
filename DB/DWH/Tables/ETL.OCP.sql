CREATE TABLE [ETL].[OCP]
(
[AggregateDate] [date] NOT NULL,
[A_ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[A_OFFICIAL_CLOSING_PRICE] [numeric] (19, 6) NOT NULL,
[A_TRADE_TIME_OCP] [datetime] NOT NULL,
[A_TRADE_TIME_OCP_GMT] [datetime] NOT NULL,
[PriceVersions] [int] NOT NULL,
[TimeVersions] [int] NOT NULL
) ON [PRIMARY]
GO
