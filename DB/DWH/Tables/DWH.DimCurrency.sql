CREATE TABLE [DWH].[DimCurrency]
(
[CurrencyID] [smallint] NOT NULL IDENTITY(1, 1),
[CurrencySymbol] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[CurrencyISOCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[CurrencyName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[CurrencyCountry] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimCurrency] ADD CONSTRAINT [PK_DimCurrency] PRIMARY KEY CLUSTERED  ([CurrencyID]) ON [PRIMARY]
GO
