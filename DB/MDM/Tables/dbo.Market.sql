CREATE TABLE [dbo].[Market]
(
[MarketCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[ReportingMarketCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[MarketName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[XtCode] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Market] ADD CONSTRAINT [PK_Market_1] PRIMARY KEY CLUSTERED  ([MarketCode], [XtCode]) ON [PRIMARY]
GO
