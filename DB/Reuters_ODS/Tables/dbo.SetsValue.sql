CREATE TABLE [dbo].[SetsValue]
(
[SetsValueID] [int] NOT NULL IDENTITY(1, 1),
[ValueInserted] [datetime2] NOT NULL CONSTRAINT [DF_SetsValue_ValueInserted] DEFAULT (getdate()),
[SetsDate] [date] NOT NULL CONSTRAINT [DF_SetsValue_SetsDate] DEFAULT (getdate()),
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[TURNOVER] [numeric] (19, 6) NOT NULL,
[VOLUME] [numeric] (19, 6) NOT NULL,
[DEALS] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SetsValue] ADD CONSTRAINT [PK_SetsValue] PRIMARY KEY CLUSTERED  ([SetsValueID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SetsValue] ON [dbo].[SetsValue] ([SetsValueID]) ON [PRIMARY]
GO
