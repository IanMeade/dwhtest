CREATE TABLE [dbo].[FileList]
(
[DwhFileID] [int] NOT NULL,
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[EtlVersion] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Populated] [datetime2] NOT NULL CONSTRAINT [DF_File_Populated] DEFAULT (getdate()),
[DwhStatus] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[FileLetter] [char] (2) COLLATE Latin1_General_CI_AS NULL,
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[ProcessFileYN] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[ContainsEndOfDayDetailsYN] [char] (1) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileList] ADD CONSTRAINT [PK_File] PRIMARY KEY CLUSTERED  ([DwhFileID]) ON [PRIMARY]
GO
