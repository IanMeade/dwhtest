CREATE TABLE [DWH].[FactCorporateAction]
(
[CorporateActionId] [smallint] NOT NULL IDENTITY(1, 1),
[CorporateActionGID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[CorporateActionTypeID] [smallint] NOT NULL,
[InstrumentID] [int] NOT NULL,
[EffectiveDateID] [int] NOT NULL,
[RecordDateID] [int] NOT NULL,
[ExDateID] [int] NOT NULL,
[LatestDateForApplicationNilPaidID] [int] NOT NULL,
[LatestDateForFinalApplicationID] [int] NOT NULL,
[CorporateActionStatusDateID] [int] NOT NULL,
[LatestSplittingDateNote] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[Conditional] [char] (2) COLLATE Latin1_General_CI_AS NULL,
[ReverseTakeover] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[NumberOfNewShares] [decimal] (23, 10) NULL,
[ExPrice] [decimal] (23, 10) NULL,
[Price] [decimal] (23, 10) NULL,
[Details] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL,
[AdditionalDescription] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL,
[DSSPublishDate] [date] NULL,
[DSSCreatedBy] [varchar] (30) COLLATE Latin1_General_CI_AS NULL,
[DSSCreatedDate] [datetime] NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactCorporateAction] ADD CONSTRAINT [PK_FactCorporateAction] PRIMARY KEY CLUSTERED  ([CorporateActionId]) ON [PRIMARY]
GO
