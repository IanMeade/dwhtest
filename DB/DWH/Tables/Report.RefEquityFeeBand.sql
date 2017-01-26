CREATE TABLE [Report].[RefEquityFeeBand]
(
[FeeBandID] [smallint] NOT NULL IDENTITY(1, 1),
[FeeBandName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Min] [int] NOT NULL,
[Max] [int] NOT NULL,
[Fee] [numeric] (9, 6) NOT NULL,
[FeeType] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Report].[RefEquityFeeBand] ADD CONSTRAINT [PK_RefEquityFeeBand] PRIMARY KEY CLUSTERED  ([FeeBandID]) ON [PRIMARY]
GO
