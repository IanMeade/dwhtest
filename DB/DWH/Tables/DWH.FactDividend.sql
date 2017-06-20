CREATE TABLE [DWH].[FactDividend]
(
[DividendID] [smallint] NOT NULL IDENTITY(1, 1),
[CoporateActionGID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[CorporateActionTypeID] [smallint] NOT NULL,
[InstrumentID] [int] NOT NULL,
[NextMeetingDateID] [int] NOT NULL,
[ExDateID] [int] NOT NULL,
[PaymentDateID] [int] NOT NULL,
[RecordDateID] [int] NOT NULL,
[CurrencyID] [smallint] NOT NULL,
[CorporateActionStatusDateID] [int] NOT NULL,
[Coupon] [decimal] (23, 10) NULL,
[DividendPerShare] [decimal] (23, 10) NULL,
[DividendRatePercent] [decimal] (23, 10) NULL,
[FXRate] [decimal] (23, 10) NULL,
[GrossDivEuro] [decimal] (23, 10) NULL,
[GrossDividend] [decimal] (23, 10) NULL,
[TaxAmount] [decimal] (23, 10) NULL,
[TaxDescription] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[TaxRatePercent] [decimal] (23, 10) NULL,
[AdditionalDescription] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL,
[Details] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL,
[DSSPublishDate] [date] NULL,
[DSSCreatedBy] [varchar] (30) COLLATE Latin1_General_CI_AS NULL,
[DSSCreatedDate] [datetime] NULL,
[DSSNote] [varchar] (255) COLLATE Latin1_General_CI_AS NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactDividend] ADD CONSTRAINT [PK_FactDividend] PRIMARY KEY CLUSTERED  ([DividendID]) ON [PRIMARY]
GO
