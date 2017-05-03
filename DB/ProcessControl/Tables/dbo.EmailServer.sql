CREATE TABLE [dbo].[EmailServer]
(
[SmptServerAddress] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[SentFromMessageBox] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[EnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailServer] ADD CONSTRAINT [PK_EmailServer] PRIMARY KEY CLUSTERED  ([SmptServerAddress]) ON [PRIMARY]
GO
