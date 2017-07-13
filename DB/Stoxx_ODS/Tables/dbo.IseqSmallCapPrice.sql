CREATE TABLE [dbo].[IseqSmallCapPrice]
(
[Date] [date] NULL,
[TradingSymbol] [varchar] (14) COLLATE Latin1_General_CI_AS NULL,
[Index] [varchar] (5) COLLATE Latin1_General_CI_AS NULL,
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL,
[MarketCap] [numeric] (26, 2) NULL,
[Kt] [numeric] (16, 8) NULL,
[Constituents] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[ConstantA] [varchar] (10) COLLATE Latin1_General_CI_AS NULL,
[Value] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[ReportingTradingSymbol] [varchar] (23) COLLATE Latin1_General_CI_AS NULL,
[ReportingInstrument] [varchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Isin2] [varchar] (12) COLLATE Latin1_General_CI_AS NULL,
[Sector] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[pi0] [numeric] (16, 8) NULL,
[pit] [numeric] (16, 8) NULL,
[qi0] [bigint] NULL,
[qit] [bigint] NULL,
[ffit] [numeric] (16, 8) NULL,
[ci] [numeric] (16, 8) NULL,
[MarketCapInMillions] [numeric] (16, 2) NULL,
[Fi] [numeric] (16, 8) NULL,
[Weight] [numeric] (16, 8) NULL,
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[FileID] [int] NULL
) ON [PRIMARY]
GO
