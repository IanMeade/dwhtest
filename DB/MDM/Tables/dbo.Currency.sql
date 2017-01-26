CREATE TABLE [dbo].[Currency]
(
[CurrencySymbol] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[CurrencyISOCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[CurrencyName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[CurrencyCountry] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Currency] ADD CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED  ([CurrencyISOCode]) ON [PRIMARY]
GO
