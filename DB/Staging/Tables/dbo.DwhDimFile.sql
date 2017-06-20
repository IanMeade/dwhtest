CREATE TABLE [dbo].[DwhDimFile]
(
[FileID] [int] NOT NULL,
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[FileType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[FileTypeTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[SaftFileLetter] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[ExpectedTimeID] [smallint] NULL,
[FileProcessedTime] [datetime2] NOT NULL,
[FileProcessedStatus] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[ExpectedStartTime] [time] NULL,
[ContainsEndOfDayDetails] [char] (1) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DwhDimFile] ADD CONSTRAINT [PK_DimFile] PRIMARY KEY CLUSTERED  ([FileID]) ON [PRIMARY]
GO
