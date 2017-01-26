CREATE TABLE [DWH].[DimTradeModificationType]
(
[TradeModificationTypeID] [smallint] NOT NULL IDENTITY(1, 1),
[TradeModificationTypeCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TradingSysModificationTypeCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeModificationTypeName] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimTradeModificationType] ADD CONSTRAINT [PK_DimTradeModificationType] PRIMARY KEY CLUSTERED  ([TradeModificationTypeID]) ON [PRIMARY]
GO
