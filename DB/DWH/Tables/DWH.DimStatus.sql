CREATE TABLE [DWH].[DimStatus]
(
[StatusID] [smallint] NOT NULL IDENTITY(1, 1),
[StatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[ConditionalTradingYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimStatus] ADD CONSTRAINT [PK_DimStatus] PRIMARY KEY CLUSTERED  ([StatusID]) ON [PRIMARY]
GO
