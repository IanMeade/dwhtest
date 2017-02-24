CREATE TABLE [dbo].[AggregationRebuildManualList]
(
[AggregationDateID] [int] NOT NULL,
[ProcessedAttempted] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_AggregationRebuildManualList_ProcessedAttempted] DEFAULT ('N'),
[ProcessedSucceeded] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[AggregationLogged] [datetime2] NOT NULL CONSTRAINT [DF_AggregationRebuildManualList_AggregationLogged] DEFAULT (getdate()),
[AggregationProcessed] [datetime2] NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY]
GO
