CREATE TABLE [dbo].[EmailMessageControl]
(
[MessageID] [smallint] NOT NULL IDENTITY(1, 1),
[MessageTag] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[MessageTo] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[MessageCC] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[MessageSubject] [varchar] (2000) COLLATE Latin1_General_CI_AS NULL,
[MessageBody] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[MessagePriority] [int] NULL,
[MessageEnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailMessageControl] ADD CONSTRAINT [PK_EmailMessageControl] PRIMARY KEY CLUSTERED  ([MessageID]) ON [PRIMARY]
GO
