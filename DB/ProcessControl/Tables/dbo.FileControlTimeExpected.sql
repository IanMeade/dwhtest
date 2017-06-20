CREATE TABLE [dbo].[FileControlTimeExpected]
(
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[FileLetter] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[ExpectedStartTime] [time] NULL,
[WarningStartTime] [time] NULL,
[WarningEndTime] [time] NULL,
[ProcessFileYN] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[ContainsEndOfDayDetailsYN] [char] (1) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileControlTimeExpected] ADD CONSTRAINT [PK_FileControlTimeExpected] PRIMARY KEY CLUSTERED  ([FileTag], [FileLetter]) ON [PRIMARY]
GO
