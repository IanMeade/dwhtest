CREATE TABLE [dbo].[FileListRawTc]
(
[FileID] [int] NOT NULL IDENTITY(1, 1),
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Populated] [datetime2] NOT NULL CONSTRAINT [DF_FileListRawTc_Populated] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileListRawTc] ADD CONSTRAINT [PK_FileListRawTc] PRIMARY KEY CLUSTERED  ([FileID]) ON [PRIMARY]
GO
