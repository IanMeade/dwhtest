CREATE TABLE [DWH].[FactCorporateAction]
(
[CorporateActionId] [smallint] NOT NULL IDENTITY(1, 1),
[CoporateActionGID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL,
[CorporateActionTypeID] [smallint] NULL,
[InstrumentID] [int] NULL,
[EffectiveDateID] [int] NULL,
[RecordDateID] [int] NULL,
[ExDateID] [int] NULL,
[LatestDateForApplicationNilPaidID] [int] NULL,
[LatestDateForFinalApplicationID] [int] NULL,
[LatestSplittingDateNote] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[CorporateActionStatusDateID] [int] NULL,
[Conditional] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[Unconditional] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[ReverseTakeover] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[CurrentNumberOfSharesInIssue] [decimal] (23, 10) NULL,
[NumberOfNewShares] [decimal] (23, 10) NULL,
[ExPrice] [decimal] (23, 10) NULL,
[Price] [decimal] (23, 10) NULL,
[SharePrice] [decimal] (23, 10) NULL,
[Details] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL,
[AdditionalDescription] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL,
[Note] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL,
[BatchID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactCorporateAction] ADD CONSTRAINT [PK_FactCorporateAction] PRIMARY KEY CLUSTERED  ([CorporateActionId]) ON [PRIMARY]
GO
