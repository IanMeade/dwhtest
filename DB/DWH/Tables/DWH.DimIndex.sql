CREATE TABLE [DWH].[DimIndex]
(
[IndexID] [smallint] NOT NULL IDENTITY(1, 1),
[IndexCode] [char] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[IndexName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[ISIN] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL,
[SEDOL] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[ReturnISIN] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL,
[ReturnSEDOL] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimIndex] ADD CONSTRAINT [PK_DimIndex] PRIMARY KEY CLUSTERED  ([IndexID]) ON [PRIMARY]
GO
