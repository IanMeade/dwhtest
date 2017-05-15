CREATE TABLE [dbo].[ProcessStatusControl]
(
[ProcessStatusControlID] [int] NOT NULL IDENTITY(1, 1),
[MessageTag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[Message] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL,
[SendToOracle] [bit] NOT NULL CONSTRAINT [DF_ProcessStatusControl_SendToOracle] DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
