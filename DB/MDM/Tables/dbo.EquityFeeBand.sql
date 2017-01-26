CREATE TABLE [dbo].[EquityFeeBand]
(
[FeeBandName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Min] [int] NOT NULL,
[Max] [int] NOT NULL,
[Fee] [numeric] (9, 6) NOT NULL,
[FeeType] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EquityFeeBand] ADD CONSTRAINT [PK_EquityFeeBand] PRIMARY KEY CLUSTERED  ([FeeBandName]) ON [PRIMARY]
GO
