CREATE TABLE [DWH].[DimInstrument]
(
[InstrumentID] [int] NOT NULL IDENTITY(1, 1),
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[InstrumentName] [varchar] (256) COLLATE Latin1_General_CI_AS NOT NULL,
[InstrumentType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[SecurityType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[SEDOL] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL,
[InstrumentStatusID] [smallint] NOT NULL,
[InstrumentStatusDate] [date] NOT NULL,
[InstrumentListedDate] [date] NULL,
[IssuerName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[IssuerGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[MarketID] [smallint] NOT NULL,
[IssuerDomicile] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[FinancialYearEndDate] [date] NULL,
[IncorporationDate] [date] NULL,
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[TransparencyDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[ProspectusDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[IssuerDomicileDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[FeeCodeName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[WKN] [varchar] (6) COLLATE Latin1_General_CI_AS NOT NULL,
[MNEM] [varchar] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[IssuedDate] [date] NULL,
[IssuerSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NOT NULL,
[CompanyGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL,
[CompanyApprovalDate] [date] NULL,
[CompanyApprovalType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[InstrumentDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[InstrumentSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NOT NULL,
[StartDate] [datetime2] NOT NULL,
[EndDate] [datetime2] NULL,
[CurrentRowYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimInstrument] ADD CONSTRAINT [PK_DimInstrument] PRIMARY KEY CLUSTERED  ([InstrumentID]) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimInstrument] ADD CONSTRAINT [FK_DimInstrument_DimMarket] FOREIGN KEY ([MarketID]) REFERENCES [DWH].[DimMarket] ([MarketID])
GO
ALTER TABLE [DWH].[DimInstrument] ADD CONSTRAINT [FK_DimInstrument_DimStatus] FOREIGN KEY ([InstrumentStatusID]) REFERENCES [DWH].[DimStatus] ([StatusID])
GO
