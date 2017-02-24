CREATE TABLE [dbo].[AggregationRebuildSystemList]
(
[AggregationDateID] [int] NOT NULL,
[ProcessedAttempted] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_AggregationRebuildSystemList_ProcessedAttempted] DEFAULT ('N'),
[ProcessedSucceeded] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[AggregationLogged] [datetime2] NOT NULL CONSTRAINT [DF_AggregationRebuildSystemList_AggregationLogged] DEFAULT (getdate()),
[AggregationProcessed] [datetime2] NULL,
[InsertedBatchID] [int] NOT NULL,
[ProcessedBatchID] [int] NULL
) ON [PRIMARY]
GO
