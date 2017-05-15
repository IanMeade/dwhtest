CREATE TABLE [DWH].[DimMarketAggregation]
(
[MarketAggregationID] [tinyint] NOT NULL IDENTITY(1, 1),
[MarketCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[ReportingMarketCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[MarketName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimMarketAggregation] ADD CONSTRAINT [PK_DimMarketAggregation] PRIMARY KEY CLUSTERED  ([MarketAggregationID]) ON [PRIMARY]
GO
