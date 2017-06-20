CREATE TABLE [dbo].[ProcessMessage]
(
[MessageID] [int] NOT NULL IDENTITY(1, 1),
[ProcessStatusID] [int] NULL,
[MessageDateTime] [datetime2] NOT NULL CONSTRAINT [DF_ProcessMessage_MessageDateTime] DEFAULT (getdate()),
[MessageDate] AS (CONVERT([date],[MessageDateTime],(0))) PERSISTED,
[Message] [varchar] (max) COLLATE Latin1_General_CI_AS NULL,
[BatchID] [int] NULL,
[Context] [varchar] (max) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProcessMessage] ADD CONSTRAINT [PK_ProcessMessage] PRIMARY KEY CLUSTERED  ([MessageID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ProcessMessage_BatchID] ON [dbo].[ProcessMessage] ([BatchID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ProcessMessage] ON [dbo].[ProcessMessage] ([MessageDate]) ON [PRIMARY]
GO
