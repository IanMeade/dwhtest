CREATE TABLE [dbo].[ODS_FileList]
(
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Populated] [datetime2] NOT NULL
) ON [PRIMARY]
GO
