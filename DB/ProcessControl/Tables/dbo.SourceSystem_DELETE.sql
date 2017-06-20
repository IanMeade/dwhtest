CREATE TABLE [dbo].[SourceSystem_DELETE]
(
[SourceSystemID] [int] NOT NULL IDENTITY(1, 1),
[SourceSystemName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[SourceSystemTag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[ConnectionString] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL,
[EnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[CutOffMechanismTag] [varchar] (20) COLLATE Latin1_General_CI_AS NULL,
[CutOffChar] [varchar] (100) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SourceSystem_DELETE] ADD CONSTRAINT [PK_SourceSystem] PRIMARY KEY CLUSTERED  ([SourceSystemID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SourceSystem_DELETE] ADD CONSTRAINT [IX_SourceSystem] UNIQUE NONCLUSTERED  ([SourceSystemTag]) ON [PRIMARY]
GO
