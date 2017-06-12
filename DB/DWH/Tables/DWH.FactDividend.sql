CREATE TABLE [DWH].[FactDividend]
(
[DividendID] [smallint] NOT NULL IDENTITY(1, 1),
[CoporateActionGID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL,
[CorporateActionTypeID] [smallint] NULL,
[InstrumentID] [int] NULL,
[NextMeetingDateID] [int] NULL,
[ExDateID] [int] NULL,
[PaymentDateID] [int] NULL,
[RecordDateID] [int] NULL,
[CurrencyID] [smallint] NULL,
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
[Note] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL,
[BatchID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[FactDividend] ADD CONSTRAINT [PK_FactDividend] PRIMARY KEY CLUSTERED  ([DividendID]) ON [PRIMARY]
GO
