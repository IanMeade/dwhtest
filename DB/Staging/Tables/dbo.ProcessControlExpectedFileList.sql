CREATE TABLE [dbo].[ProcessControlExpectedFileList]
(
[FileLetter] [varchar] (2) COLLATE Latin1_General_CI_AS NULL,
[WarningStartTime] [time] NULL,
[ExpectedStartTime] [time] NULL,
[ProcessFileYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL,
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[WarningEndTime] [time] NULL
) ON [PRIMARY]
GO
