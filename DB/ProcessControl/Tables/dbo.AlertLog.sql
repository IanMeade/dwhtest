CREATE TABLE [dbo].[AlertLog]
(
[AlertID] [int] NOT NULL IDENTITY(1, 1),
[BatchID] [int] NULL,
[MessageTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[AlertDateTime] [datetime2] NOT NULL CONSTRAINT [DF_AlertLog_AlertDateTime] DEFAULT (getdate()),
[Message1] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL,
[Message2] [varchar] (max) COLLATE Latin1_General_CI_AS NULL,
[Message3] [varchar] (max) COLLATE Latin1_General_CI_AS NULL,
[Message4] [varchar] (max) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[AlertLog] ADD CONSTRAINT [PK_AlertLog] PRIMARY KEY CLUSTERED  ([AlertID]) ON [PRIMARY]
GO
