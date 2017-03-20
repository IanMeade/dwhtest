CREATE TABLE [DWH].[FactInstrumentStatusHistory]
(
[InstrumentStatusHistoryID] [int] NOT NULL IDENTITY(1, 1),
[InstrumentID] [int] NOT NULL,
[InstrumemtStatusID] [smallint] NOT NULL,
[OldInstrumentStatusID] [smallint] NOT NULL,
[InstrumemtStatusDateID] [int] NOT NULL,
[InstrumemtStatusTimeID] [smallint] NOT NULL,
[InstrumemtStatusTime] [time] NOT NULL,
[StatusCreatedDateID] [int] NOT NULL,
[StatusCreatedTimeID] [smallint] NOT NULL,
[StatusCreatedTime] [time] NOT NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] ADD CONSTRAINT [PK_FactInstrumentStatusHistory] PRIMARY KEY CLUSTERED  ([InstrumentStatusHistoryID]) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimBatch] FOREIGN KEY ([BatchID]) REFERENCES [DWH].[DimBatch] ([BatchID])
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimDate] FOREIGN KEY ([InstrumemtStatusDateID]) REFERENCES [DWH].[DimDate] ([DateID])
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimDate1] FOREIGN KEY ([StatusCreatedDateID]) REFERENCES [DWH].[DimDate] ([DateID])
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimInstrument] FOREIGN KEY ([InstrumentID]) REFERENCES [DWH].[DimInstrument] ([InstrumentID])
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimStatus] FOREIGN KEY ([InstrumemtStatusID]) REFERENCES [DWH].[DimStatus] ([StatusID])
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimTime] FOREIGN KEY ([InstrumemtStatusTimeID]) REFERENCES [DWH].[DimTime] ([TimeID])
GO
ALTER TABLE [DWH].[FactInstrumentStatusHistory] WITH NOCHECK ADD CONSTRAINT [FK_FactInstrumentStatusHistory_DimTime1] FOREIGN KEY ([StatusCreatedTimeID]) REFERENCES [DWH].[DimTime] ([TimeID])
GO
