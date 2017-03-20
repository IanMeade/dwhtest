CREATE TABLE [dbo].[FileControlT7]
(
[FileLetter] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[ExpectedStartTime] [time] NULL,
[ExpectedFinishTime] [time] NULL,
[ProcessFileYN] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[ContainsEndOfDayDetailsYN] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[ReprocessDelayMinutes] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileControlT7] ADD CONSTRAINT [PK_FileControlT7] PRIMARY KEY CLUSTERED  ([FileLetter]) ON [PRIMARY]
GO
