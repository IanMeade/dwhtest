CREATE TABLE [dbo].[ErrorLog]
(
[ErrorID] [int] NOT NULL IDENTITY(1, 1),
[BatchID] [int] NOT NULL,
[ErrorDateTime] [datetime2] NOT NULL CONSTRAINT [DF_ErrorLog_ErrorDateTime] DEFAULT (getdate()),
[ErrorCode] [int] NOT NULL,
[ErrorDescription] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL,
[SourceDescription] [varchar] (max) COLLATE Latin1_General_CI_AS NULL,
[SourceID] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL,
[SourceName] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL,
[SourceParentGUID] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ErrorLog] ADD CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED  ([ErrorID]) ON [PRIMARY]
GO
