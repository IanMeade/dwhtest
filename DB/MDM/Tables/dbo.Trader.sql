CREATE TABLE [dbo].[Trader]
(
[TraderCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[BrokerCode] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL,
[TraderType] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Trader] ADD CONSTRAINT [PK_Trader] PRIMARY KEY CLUSTERED  ([TraderCode], [BrokerCode]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Trader] ADD CONSTRAINT [FK_Trader_Broker] FOREIGN KEY ([BrokerCode]) REFERENCES [dbo].[Broker] ([BrokerCode])
GO
ALTER TABLE [dbo].[Trader] ADD CONSTRAINT [FK_Trader_Trader] FOREIGN KEY ([TraderCode], [BrokerCode]) REFERENCES [dbo].[Trader] ([TraderCode], [BrokerCode])
GO
