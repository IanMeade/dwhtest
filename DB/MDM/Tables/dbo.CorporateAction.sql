CREATE TABLE [dbo].[CorporateAction]
(
[CorporateActionCode] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[CorporateActionName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[Dividend] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CorporateAction] ADD CONSTRAINT [PK_CorporateAction] PRIMARY KEY CLUSTERED  ([CorporateActionCode]) ON [PRIMARY]
GO
