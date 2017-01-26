CREATE TABLE [dbo].[TradeModificationType]
(
[TradeModificationTypeCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TradingSysModificationTypeCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeModificationTypeName] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TradeModificationType] ADD CONSTRAINT [PK_TradeModificationType] PRIMARY KEY CLUSTERED  ([TradeModificationTypeCode]) ON [PRIMARY]
GO
