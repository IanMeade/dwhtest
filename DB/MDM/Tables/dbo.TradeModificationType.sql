CREATE TABLE [dbo].[TradeModificationType]
(
[TradingSysModificationTypeCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeModificationTypeName] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[CancelTradeYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TradeModificationType] ADD CONSTRAINT [PK_TradeModificationType_1] PRIMARY KEY CLUSTERED  ([TradingSysModificationTypeCode]) ON [PRIMARY]
GO
