CREATE TABLE [DWH].[DimMarket]
(
[MarketID] [smallint] NOT NULL IDENTITY(1, 1),
[MarketCode] [varchar] (15) COLLATE Latin1_General_CI_AS NOT NULL,
[MarketName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimMarket] ADD CONSTRAINT [PK_DimMarket] PRIMARY KEY CLUSTERED  ([MarketID]) ON [PRIMARY]
GO
