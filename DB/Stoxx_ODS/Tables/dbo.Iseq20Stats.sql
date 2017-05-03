CREATE TABLE [dbo].[Iseq20Stats]
(
[FileID] [int] NOT NULL,
[Nr] [smallint] NULL,
[Code] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Share] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Isin] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[pi0] [numeric] (6, 2) NULL,
[pit] [numeric] (9, 4) NULL,
[ciPerf] [numeric] (12, 6) NULL,
[ciPrice] [numeric] (12, 6) NULL,
[qi0] [numeric] (16, 0) NULL,
[qit] [numeric] (16, 0) NULL,
[ffit] [numeric] (9, 4) NULL,
[MarketCap] [numeric] (16, 2) NULL,
[Fi] [numeric] (12, 6) NULL,
[Weight] [numeric] (12, 4) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Iseq20Stats] ADD CONSTRAINT [PK_Iseq20Stats] PRIMARY KEY CLUSTERED  ([FileID], [Isin]) ON [PRIMARY]
GO
