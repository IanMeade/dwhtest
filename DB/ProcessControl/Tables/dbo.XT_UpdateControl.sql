CREATE TABLE [dbo].[XT_UpdateControl]
(
[TableName] [varchar] (11) COLLATE Latin1_General_CI_AS NOT NULL,
[ExtractSequenceId] [bigint] NOT NULL,
[LastChecked] [datetime2] NOT NULL,
[LastUpdated] [datetime2] NOT NULL,
[LastUpdateBatchID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[XT_UpdateControl] ADD CONSTRAINT [PK_XT_UpdateControl] PRIMARY KEY CLUSTERED  ([TableName]) ON [PRIMARY]
GO
