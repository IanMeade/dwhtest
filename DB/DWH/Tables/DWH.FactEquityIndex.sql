CREATE TABLE [DWH].[FactEquityIndex]
(
[EquityIndexID] [int] NOT NULL IDENTITY(1, 1),
[IndexDateID] [int] NOT NULL,
[IndexTimeID] [smallint] NOT NULL,
[OverallLast] [numeric] (8, 3) NULL,
[OverallOpen] [numeric] (8, 3) NULL,
[OverallHigh] [numeric] (8, 3) NULL,
[OverallLow] [numeric] (8, 3) NULL,
[OverallReturn] [numeric] (8, 3) NULL,
[FinancialLast] [numeric] (8, 3) NULL,
[FinancialOpen] [numeric] (8, 3) NULL,
[FinancialHigh] [numeric] (8, 3) NULL,
[FinancialLow] [numeric] (8, 3) NULL,
[FinancialReturn] [numeric] (8, 3) NULL,
[GeneralLast] [numeric] (8, 3) NULL,
[GeneralOpen] [numeric] (8, 3) NULL,
[GeneralHigh] [numeric] (8, 3) NULL,
[GeneralLow] [numeric] (8, 3) NULL,
[GeneralReturn] [numeric] (8, 3) NULL,
[SmallCapLast] [numeric] (8, 3) NULL,
[SmallCapOpen] [numeric] (8, 3) NULL,
[SmallCapHigh] [numeric] (8, 3) NULL,
[SmallCapLow] [numeric] (8, 3) NULL,
[SmallCapReturn] [numeric] (8, 3) NULL,
[ITEQlast] [numeric] (8, 3) NULL,
[ITEQOpen] [numeric] (8, 3) NULL,
[ITEQHigh] [numeric] (8, 3) NULL,
[ITEQLow] [numeric] (8, 3) NULL,
[ITEQReturn] [numeric] (8, 3) NULL,
[ISEQ20Last] [numeric] (8, 3) NULL,
[ISEQ20Open] [numeric] (8, 3) NULL,
[ISEQ20High] [numeric] (8, 3) NULL,
[ISEQ20Low] [numeric] (8, 3) NULL,
[ISEQ20Return] [numeric] (8, 3) NULL,
[ISEQ20INAVlast] [numeric] (8, 3) NULL,
[ISEQ20INAVOpen] [numeric] (8, 3) NULL,
[ISEQ20INAVHigh] [numeric] (8, 3) NULL,
[ISEQ20INAVLow] [numeric] (8, 3) NULL,
[ESMLast] [numeric] (8, 3) NULL,
[ESMopen] [numeric] (8, 3) NULL,
[ESMHigh] [numeric] (8, 3) NULL,
[ESMLow] [numeric] (8, 3) NULL,
[ESMReturn] [numeric] (8, 3) NULL,
[ISEQ20InverseLast] [numeric] (8, 3) NULL,
[ISEQ20InverseOpen] [numeric] (8, 3) NULL,
[ISEQ20InverseHigh] [numeric] (8, 3) NULL,
[ISEQ20InverseLow] [numeric] (8, 3) NULL,
[ISEQ20InverseReturn] [numeric] (8, 3) NULL,
[ISEQ20LeveragedLast] [numeric] (8, 3) NULL,
[ISEQ20LeveragedOpen] [numeric] (8, 3) NULL,
[ISEQ20LeveragedHigh] [numeric] (8, 3) NULL,
[ISEQ20LeveragedLow] [numeric] (8, 3) NULL,
[ISEQ20CappedLast] [numeric] (8, 3) NULL,
[ISEQ20CappedOpen] [numeric] (8, 3) NULL,
[ISEQ20CappedHigh] [numeric] (8, 3) NULL,
[ISEQ20CappedLow] [numeric] (8, 3) NULL,
[ISEQ20CappedReturn] [numeric] (8, 3) NULL,
[BatchID] [int] NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
ALTER TABLE [DWH].[FactEquityIndex] ADD CONSTRAINT [PK_FactEquityIndex] PRIMARY KEY NONCLUSTERED  ([EquityIndexID]) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_FactEquityIndex_ClusterIndex] ON [DWH].[FactEquityIndex] ([IndexDateID], [IndexTimeID], [EquityIndexID]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactEquityIndex] ADD CONSTRAINT [FK_FactEquityIndex_DimDate] FOREIGN KEY ([IndexDateID]) REFERENCES [DWH].[DimDate] ([DateID])
GO
ALTER TABLE [DWH].[FactEquityIndex] ADD CONSTRAINT [FK_FactEquityIndex_DimTime] FOREIGN KEY ([IndexTimeID]) REFERENCES [DWH].[DimTime] ([TimeID])
GO
