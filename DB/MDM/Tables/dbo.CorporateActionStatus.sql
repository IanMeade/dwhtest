CREATE TABLE [dbo].[CorporateActionStatus]
(
[CorporateActionStatusCode] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[CorporateActionStatusName] [varchar] (30) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CorporateActionStatus] ADD CONSTRAINT [PK_CorporateActionStatus] PRIMARY KEY CLUSTERED  ([CorporateActionStatusCode]) ON [PRIMARY]
GO
