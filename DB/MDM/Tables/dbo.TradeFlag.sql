CREATE TABLE [dbo].[TradeFlag]
(
[TradeFlagCode] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeFlagName] [char] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[DefaultValue] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TradeFlag] ADD CONSTRAINT [PK_TradeFlag] PRIMARY KEY CLUSTERED  ([TradeFlagCode]) ON [PRIMARY]
GO
