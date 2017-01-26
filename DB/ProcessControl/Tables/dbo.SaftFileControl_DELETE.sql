CREATE TABLE [dbo].[SaftFileControl_DELETE]
(
[SaftFileControlID] [int] NOT NULL IDENTITY(1, 1),
[FileType] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[FileNameMask] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[SourceFolder] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[ProcessFolder] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[ArchiveFolder] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[ProcessRuleTag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SaftFileControl_DELETE] ADD CONSTRAINT [PK_SaftFileControl] PRIMARY KEY CLUSTERED  ([SaftFileControlID]) ON [PRIMARY]
GO
