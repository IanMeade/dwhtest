CREATE TABLE [DWH].[FactExchangeRate]
(
[ExchangeRateID] [int] NOT NULL IDENTITY(1, 1),
[DateID] [int] NOT NULL,
[CurrencyID] [smallint] NOT NULL,
[ExchangeRate] [numeric] (19, 6) NOT NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactExchangeRate] ADD CONSTRAINT [PK_FactExchangeRate] PRIMARY KEY CLUSTERED  ([ExchangeRateID]) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactExchangeRate] ADD CONSTRAINT [FK_FactExchangeRate_DimBatch] FOREIGN KEY ([BatchID]) REFERENCES [DWH].[DimBatch] ([BatchID])
GO
ALTER TABLE [DWH].[FactExchangeRate] ADD CONSTRAINT [FK_FactExchangeRate_DimCurrency] FOREIGN KEY ([CurrencyID]) REFERENCES [DWH].[DimCurrency] ([CurrencyID])
GO
ALTER TABLE [DWH].[FactExchangeRate] ADD CONSTRAINT [FK_FactExchangeRate_DimDate] FOREIGN KEY ([DateID]) REFERENCES [DWH].[DimDate] ([DateID])
GO
