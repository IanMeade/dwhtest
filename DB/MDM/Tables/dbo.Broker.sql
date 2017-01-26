CREATE TABLE [dbo].[Broker]
(
[BrokerCode] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL,
[BrokerName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[BondTurnoverYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[StatusValidYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[MarketMakerYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[DailyOfficalListYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[CrestCode] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[MemberPackYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[EBCFee] [numeric] (19, 6) NOT NULL,
[Location] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[MemberType] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Broker] ADD CONSTRAINT [PK_Broker] PRIMARY KEY CLUSTERED  ([BrokerCode]) ON [PRIMARY]
GO
