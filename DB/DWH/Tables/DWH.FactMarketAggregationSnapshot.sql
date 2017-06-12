CREATE TABLE [DWH].[FactMarketAggregationSnapshot]
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
ALTER TABLE [DWH].[FactMarketAggregationSnapshot] ADD CONSTRAINT [PK_FactMarketAggregation_1] PRIMARY KEY CLUSTERED  ([DateID], [MarketAggregationID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FactMarketAggregation] ON [DWH].[FactMarketAggregationSnapshot] ([DateID], [MarketAggregationID]) ON [PRIMARY]
GO
