CREATE TABLE [DWH].[DimEquityTradeJunk]
(
[EquityTradeJunkID] [smallint] NOT NULL IDENTITY(1, 1),
[TradeSideCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeSideName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeOrderTypeCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeOrderRestrictionCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeType] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeTypeCategory] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[PrincipalAgentCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[PrincipalAgentName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[AuctionFlagCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[AuctionFlagName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeFlagCombined] [varchar] (15) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeFlagCode1] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeFlagName1] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeFlagCode2] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeFlagName2] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeFlagCode3] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeFlagName3] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeFlagCode4] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeFlagName4] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeFlagCode5] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeFlagName5] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimEquityTradeJunk] ADD CONSTRAINT [PK_DimEquityTradeJunk] PRIMARY KEY CLUSTERED  ([EquityTradeJunkID]) ON [PRIMARY]
GO
