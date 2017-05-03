CREATE TABLE [dbo].[ExchangeRateValue]
(
[ExchangeRateID] [int] NOT NULL IDENTITY(1, 1),
[ValueInserted] [datetime2] NOT NULL CONSTRAINT [DF_ExchangeRateValue_ValueInserted] DEFAULT (getdate()),
[ExchangeRateDate] [date] NOT NULL CONSTRAINT [DF_ExchangeRateValue_ExchangeRateDate] DEFAULT (getdate()),
[CCY] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[VAL] [numeric] (19, 6) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ExchangeRateValue] ADD CONSTRAINT [PK_ExchangeRateValue] PRIMARY KEY CLUSTERED  ([ExchangeRateID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ExchangeRateValue] ON [dbo].[ExchangeRateValue] ([ExchangeRateID]) ON [PRIMARY]
GO
