CREATE TABLE [ETL].[ClosingPrice]
(
[AggregateDate] [date] NULL,
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL,
[PRICE_TIMESTAMP_NO] [int] NULL,
[CLOSING_AUCT_BID_PRICE] [numeric] (19, 6) NULL,
[CLOSING_AUCT_ASK_PRICE] [numeric] (19, 6) NULL,
[BidPriceVersions] [int] NULL,
[OfferPriceVersions] [int] NULL
) ON [PRIMARY]
GO
