CREATE TABLE [dbo].[ValidationLogMessage]
(
[ValidationLogMessageID] [int] NOT NULL IDENTITY(1, 1),
[ValidationLogID] [int] NOT NULL,
[ErrorCode] [int] NOT NULL,
[Message] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ValidationLogMessage] ADD CONSTRAINT [PK_ValidationLogMessage] PRIMARY KEY CLUSTERED  ([ValidationLogMessageID]) ON [PRIMARY]
GO
