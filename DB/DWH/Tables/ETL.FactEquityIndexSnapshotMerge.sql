CREATE TABLE [ETL].[FactEquityIndexSnapshotMerge]
(
[IndexDateID] [int] NULL,
[IndexCode] [varchar] (15) COLLATE Latin1_General_CI_AS NULL,
[OpenValue] [numeric] (8, 3) NULL,
[LastValue] [numeric] (8, 3) NULL,
[ReturnValue] [numeric] (8, 3) NULL,
[DailyLowValue] [numeric] (8, 3) NULL,
[DailyHighValue] [numeric] (8, 3) NULL,
[IndexTypeID] [smallint] NULL,
[InterestRate] [numeric] (5, 2) NULL,
[MarketCap] [numeric] (38, 6) NULL
) ON [PRIMARY]
GO
