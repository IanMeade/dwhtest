CREATE TABLE [dbo].[BrokerMappingCode]
(
[OldBroker] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL,
[NewBroker] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BrokerMappingCode] ADD CONSTRAINT [PK_BrokerMappingCode] PRIMARY KEY CLUSTERED  ([OldBroker], [NewBroker]) ON [PRIMARY]
GO
