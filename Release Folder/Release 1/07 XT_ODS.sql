USE XT_ODS
GO


/* 
Run this script on a database with the schema represented by: 
 
        XT_ODS    -  This database will be modified. The scripts folder will not be modified. 
 
to synchronize it with a database with the schema represented by: 
 
        T7-DDT-01.XT_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 24/02/2017 12:45:27 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[EquityStage]'
GO
CREATE TABLE [dbo].[EquityStage] 
( 
[Asset_Type] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[Name] [varchar] (900) COLLATE Latin1_General_CI_AS NULL, 
[DelistedDefunct] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[ListingDate] [datetime] NULL, 
[ListingStatus] [varchar] (60) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentStatusDate] [datetime] NULL, 
[InstrumentStatusCreatedDatetime] [datetime] NULL, 
[Sector] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[Subfocus1] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[Subfocus2] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[Subfocus3] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[Subfocus4] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[Subfocus5] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[ApprovalType] [varchar] (40) COLLATE Latin1_General_CI_AS NULL, 
[ApprovalDate] [datetime] NULL, 
[TdFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[MadFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[PdFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[Gid] [varchar] (60) COLLATE Latin1_General_CI_AS NULL, 
[IssuerGid] [varchar] (60) COLLATE Latin1_General_CI_AS NULL, 
[Isin] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[Sedol] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[IssuedDate] [datetime] NULL, 
[MarketType] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[SecurityType] [varchar] (60) COLLATE Latin1_General_CI_AS NULL, 
[DenominationCurrency] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[FreeFloatAdj] [decimal] (13, 0) NULL, 
[EtfIndexFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[IexiIdexFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[IteqIndexFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[GeneralFinancialFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[SmallCap] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[Note] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryMarket] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[QuotationCurrency] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[UnitOfQuotation] [decimal] (13, 0) NULL, 
[Wkn] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[Mnem] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[CfiName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CfiCode] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[SmfName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[TotalSharesInIssue] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[IssuedShares] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentActualListedDate] [datetime] NULL, 
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CompanyGid] [varchar] (60) COLLATE Latin1_General_CI_AS NULL, 
[ExtractSequenceId] [bigint] NOT NULL IDENTITY(1, 1), 
[ExtractDate] [datetime] NULL CONSTRAINT [DF__EquitySta__Extra__117F9D94] DEFAULT (getdate()), 
[MessageId] [bigint] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[IssuerStage]'
GO
CREATE TABLE [dbo].[IssuerStage] 
( 
[Name] [varchar] (600) COLLATE Latin1_General_CI_AS NULL, 
[DateOfIncorporation] [datetime] NULL, 
[DebtorCode] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[DebtorCodeEquity] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[Domicile] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[DomicileDomesticFlag] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[FeeCode] [int] NULL, 
[SmfName] [varchar] (600) COLLATE Latin1_General_CI_AS NULL, 
[Td_Home_Member_Country] [varchar] (400) COLLATE Latin1_General_CI_AS NULL, 
[VatNumber] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[LegalStructure] [varchar] (40) COLLATE Latin1_General_CI_AS NULL, 
[YearEnd] [datetime] NULL, 
[Pd_Home_Member_Country] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[Lei_Code] [varchar] (40) COLLATE Latin1_General_CI_AS NULL, 
[EUFlag] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[IsoCode] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[Gid] [varchar] (40) COLLATE Latin1_General_CI_AS NULL, 
[ExtractSequenceId] [bigint] NOT NULL IDENTITY(1, 1), 
[ExtractDate] [datetime] NULL CONSTRAINT [DF__IssuerSta__Extra__15502E78] DEFAULT (getdate()), 
[MessageId] [bigint] NULL 
)
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
