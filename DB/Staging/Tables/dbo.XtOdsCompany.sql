CREATE TABLE [dbo].[XtOdsCompany]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Asset_Type] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Name] [varchar] (450) COLLATE Latin1_General_CI_AS NULL,
[DelistedDefunct] [bit] NULL,
[ListingDate] [datetime] NULL,
[ListingStatus] [varchar] (30) COLLATE Latin1_General_CI_AS NULL,
[InstrumentStatusDate] [datetime] NULL,
[InstrumentStatusCreatedDatetime] [datetime] NULL,
[Sector] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Subfocus1] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Subfocus2] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Subfocus3] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Subfocus4] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Subfocus5] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[ApprovalType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[ApprovalDate] [datetime] NULL,
[TdFlag] [bit] NULL,
[MadFlag] [bit] NULL,
[PdFlag] [bit] NULL,
[Gid] [varchar] (30) COLLATE Latin1_General_CI_AS NULL,
[IssuerGid] [varchar] (30) COLLATE Latin1_General_CI_AS NULL,
[Isin] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Sedol] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[MarketType] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[SecurityType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[DenominationCurrency] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[IteqIndexFlag] [bit] NULL,
[GeneralFinancialFlag] [bit] NULL,
[SmallCap] [bit] NULL,
[Note] [varchar] (300) COLLATE Latin1_General_CI_AS NULL,
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[QuotationCurrency] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[UnitOfQuotation] [numeric] (23, 10) NULL,
[Wkn] [varchar] (6) COLLATE Latin1_General_CI_AS NULL,
[Mnem] [varchar] (4) COLLATE Latin1_General_CI_AS NULL,
[CfiName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[CfiCode] [varchar] (10) COLLATE Latin1_General_CI_AS NULL,
[SmfName] [varchar] (40) COLLATE Latin1_General_CI_AS NULL,
[TotalSharesInIssue] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[InstrumentActualListedDate] [datetime] NULL,
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[CompanyGid] [varchar] (30) COLLATE Latin1_General_CI_AS NULL,
[ExtractSequenceId] [bigint] NULL,
[ExtractDate] [datetime] NULL,
[MessageId] [varchar] (256) COLLATE Latin1_General_CI_AS NULL,
[ISEQOverallFreeFloat] [numeric] (23, 10) NULL,
[ISEQ20IndexFlag] [bit] NULL,
[ESMIndexFlag] [bit] NULL
) ON [PRIMARY]
GO
