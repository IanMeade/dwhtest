CREATE TABLE [DWH].[DimCorporateActionType]
(
[CorporateActionTypeID] [smallint] NOT NULL IDENTITY(1, 1),
[CorporateActionCode] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[CoporateActionName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[CorporateActionSubType] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL,
[CorporateActionStatusCode] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[CorporateActionStatusName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimCorporateActionType] ADD CONSTRAINT [PK_DimCorporateActionType] PRIMARY KEY CLUSTERED  ([CorporateActionTypeID]) ON [PRIMARY]
GO
