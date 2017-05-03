CREATE TABLE [dbo].[ISEQ20_DAILY_HOLDINGS]
(
[FileID] [int] NOT NULL,
[ISIN_ETF] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[ISIN] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[NAME] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[ColumnF] [int] NULL,
[ColumnG] [real] NULL,
[ColumnH] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[SharePercentage] [varchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ISEQ20_DAILY_HOLDINGS] ADD CONSTRAINT [PK_ISEQ20_DAILY_HOLDINGS] PRIMARY KEY CLUSTERED  ([FileID], [ISIN]) ON [PRIMARY]
GO
