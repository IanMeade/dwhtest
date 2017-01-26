CREATE TABLE [DWH].[DimTrader]
(
[TraderID] [smallint] NOT NULL IDENTITY(1, 1),
[TraderCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[BrokerCode] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL,
[TraderType] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimTrader] ADD CONSTRAINT [PK_DimTrader] PRIMARY KEY CLUSTERED  ([TraderID]) ON [PRIMARY]
GO
