CREATE TABLE [dbo].[AggregationLog]
(
[AggregationLogID] [int] NOT NULL,
[BatchID] [int] NOT NULL,
[AggregationRuleID] [smallint] NOT NULL,
[AggregationDateID] [int] NOT NULL,
[ProcessedDate] [datetime2] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AggregationLog] ADD CONSTRAINT [PK_AggregationLog] PRIMARY KEY CLUSTERED  ([AggregationLogID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AggregationLog] ADD CONSTRAINT [FK_AggregationLog_AggregationRule] FOREIGN KEY ([AggregationRuleID]) REFERENCES [dbo].[AggregationRule] ([AggregationRuleID])
GO
