CREATE TABLE [ETL].[FactEquityIndexPrep]
(
[IndexDateID] [int] NOT NULL,
[IndexCode] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[OpenValue] [numeric] (8, 3) NOT NULL,
[LastValue] [numeric] (8, 3) NOT NULL,
[ReturnValue] [numeric] (8, 3) NULL,
[DailyLowValue] [numeric] (8, 3) NULL,
[DailyHighValue] [numeric] (8, 3) NULL
) ON [PRIMARY]
GO
