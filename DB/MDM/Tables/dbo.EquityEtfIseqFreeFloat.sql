CREATE TABLE [dbo].[EquityEtfIseqFreeFloat]
(
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[ISEQOverallFreeFloat] [numeric] (19, 6) NOT NULL,
[ISEQ20Freefloat] [numeric] (19, 6) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EquityEtfIseqFreeFloat] ADD CONSTRAINT [PK_EquityEtfIseqFreeFloat] PRIMARY KEY CLUSTERED  ([ISIN]) ON [PRIMARY]
GO
