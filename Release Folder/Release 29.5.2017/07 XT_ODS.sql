/* 
Run this script on: 
 
        T7-DDT-06.XT_ODS    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.XT_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 29/05/2017 14:20:29 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [XT_ODS]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[IssuerStage]'
GO
CREATE TABLE [dbo].[IssuerStage] 
( 
[Name] [varchar] (300) COLLATE Latin1_General_CI_AS NOT NULL, 
[DateOfIncorporation] [datetime] NULL, 
[DebtorCode] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[DebtorCodeEquity] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[Domicile] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[DomicileDomesticFlag] [bit] NULL, 
[FeeCode] [int] NULL, 
[SmfName] [varchar] (300) COLLATE Latin1_General_CI_AS NULL, 
[Td_Home_Member_Country] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[VatNumber] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[YearEnd] [datetime] NULL, 
[Pd_Home_Member_Country] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[Lei_Code] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[EUFlag] [bit] NULL, 
[IsoCode] [varchar] (2) COLLATE Latin1_General_CI_AS NULL, 
[Gid] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[ExtractSequenceId] [bigint] NOT NULL IDENTITY(1, 1), 
[ExtractDate] [datetime] NULL CONSTRAINT [DF__IssuerSta__Extra__182C9B23] DEFAULT (getdate()), 
[MessageId] [varchar] (256) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__IssuerSt__A1071C3D4A988E36] on [dbo].[IssuerStage]'
GO
ALTER TABLE [dbo].[IssuerStage] ADD CONSTRAINT [PK__IssuerSt__A1071C3D4A988E36] PRIMARY KEY CLUSTERED  ([ExtractSequenceId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[EquityStage]'
GO
CREATE TABLE [dbo].[EquityStage] 
( 
[Asset_Type] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[Name] [varchar] (450) COLLATE Latin1_General_CI_AS NOT NULL, 
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
[Gid] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerGid] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[Isin] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[Sedol] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[IssuedDate] [datetime] NULL, 
[MarketType] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SecurityType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[DenominationCurrency] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[ISEQOverallFreeFloat] [decimal] (23, 10) NULL, 
[ISEQ20IndexFlag] [bit] NULL, 
[ESMIndexFlag] [bit] NULL, 
[IteqIndexFlag] [bit] NULL, 
[GeneralFinancialFlag] [bit] NULL, 
[SmallCap] [bit] NULL, 
[Note] [varchar] (300) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[QuotationCurrency] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[UnitOfQuotation] [decimal] (23, 10) NULL, 
[Wkn] [varchar] (6) COLLATE Latin1_General_CI_AS NULL, 
[Mnem] [varchar] (4) COLLATE Latin1_General_CI_AS NULL, 
[CfiName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CfiCode] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[SmfName] [varchar] (40) COLLATE Latin1_General_CI_AS NULL, 
[TotalSharesInIssue] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[IssuedShares] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentActualListedDate] [datetime] NULL, 
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CompanyGid] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[ExtractSequenceId] [bigint] NOT NULL IDENTITY(1, 1), 
[ExtractDate] [datetime] NULL CONSTRAINT [DF__EquitySta__Extra__1B0907CE] DEFAULT (getdate()), 
[MessageId] [varchar] (256) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__EquitySt__A1071C3D265415B4] on [dbo].[EquityStage]'
GO
ALTER TABLE [dbo].[EquityStage] ADD CONSTRAINT [PK__EquitySt__A1071C3D265415B4] PRIMARY KEY CLUSTERED  ([ExtractSequenceId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[CorporateActionStage]'
GO
CREATE TABLE [dbo].[CorporateActionStage] 
( 
[Gid] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentGID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerGID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[CorpActionType] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[CorpActionAssetType] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[ActionType] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[AdditionalDescription] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL, 
[Conditional] [bit] NULL, 
[CouponNumber] [decimal] (23, 10) NULL, 
[Currency] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[CurrentNumberOfSharesInIssue] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[Details] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL, 
[DividendPerShare] [decimal] (23, 10) NULL, 
[DividendRatePercent] [decimal] (23, 10) NULL, 
[EffectiveDate] [datetime] NULL, 
[ExDate] [datetime] NULL, 
[ExPrice] [decimal] (23, 10) NULL, 
[FXRate] [decimal] (23, 10) NULL, 
[GrossDividendEuro] [decimal] (23, 10) NULL, 
[GrossDividend] [decimal] (23, 10) NULL, 
[LatestDateForApplicationNilPaid] [datetime] NULL, 
[LatestDateForFinalApplication] [datetime] NULL, 
[LatestSplittingDate] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[NextMeetingDate] [datetime] NULL, 
[NumberOfNewShares] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[PaymentDate] [datetime] NULL, 
[Price] [decimal] (23, 10) NULL, 
[RecordDate] [datetime] NULL, 
[ReverseTakover] [bit] NULL, 
[RightsPrice] [decimal] (23, 10) NULL, 
[SharePrice] [decimal] (23, 10) NULL, 
[Status] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[StatusDate] [datetime] NULL, 
[TaxAmount] [decimal] (23, 10) NULL, 
[TaxDescription] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[TaxRatePercent] [decimal] (23, 10) NULL, 
[Unconditional] [bit] NULL, 
[ExtractSequenceId] [bigint] NOT NULL IDENTITY(1, 1), 
[ExtractDate] [datetime] NULL CONSTRAINT [DF__Corporate__Extra__4F7CD00D] DEFAULT (getdate()), 
[MessageId] [varchar] (256) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__Corporat__A1071C3D1FBFA895] on [dbo].[CorporateActionStage]'
GO
ALTER TABLE [dbo].[CorporateActionStage] ADD CONSTRAINT [PK__Corporat__A1071C3D1FBFA895] PRIMARY KEY CLUSTERED  ([ExtractSequenceId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT 
SET @Success = 1 
SET NOEXEC OFF 
IF (@Success = 1) PRINT 'The database update succeeded' 
ELSE BEGIN 
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION 
	PRINT 'The database update failed' 
END
GO
