CREATE TABLE [DWH].[DimFile]
(
[FileID] [int] NOT NULL IDENTITY(1, 1),
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[FileType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[FileTypeTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[SaftFileLetter] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[FileProcessedTime] [datetime2] NOT NULL,
[FilePrcocessedStatus] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimFile] ADD CONSTRAINT [PK_DimFile] PRIMARY KEY CLUSTERED  ([FileID]) ON [PRIMARY]
GO
