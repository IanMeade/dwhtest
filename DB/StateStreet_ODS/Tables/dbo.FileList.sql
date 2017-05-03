CREATE TABLE [dbo].[FileList]
(
[FileID] [int] NOT NULL IDENTITY(1, 1),
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[EtlVersion] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Populated] [datetime2] NOT NULL CONSTRAINT [DF_File_Populated] DEFAULT (getdate()),
[DwhStatus] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileList] ADD CONSTRAINT [PK_FileList] PRIMARY KEY CLUSTERED  ([FileID]) ON [PRIMARY]
GO
