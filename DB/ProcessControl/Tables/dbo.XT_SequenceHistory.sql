CREATE TABLE [dbo].[XT_SequenceHistory]
(
[BatchID] [int] NOT NULL,
[DateInserted] [datetime2] NOT NULL CONSTRAINT [DF_XT_SequenceHistory_DateInserted] DEFAULT (getdate()),
[TableName] [varchar] (11) COLLATE Latin1_General_CI_AS NOT NULL,
[ExtractSequenceId] [bigint] NOT NULL,
[XT_ExtractSequenceId] [bigint] NOT NULL
) ON [PRIMARY]
GO
