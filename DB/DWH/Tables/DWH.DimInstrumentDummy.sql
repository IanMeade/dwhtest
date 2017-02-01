CREATE TABLE [DWH].[DimInstrumentDummy]
(
[InstrumentID] [int] NOT NULL IDENTITY(1, 1),
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[InstrumentType] [varchar] (12) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimInstrumentDummy] ADD CONSTRAINT [PK_DimInstrumentDummy] PRIMARY KEY CLUSTERED  ([InstrumentID]) ON [PRIMARY]
GO
