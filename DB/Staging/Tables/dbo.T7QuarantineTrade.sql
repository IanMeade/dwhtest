CREATE TABLE [dbo].[T7QuarantineTrade]
(
[TradeDateID] [int] NOT NULL,
[TradingSysTransNo] [int] NOT NULL,
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeTypeCategory] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[Code] [int] NOT NULL,
[Message] [varchar] (265) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
