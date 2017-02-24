CREATE TABLE [ETL].[BidOfferPrice]
(
[AggregateDate] [date] NULL,
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL,
[PRICE_TIMESTAMP_NO] [int] NULL,
[BEST_BID_PRICE] [numeric] (19, 6) NULL,
[BEST_ASK_PRICE] [numeric] (19, 6) NULL,
[BidPriceVersions] [int] NULL,
[OfferPriceVersions] [int] NULL
) ON [PRIMARY]
GO
