CREATE TABLE [dbo].[Index]
(
[IndexCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[IndexName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[ISIN] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL,
[SEDOL] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[ReturnISIN] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL,
[ReturnSEDOL] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Index] ADD CONSTRAINT [PK_Index] PRIMARY KEY CLUSTERED  ([IndexCode]) ON [PRIMARY]
GO
