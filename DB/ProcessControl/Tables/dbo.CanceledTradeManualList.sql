CREATE TABLE [dbo].[CanceledTradeManualList]
(
[TradeDateID] [int] NOT NULL,
[TradingSysTransNo] [int] NOT NULL,
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeTypeCategory] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[BrokerCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[ProcessedAttempted] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ProcessedSucceeded] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[CancelationLogged] [datetime2] NOT NULL CONSTRAINT [DF_CanceledTradeManualList_CancelationLogged] DEFAULT (getdate()),
[CancelationProcessed] [datetime2] NULL,
[BatchID] [int] NULL
) ON [PRIMARY]
GO
