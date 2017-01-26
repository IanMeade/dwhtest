CREATE TABLE [dbo].[AggregationRebuild]
(
[RebuildDateID] [int] NOT NULL,
[ProcessYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AggregationRebuild] ADD CONSTRAINT [PK_AggregationRebuild] PRIMARY KEY CLUSTERED  ([RebuildDateID]) ON [PRIMARY]
GO
