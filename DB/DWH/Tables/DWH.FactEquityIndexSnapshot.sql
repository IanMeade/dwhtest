CREATE TABLE [DWH].[FactEquityIndexSnapshot]
(
[EquityIndexID] [int] NOT NULL IDENTITY(1, 1),
[DateID] [int] NOT NULL,
[IndexTypeID] [smallint] NOT NULL,
[OpenValue] [numeric] (19, 6) NULL,
[CloseValue] [numeric] (19, 6) NULL,
[ReturnIndex] [numeric] (19, 6) NULL,
[MarketCap] [numeric] (28, 6) NULL,
[DailyHigh] [numeric] (19, 6) NULL,
[DailyLow] [numeric] (19, 6) NULL,
[InterestRate] [numeric] (9, 6) NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactEquityIndexSnapshot] ADD CONSTRAINT [PK_FactEquityIndexSnapshot] PRIMARY KEY CLUSTERED  ([EquityIndexID]) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactEquityIndexSnapshot] ADD CONSTRAINT [FK_FactEquityIndexSnapshot_DimDate] FOREIGN KEY ([DateID]) REFERENCES [DWH].[DimDate] ([DateID])
GO
ALTER TABLE [DWH].[FactEquityIndexSnapshot] ADD CONSTRAINT [FK_FactEquityIndexSnapshot_DimIndexType] FOREIGN KEY ([IndexTypeID]) REFERENCES [DWH].[DimIndexType] ([IndexTypeID])
GO
