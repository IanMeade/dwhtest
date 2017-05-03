CREATE TABLE [dbo].[ProcessStatus]
(
[ProcessStatusID] [int] NOT NULL IDENTITY(1, 1),
[BatchID] [int] NOT NULL,
[Message] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL,
[MessageDateTime] [datetime2] NOT NULL CONSTRAINT [DF_ProcessStatus_MessageDateTime] DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProcessStatus] ADD CONSTRAINT [PK_ProcessStatus] PRIMARY KEY CLUSTERED  ([ProcessStatusID]) ON [PRIMARY]
GO
