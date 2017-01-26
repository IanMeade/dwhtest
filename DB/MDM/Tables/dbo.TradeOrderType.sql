CREATE TABLE [dbo].[TradeOrderType]
(
[TradeOrderTypeCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeOrderRestrictionCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeType] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeTypeCategory] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[DefaultValueYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TradeOrderType] ADD CONSTRAINT [PK_TradeType] PRIMARY KEY CLUSTERED  ([TradeOrderTypeCode], [TradeOrderRestrictionCode]) ON [PRIMARY]
GO
