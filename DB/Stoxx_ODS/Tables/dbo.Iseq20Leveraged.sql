CREATE TABLE [dbo].[Iseq20Leveraged]
(
[FileID] [int] NOT NULL,
[TRADE_DATE] [date] NULL,
[Eonia] [numeric] (5, 2) NULL,
[ISEQ 20 RETURN INDEX] [numeric] (12, 2) NULL,
[ISEQ 20 PRICE INDEX] [numeric] (12, 2) NULL,
[ISEQ LEVERAGED INDEX] [numeric] (12, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Iseq20Leveraged] ADD CONSTRAINT [PK_Iseq20Leveraged] PRIMARY KEY CLUSTERED  ([FileID]) ON [PRIMARY]
GO
