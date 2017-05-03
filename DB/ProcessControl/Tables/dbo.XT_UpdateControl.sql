CREATE TABLE [dbo].[XT_UpdateControl]
(
[TableName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[ExtractSequenceId] [bigint] NOT NULL,
[LastChecked] [datetime2] NULL,
[LastUpdated] [datetime2] NULL,
[LastUpdateBatchID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[XT_UpdateControl] ADD CONSTRAINT [PK_XT_UpdateControl] PRIMARY KEY CLUSTERED  ([TableName]) ON [PRIMARY]
GO
