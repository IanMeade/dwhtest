CREATE TABLE [dbo].[Market]
(
[MarketCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[MarketName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[XtCode] [varchar] (20) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Market] ADD CONSTRAINT [PK_Market_1] PRIMARY KEY CLUSTERED  ([MarketCode]) ON [PRIMARY]
GO
