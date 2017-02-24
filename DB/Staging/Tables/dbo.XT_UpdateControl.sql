CREATE TABLE [dbo].[XT_UpdateControl]
(
[TableName] [varchar] (11) COLLATE Latin1_General_CI_AS NULL,
[ExtractSequenceId] [bigint] NULL,
[LastChecked] [datetime2] NULL,
[LastUpdated] [datetime2] NULL,
[LastUpdateBatchID] [int] NULL,
[XT_ExtractSequenceId] [bigint] NULL
) ON [PRIMARY]
GO
