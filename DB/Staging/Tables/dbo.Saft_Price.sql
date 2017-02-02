CREATE TABLE [dbo].[Saft_Price]
(
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[DwhFileID] [int] NULL,
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL,
[CURRENCY] [varchar] (3) COLLATE Latin1_General_CI_AS NULL,
[PRICE_TIMESTAMP] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[PRICE_TIMESTAMP_NO] [int] NULL,
[MOD_TIMESTAMP] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[PRICE_DATE] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[MARKET_PRICE_TYPE] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[BEST_BID_PRICE] [decimal] (19, 6) NULL,
[BEST_ASK_PRICE] [decimal] (19, 6) NULL,
[CLOSING_AUCT_BID_PRICE] [decimal] (19, 6) NULL,
[CLOSING_AUCT_ASK_PRICE] [decimal] (19, 6) NULL,
[INSERT_DATE] [varchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
