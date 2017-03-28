CREATE TABLE [dbo].[DwhDimMarket]
(
[MarketID] [smallint] NOT NULL,
[MarketCode] [varchar] (15) COLLATE Latin1_General_CI_AS NOT NULL,
[MarketName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
