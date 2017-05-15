CREATE TABLE [DWH].[FactMarketAggregation]
(
[DateID] [int] NOT NULL,
[MarketAggregationID] [tinyint] NOT NULL,
[TurnoverEur] [numeric] (19, 6) NOT NULL,
[Volume] [bigint] NOT NULL,
[TurnoverEurConditional] [numeric] (19, 6) NOT NULL,
[VolumeConditional] [bigint] NOT NULL,
[BatchID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactMarketAggregation] ADD CONSTRAINT [PK_FactMarketAggregation_1] PRIMARY KEY CLUSTERED  ([DateID], [MarketAggregationID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FactMarketAggregation] ON [DWH].[FactMarketAggregation] ([DateID], [MarketAggregationID]) ON [PRIMARY]
GO
