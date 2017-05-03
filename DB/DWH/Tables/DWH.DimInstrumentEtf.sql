CREATE TABLE [DWH].[DimInstrumentEtf]
(
[InstrumentID] [int] NOT NULL,
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[InstrumentName] [varchar] (256) COLLATE Latin1_General_CI_AS NOT NULL,
[InstrumentType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[SecurityType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[SEDOL] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL,
[InstrumentStatusID] [smallint] NOT NULL,
[InstrumentStatusDate] [date] NOT NULL,
[InstrumentListedDate] [date] NULL,
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[IssuerName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[IssuerGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[CompanyGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[CompanyListedDate] [date] NULL,
[CompanyApprovalType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[CompanyApprovalDate] [date] NULL,
[TransparencyDirectiveYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[MarketAbuseDirectiveYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ProspectusDirectiveYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[MarketID] [smallint] NOT NULL,
[IssuerDomicile] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[WKN] [varchar] (6) COLLATE Latin1_General_CI_AS NOT NULL,
[MNEM] [varchar] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[PrimaryBusinessSector] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[SubBusinessSector1] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[SubBusinessSector2] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[SubBusinessSector3] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[SubBusinessSector4] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[SubBusinessSector5] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[OverallIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[GeneralIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[FinancialIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[SmallCapIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ITEQIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ISEQ20IndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ESMIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[FinancialYearEndDate] [date] NULL,
[IncorporationDate] [date] NULL,
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[TransparencyDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[ProspectusDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[IssuerDomicileDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[FeeCodeName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[IssuedDate] [date] NULL,
[CurrencyID] [smallint] NOT NULL,
[UnitOfQuotation] [numeric] (19, 9) NOT NULL,
[QuotationCurrencyID] [smallint] NOT NULL,
[ISEQ20Freefloat] [numeric] (19, 6) NOT NULL,
[ISEQOverallFreeFloat] [numeric] (19, 6) NOT NULL,
[IssuerSedolMasterFileName] [varchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[InstrumentDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[CFIName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[CFICode] [varchar] (6) COLLATE Latin1_General_CI_AS NOT NULL,
[InstrumentSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NOT NULL,
[TotalSharesInIssue] [numeric] (28, 6) NOT NULL,
[LastEXDivDate] [date] NULL,
[CompanyStatusID] [smallint] NOT NULL,
[Note] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL,
[StartDate] [datetime2] NOT NULL,
[EndDate] [datetime2] NULL,
[CurrentRowYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimInstrumentEtf] ADD CONSTRAINT [PK_DimInstrumentEtf] PRIMARY KEY CLUSTERED  ([InstrumentID]) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimInstrumentEtf] ADD CONSTRAINT [FK_DimInstrumentEtf_DimInstrument] FOREIGN KEY ([InstrumentID]) REFERENCES [DWH].[DimInstrument] ([InstrumentID])
GO
