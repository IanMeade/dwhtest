CREATE TABLE [ETL].[OOP]
(
[AggregateDate] [date] NOT NULL,
[A_ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[A_OFFICIAL_OPENING_PRICE] [numeric] (19, 6) NOT NULL,
[PriceVersions] [int] NOT NULL
) ON [PRIMARY]
GO
