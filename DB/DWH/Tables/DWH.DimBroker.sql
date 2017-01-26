CREATE TABLE [DWH].[DimBroker]
(
[BrokerID] [smallint] NOT NULL IDENTITY(1, 1),
[BrokerCode] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL,
[BrokerName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[BondTurnoverYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[StatusValidYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[MarketMakerYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[CrestCode] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[MemberPackYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[DailyOfficalListYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[EBCFee] [numeric] (19, 6) NOT NULL,
[Location] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[MemberType] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[StartDate] [datetime2] NOT NULL,
[EndDate] [datetime2] NULL,
[CurrentRowYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimBroker] ADD CONSTRAINT [PK_DimBroker] PRIMARY KEY CLUSTERED  ([BrokerID]) ON [PRIMARY]
GO
