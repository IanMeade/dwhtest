CREATE TABLE [dbo].[ProcessStatus]
(
[ProcessStatusID] [int] NOT NULL IDENTITY(1, 1),
[MessageDateTime] [datetime2] NOT NULL CONSTRAINT [DF_ProcessStatus_MessageDateTime] DEFAULT (getdate()),
[Message] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProcessStatus] ADD CONSTRAINT [PK_ProcessStatus] PRIMARY KEY CLUSTERED  ([ProcessStatusID]) ON [PRIMARY]
GO
