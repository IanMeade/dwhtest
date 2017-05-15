CREATE TABLE [DWH].[FactEquityIndex]
(
[EquityIndexID] [int] NOT NULL IDENTITY(1, 1),
[IndexDateID] [int] NOT NULL,
[IndexTimeID] [smallint] NOT NULL,
[OverallLast] [numeric] (8, 3) NOT NULL,
[OverallOpen] [numeric] (8, 3) NOT NULL,
[OverallHigh] [numeric] (8, 3) NOT NULL,
[OverallLow] [numeric] (8, 3) NOT NULL,
[OverallReturn] [numeric] (8, 3) NOT NULL,
[FinancialLast] [numeric] (8, 3) NOT NULL,
[FinancialOpen] [numeric] (8, 3) NOT NULL,
[FinancialHigh] [numeric] (8, 3) NOT NULL,
[FinancialLow] [numeric] (8, 3) NOT NULL,
[FinancialReturn] [numeric] (8, 3) NOT NULL,
[GeneralLast] [numeric] (8, 3) NOT NULL,
[GeneralOpen] [numeric] (8, 3) NOT NULL,
[GeneralHigh] [numeric] (8, 3) NOT NULL,
[GeneralLow] [numeric] (8, 3) NOT NULL,
[GeneralReturn] [numeric] (8, 3) NOT NULL,
[SmallCapLast] [numeric] (8, 3) NOT NULL,
[SmallCapOpen] [numeric] (8, 3) NOT NULL,
[SmallCapHigh] [numeric] (8, 3) NOT NULL,
[SmallCapLow] [numeric] (8, 3) NOT NULL,
[SmallCapReturn] [numeric] (8, 3) NOT NULL,
[ITEQlast] [numeric] (8, 3) NOT NULL,
[ITEQOpen] [numeric] (8, 3) NOT NULL,
[ITEQHigh] [numeric] (8, 3) NOT NULL,
[ITEQLow] [numeric] (8, 3) NOT NULL,
[ITEQReturn] [numeric] (8, 3) NOT NULL,
[ISEQ20Last] [numeric] (8, 3) NOT NULL,
[ISEQ20Open] [numeric] (8, 3) NOT NULL,
[ISEQ20High] [numeric] (8, 3) NOT NULL,
[ISEQ20Low] [numeric] (8, 3) NOT NULL,
[ISEQ20Return] [numeric] (8, 3) NOT NULL,
[ISEQ20INAVlast] [numeric] (8, 3) NOT NULL,
[ISEQ20INAVOpen] [numeric] (8, 3) NOT NULL,
[ISEQ20INAVHigh] [numeric] (8, 3) NOT NULL,
[ISEQ20INAVLow] [numeric] (8, 3) NOT NULL,
[ESMLast] [numeric] (8, 3) NOT NULL,
[ESMopen] [numeric] (8, 3) NOT NULL,
[ESMHigh] [numeric] (8, 3) NOT NULL,
[ESMLow] [numeric] (8, 3) NOT NULL,
[ESMReturn] [numeric] (8, 3) NOT NULL,
[ISEQ20InverseLast] [numeric] (8, 3) NOT NULL,
[ISEQ20InverseOpen] [numeric] (8, 3) NOT NULL,
[ISEQ20InverseHigh] [numeric] (8, 3) NOT NULL,
[ISEQ20InverseLow] [numeric] (8, 3) NOT NULL,
[ISEQ20InverseReturn] [numeric] (8, 3) NOT NULL,
[ISEQ20LeveragedLast] [numeric] (8, 3) NOT NULL,
[ISEQ20LeveragedOpen] [numeric] (8, 3) NOT NULL,
[ISEQ20LeveragedHigh] [numeric] (8, 3) NOT NULL,
[ISEQ20LeveragedLow] [numeric] (8, 3) NOT NULL,
[ISEQ20CappedLast] [numeric] (8, 3) NOT NULL,
[ISEQ20CappedOpen] [numeric] (8, 3) NOT NULL,
[ISEQ20CappedHigh] [numeric] (8, 3) NOT NULL,
[ISEQ20CappedLow] [numeric] (8, 3) NOT NULL,
[ISEQ20CappedReturn] [numeric] (8, 3) NOT NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactEquityIndex] ADD CONSTRAINT [PK_FactEquityIndex] PRIMARY KEY CLUSTERED  ([EquityIndexID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FactEquityIndex] ON [DWH].[FactEquityIndex] ([IndexDateID], [IndexTimeID]) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactEquityIndex] ADD CONSTRAINT [FK_FactEquityIndex_DimDate] FOREIGN KEY ([IndexDateID]) REFERENCES [DWH].[DimDate] ([DateID])
GO
ALTER TABLE [DWH].[FactEquityIndex] ADD CONSTRAINT [FK_FactEquityIndex_DimTime] FOREIGN KEY ([IndexTimeID]) REFERENCES [DWH].[DimTime] ([TimeID])
GO
