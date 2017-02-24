CREATE TABLE [dbo].[FileList]
(
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[FileTag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[FilePrefix] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[ProcessFileYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_FileList_ProcessFileYN] DEFAULT ('N'),
[SourceFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL,
[ProcessFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL,
[ArchiveFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL,
[RejectFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL,
[DwhFileID] [int] NULL,
[Saftletter] AS (upper(substring(replace([FileName],[FilePrefix],''),(9),(1))+case  when substring(replace([FileName],[FilePrefix],''),(10),(1))='K' then 'K' else '' end))
) ON [PRIMARY]
GO
