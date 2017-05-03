CREATE TABLE [dbo].[STATS]
(
[FileID] [int] NOT NULL,
[ISIN] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[VolatilityPercentage30Days] [numeric] (6, 2) NULL,
[Correlation30Days] [numeric] (6, 2) NULL,
[Beta30Days] [numeric] (6, 4) NULL,
[Beta250Days] [numeric] (6, 4) NULL,
[ClosingPriceValue] [numeric] (10, 4) NULL,
[Fi] [numeric] (12, 6) NULL,
[WeightPercentage] [numeric] (6, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[STATS] ADD CONSTRAINT [PK_STATS] PRIMARY KEY CLUSTERED  ([FileID], [ISIN]) ON [PRIMARY]
GO
