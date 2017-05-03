CREATE TABLE [dbo].[Status]
(
[StatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[ConditionalTradingYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_Status_ConditionalTradingYN] DEFAULT ('N'),
[ValidForEquity] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Status] ADD CONSTRAINT [PK__Status__05E7698BA7453788] PRIMARY KEY CLUSTERED  ([StatusName]) ON [PRIMARY]
GO
