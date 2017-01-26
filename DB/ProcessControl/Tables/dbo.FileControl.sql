CREATE TABLE [dbo].[FileControl]
(
[FileControlID] [int] NOT NULL IDENTITY(1, 1),
[SourceSystemID] [int] NOT NULL,
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[FileTag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[FileNameMask] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[FilePrefix] [varchar] (20) COLLATE Latin1_General_CI_AS NULL,
[SourceFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL,
[ProcessFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL,
[ArchiveFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL,
[RejectFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileControl] ADD CONSTRAINT [PK_FileControl] PRIMARY KEY CLUSTERED  ([FileControlID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_FileControl] ON [dbo].[FileControl] ([FileTag]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileControl] ADD CONSTRAINT [FK_FileControl_SourceSystem] FOREIGN KEY ([SourceSystemID]) REFERENCES [dbo].[SourceSystem] ([SourceSystemID])
GO
