CREATE TABLE [DWH].[DimIndexType]
(
[IndexTypeID] [smallint] NOT NULL IDENTITY(1, 1),
[IndexCode] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[IndexName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[SEDOL] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL,
[ReturnISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[ReturnSEDOL] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimIndexType] ADD CONSTRAINT [PK_DimIndex] PRIMARY KEY CLUSTERED  ([IndexTypeID]) ON [PRIMARY]
GO
