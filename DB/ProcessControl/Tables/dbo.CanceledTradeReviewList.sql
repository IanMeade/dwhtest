CREATE TABLE [dbo].[CanceledTradeReviewList]
(
[TradeDateID] [int] NOT NULL,
[TradingSysTransNo] [int] NOT NULL,
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeVolume] [numeric] (19, 6) NOT NULL,
[TradePrice] [numeric] (19, 6) NOT NULL,
[BrokerCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[TraderCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[Reviewed] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_CanceledTradeReviewList_Reviewed] DEFAULT ('N'),
[Approved] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_CanceledTradeReviewList_Approved] DEFAULT ('N'),
[Processed] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_CanceledTradeReviewList_Processed] DEFAULT ('N'),
[DwhFileID] [int] NOT NULL,
[CancelationLogged] [datetime2] NOT NULL CONSTRAINT [DF_CanceledTradeReviewList_CancelationLogged] DEFAULT (getdate()),
[CancelationProcessed] [datetime2] NULL,
[BatchID] [int] NULL
) ON [PRIMARY]
GO
