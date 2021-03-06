USE Staging
GO


/* 
Run this script on a database with the schema represented by: 
 
        Staging    -  This database will be modified. The scripts folder will not be modified. 
 
to synchronize it with a database with the schema represented by: 
 
        T7-DDT-01.Staging 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 24/02/2017 12:39:29 
 
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
PRINT N'Creating [dbo].[FileList]'
GO
CREATE TABLE [dbo].[FileList] 
( 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileTag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[FilePrefix] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProcessFileYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_FileList_ProcessFileYN] DEFAULT ('N'), 
[SourceFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProcessFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[ArchiveFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[RejectFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[DwhFileID] [int] NULL, 
[Saftletter] AS (upper(substring(replace([FileName],[FilePrefix],''),(9),(1))+case  when substring(replace([FileName],[FilePrefix],''),(10),(1))='K' then 'K' else '' end)) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DwhDimInstrumentEquityEtf]'
GO
CREATE TABLE [dbo].[DwhDimInstrumentEquityEtf] 
( 
[InstrumentID] [int] NULL, 
[InstrumentGlobalID] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentName] [varchar] (256) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[SecurityType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[SEDOL] [varchar] (7) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentStatusID] [smallint] NULL, 
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[IssuerName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[IssuerGlobalID] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[IssuerStatusID] [smallint] NULL, 
[CompanyGlobalID] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[CompanyApprovalType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[TransparencyDirectiveYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[MarketAbuseDirectiveYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[ProspectusDirectiveYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[MarketID] [smallint] NULL, 
[IssuerDomicile] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[WKN] [varchar] (6) COLLATE Latin1_General_CI_AS NULL, 
[MNEM] [varchar] (4) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryBusinessSector] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector1] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector2] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector3] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector4] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector5] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[OverallIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[GeneralIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[FinancialIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[SmallCapIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[ITEQIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[ISEQ20IndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[ESMIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[TransparencyDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[ProspectusDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[IssuerDomicileDomesticYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[FeeCodeName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CurrencyID] [smallint] NULL, 
[UnitOfQuotation] [numeric] (19, 9) NULL, 
[QuotationCurrencyID] [smallint] NULL, 
[ISEQ20Freefloat] [numeric] (9, 6) NULL, 
[ISEQOverallFreeFloat] [numeric] (9, 6) NULL, 
[SecurityQualifier] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[IssuerSedolMasterFileName] [varchar] (35) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentDomesticYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[CFIName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CFICode] [varchar] (6) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NULL, 
[ExternalMarkets] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[TotalSharesInIssue] [numeric] (28, 6) NULL, 
[LastEXDivDateID] [int] NULL, 
[CompanyStatusID] [smallint] NULL, 
[CompanyStatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Note] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL, 
[StartDate] [datetime2] NULL, 
[EndDate] [datetime2] NULL, 
[CurrentRowYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[BatchID] [int] NULL, 
[InstrumentStatusDate] [date] NULL, 
[InstrumentListedDate] [date] NULL, 
[CompanyApprovalDate] [date] NULL, 
[FinancialYearEndDate] [date] NULL, 
[IncorporationDate] [date] NULL, 
[CompanyListedDate] [date] NULL, 
[IssuedDate] [date] NULL, 
[InstrumentStatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[IssuerStatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[MarketName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[MarketCode] [varchar] (15) COLLATE Latin1_General_CI_AS NULL, 
[CurrencyISOCode] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[QuotationCurrencyISOCode] [varchar] (3) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XtOdsIssuer]'
GO
CREATE TABLE [dbo].[XtOdsIssuer] 
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
[ExtractSequenceId] [bigint] NOT NULL, 
[ExtractDate] [datetime] NULL, 
[MessageId] [bigint] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[BestIssuer]'
GO
 
CREATE VIEW [dbo].[BestIssuer] AS 
		SELECT 
			* 
		FROM 
				dbo.XtOdsIssuer 
		WHERE 
			ExtractSequenceId IN ( 
					SELECT 
						MAX(ExtractSequenceId) AS ExtractSequenceId 
					FROM 
						dbo.XtOdsIssuer 
					GROUP BY 
						Gid 
			)  
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XtOdsCompany]'
GO
CREATE TABLE [dbo].[XtOdsCompany] 
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
[FreeFloatAdj] [numeric] (13, 0) NULL, 
[EtfIndexFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[IexiIdexFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[IteqIndexFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[GeneralFinancialFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[SmallCap] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[Note] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryMarket] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[QuotationCurrency] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[UnitOfQuotation] [numeric] (13, 0) NULL, 
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
[ExtractSequenceId] [bigint] NULL, 
[ExtractDate] [datetime] NULL, 
[MessageId] [bigint] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[BestCompany]'
GO
 
	 
CREATE VIEW [dbo].[BestCompany] AS 
		SELECT 
			* 
		FROM 
				dbo.XtOdsCompany 
		WHERE 
			ExtractSequenceId IN ( 
					SELECT 
						MAX(ExtractSequenceId) AS ExtractSequenceId 
					FROM 
						dbo.XtOdsCompany 
					GROUP BY 
						GID 
			)  
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XtOdsShare]'
GO
CREATE TABLE [dbo].[XtOdsShare] 
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
[FreeFloatAdj] [numeric] (13, 0) NULL, 
[EtfIndexFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[IexiIdexFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[IteqIndexFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[GeneralFinancialFlag] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[SmallCap] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[Note] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryMarket] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[QuotationCurrency] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[UnitOfQuotation] [numeric] (13, 0) NULL, 
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
[ExtractSequenceId] [bigint] NULL, 
[ExtractDate] [datetime] NULL, 
[MessageId] [bigint] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[BestShare]'
GO
CREATE VIEW [dbo].[BestShare] AS 
		SELECT 
			* 
		FROM 
				dbo.XtOdsShare 
		WHERE 
			ExtractSequenceId IN ( 
					SELECT 
						MAX(ExtractSequenceId) AS ExtractSequenceId 
					FROM 
						dbo.XtOdsShare 
					GROUP BY 
						Gid 
			)  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XtOdsInstrumentEquityEtfUpdate]'
GO
CREATE TABLE [dbo].[XtOdsInstrumentEquityEtfUpdate] 
( 
[InstrumentGlobalID] [varchar] (60) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentName] [varchar] (900) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentType] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[SecurityType] [varchar] (60) COLLATE Latin1_General_CI_AS NULL, 
[ISIN] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[SEDOL] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentStatusName] [varchar] (60) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentStatusDate] [datetime] NULL, 
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CompanyGlobalID] [varchar] (60) COLLATE Latin1_General_CI_AS NULL, 
[MarketName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[WKN] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[MNEM] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[GeneralIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentListedDate] [date] NULL, 
[InstrumentSedolMasterFileName] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[ISEQ20IndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerSedolMasterFileName] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[ITEQIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[LastEXDivDateID] [varchar] (8) COLLATE Latin1_General_CI_AS NOT NULL, 
[OverallIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[SecurityQualifier] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[FinancialIndexYN] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[SmallCapIndexYN] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[IssuedDate] [datetime] NULL, 
[CurrencyISOCode] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[UnitOfQuotation] [numeric] (22, 9) NULL, 
[QuotationCurrencyISOCode] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[ISEQ20Freefloat] [numeric] (19, 6) NULL, 
[ISEQOverallFreeFloat] [float] NULL, 
[CFIName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CFICode] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[TotalSharesInIssue] [numeric] (28, 6) NULL, 
[CompanyListedDate] [datetime] NULL, 
[CompanyApprovalDate] [datetime] NULL, 
[CompanyApprovalType] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[CompanyStatusName] [varchar] (60) COLLATE Latin1_General_CI_AS NULL, 
[Note] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL, 
[TransparencyDirectiveYN] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[MarketAbuseDirectiveYN] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[ProspectusDirectiveYN] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryBusinessSector] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector1] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector2] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector3] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector4] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector5] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[IssuerGlobalID] [varchar] (60) COLLATE Latin1_General_CI_AS NULL, 
[IssuerName] [varchar] (600) COLLATE Latin1_General_CI_AS NULL, 
[IssuerDomicile] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[FinancialYearEndDate] [datetime] NULL, 
[IncorporationDate] [datetime] NULL, 
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[TransparencyDirectiveHomeMemberCountry] [varchar] (400) COLLATE Latin1_General_CI_AS NULL, 
[ProspectusDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[IssuerDomicileDomesticYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[FeeCodeName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AssembleXtInterfaceEquityEtfUpdate]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 20/2/2017 
-- Description:	Get XT Interface changes 
-- ============================================= 
CREATE PROCEDURE [dbo].[AssembleXtInterfaceEquityEtfUpdate] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	TRUNCATE TABLE dbo.XtOdsInstrumentEquityEtfUpdate 
 
	/* ASSEMBLE FULL INSTRUMENT EQUITY/EFT DETAILS FOR XT UPDATES IN CURRENT SCOPE */ 
 
	INSERT INTO 
			dbo.XtOdsInstrumentEquityEtfUpdate 
 
		SELECT 
			/* This field should never be null */ 
			SHARE.GID	AS	InstrumentGlobalID, 
			COALESCE( SHARE.Name, DwhShare.InstrumentName ) AS InstrumentName, 
			COALESCE( SHARE.Asset_Type, DwhShare.InstrumentType ) AS InstrumentType, 
			COALESCE( SHARE.SecurityType, DwhShare.SecurityType ) AS SecurityType, 
			COALESCE( SHARE.ISIN, DwhShare.ISIN ) AS ISIN, 
			COALESCE( SHARE.SEDOL, DwhShare.SEDOL ) AS SEDOL, 
			COALESCE( SHARE.ListingStatus, DwhShare.InstrumentStatusName ) AS InstrumentStatusName, 
			COALESCE( SHARE.ListingDate, DwhShare.InstrumentStatusDate ) AS InstrumentStatusDate, 
			COALESCE( SHARE.TradingSysInstrumentName, DwhShare.TradingSysInstrumentName ) AS TradingSysInstrumentName, 
			COALESCE( SHARE.CompanyGID, DwhShare.CompanyGlobalID ) AS CompanyGlobalID, 
			COALESCE( SHARE.MarketType, DwhShare.MarketName ) AS MarketName, 
			COALESCE( SHARE.WKN, DwhShare.WKN ) AS	WKN, 
			COALESCE( SHARE.MNEM, DwhShare.MNEM ) AS MNEM, 
	 
			'X' AS	GeneralIndexYN, 
			CAST('19900101' AS DATE ) AS InstrumentListedDate, 
			'X' AS InstrumentSedolMasterFileName, 
			'X' AS ISEQ20IndexYN, 
			'X' AS IssuerSedolMasterFileName, 
			'X' AS ITEQIndexYN, 
			'19900101' AS LastEXDivDateID, 
			'X' AS OverallIndexYN, 
			'X' AS SecurityQualifier, 
 
			COALESCE( SHARE.GeneralFinancialFlag, DwhShare.FinancialIndexYN ) AS FinancialIndexYN, 
			COALESCE( SHARE.SmallCap, DwhShare.SmallCapIndexYN ) AS SmallCapIndexYN, 
 
			COALESCE( SHARE.PrimaryMarket, DwhShare.PrimaryMarket ) AS PrimaryMarket, 
			COALESCE( SHARE.IssuedDate, DwhShare.IssuedDate ) AS IssuedDate, 
			COALESCE( SHARE.DenominationCurrency, DwhShare.CurrencyISOCode ) AS CurrencyISOCode, 
			COALESCE( SHARE.UnitOfQuotation, DwhShare.UnitOfQuotation ) AS UnitOfQuotation, 
			COALESCE( SHARE.QuotationCurrency, DwhShare.QuotationCurrencyISOCode ) AS QuotationCurrencyISOCode, 
 
			COALESCE( SHARE.FreeFloatAdj, DwhShare.ISEQ20Freefloat ) AS ISEQ20Freefloat, 
			COALESCE( CAST(SHARE.IssuedShares AS FLOAT), DwhShare.ISEQOverallFreeFloat ) AS ISEQOverallFreeFloat, 
			COALESCE( SHARE.CFIName, DwhShare.CFIName ) AS CFIName, 
			COALESCE( SHARE.CFICode, DwhShare.CFICode ) AS CFICode, 
 
			COALESCE( SHARE.TotalSharesInIssue, DwhShare.TotalSharesInIssue ) AS TotalSharesInIssue, 
 
			COALESCE( COMPANY.ListingDate, DwhCompany.CompanyListedDate ) AS CompanyListedDate, 
			COALESCE( COMPANY.ApprovalDate, DwhCompany.CompanyApprovalDate ) AS CompanyApprovalDate, 
			'NOT MAPPED' AS CompanyApprovalType, 
			COALESCE( COMPANY.ListingStatus, DwhShare.CompanyStatusName ) AS CompanyStatusName, 
			COALESCE( COMPANY.Note , DwhShare.Note ) AS Note, 
 
 
			COALESCE( COMPANY.TDFlag, DwhCompany.TransparencyDirectiveYN ) AS TransparencyDirectiveYN, 
			COALESCE( COMPANY.MADFlag, DwhCompany.MarketAbuseDirectiveYN ) AS MarketAbuseDirectiveYN, 
			COALESCE( COMPANY.PDFlag, DwhCompany.ProspectusDirectiveYN ) AS ProspectusDirectiveYN, 
			COALESCE( COMPANY.Sector, DwhCompany. PrimaryBusinessSector) AS PrimaryBusinessSector, 
			COALESCE( COMPANY.SubFocus1, DwhCompany.SubBusinessSector1 ) AS SubBusinessSector1, 
			COALESCE( COMPANY.SubFocus2, DwhCompany.SubBusinessSector2 ) AS SubBusinessSector2, 
			COALESCE( COMPANY.SubFocus3, DwhCompany.SubBusinessSector3 ) AS SubBusinessSector3, 
			COALESCE( COMPANY.SubFocus4, DwhCompany.SubBusinessSector4 ) AS SubBusinessSector4, 
			COALESCE( COMPANY.SubFocus5, DwhCompany.SubBusinessSector5 ) AS SubBusinessSector5, 
 
			COALESCE( COMPANY.IssuerGid, DwhIssuer.IssuerGlobalID ) AS IssuerGlobalID, 
			COALESCE( ISSUER.Name, DwhIssuer.IssuerName ) AS IssuerName, 
			COALESCE( ISSUER.Domicile, DwhIssuer.IssuerDomicile ) AS IssuerDomicile, 
			COALESCE( ISSUER.YearEnd, DwhIssuer.FinancialYearEndDate ) AS FinancialYearEndDate, 
			COALESCE( ISSUER.DateofIncorporation, DwhIssuer.IncorporationDate ) AS IncorporationDate, 
			COALESCE( ISSUER.LegalStructure, DwhIssuer.LegalStructure ) AS LegalStructure, 
			COALESCE( ISSUER.AccountingStandard, DwhIssuer.AccountingStandard ) AS AccountingStandard, 
			COALESCE( ISSUER.TD_home_member_country, DwhIssuer.TransparencyDirectiveHomeMemberCountry ) AS TransparencyDirectiveHomeMemberCountry, 
			COALESCE( ISSUER.Pd_Home_Member_Country, DwhIssuer.ProspectusDirectiveHomeMemberCountry ) AS ProspectusDirectiveHomeMemberCountry, 
			COALESCE( ISSUER.DomicileDomesticFlag, DwhIssuer.IssuerDomicileDomesticYN ) AS IssuerDomicileDomesticYN, 
			COALESCE( CAST(ISSUER.FeeCode AS CHAR(4)), DwhIssuer.FeeCodeName ) AS FeeCodeName 
 
		/* 
		INTO 
			XtOdsInstrumentEquityEtfUpdate 
		*/ 
 
		FROM 
			/* CURRENT DETAILS FROM XT INTERFACE */ 
				[dbo].[BestShare] SHARE 
			FULL OUTER JOIN 
				[dbo].[BestCompany] COMPANY 
			ON 
				SHARE.CompanyGID = COMPANY.GID 
			FULL OUTER JOIN 
				[dbo].[BestIssuer] ISSUER 
			ON COMPANY.IssuerGid = ISSUER.Gid 
 
			/* NEXT CHOICES FROM DWH FOR COMPANY / ISSUER */ 
			/* NEEDED FOR UPDATES TO EXISITNG SHARES WHERE THE COMPANY OR ISSUER HAS NOT CHNAGED */ 
			LEFT OUTER JOIN 
				dbo.DwhDimInstrumentEquityEtf DwhShare 
			ON  
				SHARE.Gid = DwhShare.InstrumentGlobalID 
			AND 
				DwhShare.CurrentRowYN = 'Y' 
 
			OUTER APPLY 
			( 
				SELECT 
					TOP 1 
					IC.CompanyListedDate, 
					IC.CompanyApprovalDate, 
					IC.TransparencyDirectiveYN, 
					IC.MarketAbuseDirectiveYN, 
					IC.ProspectusDirectiveYN, 
					IC.PrimaryBusinessSector, 
					IC.SubBusinessSector1, 
					IC.SubBusinessSector2, 
					IC.SubBusinessSector3, 
					IC.SubBusinessSector4, 
					IC.SubBusinessSector5 
				FROM 
					dbo.DwhDimInstrumentEquityEtf IC 
				WHERE 
					ISNULL( SHARE.CompanyGid, DwhShare.CompanyGlobalID ) = IC.CompanyGlobalID 
				ORDER BY 
					IC.InstrumentID DESC 
			) AS DwhCompany 
 
			OUTER APPLY 
			( 
				SELECT 
					TOP 1 
					IC.IssuerGlobalID, 
					IC.IssuerName, 
					IC.IssuerDomicile, 
					IC.FinancialYearEndDate, 
					IC.IncorporationDate, 
					IC.LegalStructure, 
					IC.AccountingStandard, 
					IC.TransparencyDirectiveHomeMemberCountry, 
					IC.ProspectusDirectiveHomeMemberCountry, 
					IC.IssuerDomicileDomesticYN, 
					IC.FeeCodeName	 
				FROM 
					dbo.DwhDimInstrumentEquityEtf IC 
				WHERE 
					ISNULL( SHARE.IssuerGid, DwhShare.IssuerGlobalID ) = IC.IssuerGlobalID 
				ORDER BY 
					IC.InstrumentID DESC 
			) AS Dwhissuer 
 
	WHERE 
		SHARE.Asset_Type IS NOT NULL 
 
 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[MdmSpecialDays]'
GO
CREATE TABLE [dbo].[MdmSpecialDays] 
( 
[SpecialDate] [date] NOT NULL, 
[HolidayYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradingStartTime] [time] NOT NULL, 
[TradingEndTime] [time] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_MdmSpecialDays] on [dbo].[MdmSpecialDays]'
GO
ALTER TABLE [dbo].[MdmSpecialDays] ADD CONSTRAINT [PK_MdmSpecialDays] PRIMARY KEY CLUSTERED  ([SpecialDate])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[MdmDateControl]'
GO
CREATE TABLE [dbo].[MdmDateControl] 
( 
[StartYear] [smallint] NOT NULL, 
[EndYear] [smallint] NOT NULL, 
[NormalTradingStartTime] [time] NOT NULL, 
[NormalTradingEndTime] [time] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetDates]'
GO
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 13/1/2017 
-- Description:	Return dataset to populate DimDate  
-- ============================================= 
CREATE PROCEDURE [dbo].[GetDates] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	DECLARE @StartYear INT 
	DECLARE @EndYear INT  
	DECLARE @TradingStartTime TIME 
	DECLARE @TradingEndTime TIME 
 
	/* GET DATES FROM CONTROL TABLE */ 
	SELECT 
		@StartYear = StartYear,  
		@EndYear = EndYear, 
		@TradingStartTime = NormalTradingStartTime, 
		@TradingEndTime = NormalTradingEndTime 
	FROM 
		[dbo].[MdmDateControl] 
 
	DECLARE @StartDate AS DATE 
	SET @StartDate = CAST(@StartYear AS CHAR(4)) + '0101'; 
 
 
	WITH dates AS ( 
		SELECT 
			@StartDate AS [date]  
		UNION ALL 
		SELECT 
			dateadd(day, 1, [date]) 
		FROM 
			[dates] 
		WHERE 
			YEAR([date]) <  @EndYear 
		) 
	SELECT  
		CAST(CONVERT(VARCHAR, d.[date], 112) AS INT) AS DateID, 
		LEFT(CONVERT(VARCHAR, d.[date], 103),20) AS DateText, 
		d.[date] as [Day], 
		CASE  
			WHEN  
				DATENAME(DW,d.[date]) in ('Saturday','Sunday') 
			--	OR NWD.NonWorkingDayDate IS NOT NULL 
			THEN 'N' 
			ELSE 'Y' 
		END AS WorkingDayYN, 
		CAST(YEAR(d.[date]) AS SMALLINT) AS [Year] , 
		CAST(MONTH(d.[date]) AS SMALLINT) AS MonthNo, 
		CAST(DATENAME(MONTH,d.[date]) AS CHAR(20)) AS MonthName, 
		CAST(DATENAME(QUARTER,d.[date]) AS SMALLINT) AS QuarterNo, 
		CAST('Q' + DATENAME(QUARTER,d.[date]) AS CHAR) AS QuarterText, 
		(YEAR(d.[date]) * 10) + DATEPART(QUARTER,d.[date]) AS YearQuarterNo, 
		CAST(DATENAME(YEAR,d.[date]) + ' Q' + DATENAME(QUARTER,d.[date]) AS CHAR) AS YearQuarterText, 
		CAST(DAY(d.[date]) AS SMALLINT) AS MonthDayNo, 
		CAST(DATENAME(DW,d.[date]) AS CHAR(20)) AS DayText, 
 
		CASE 
			WHEN  
					YEAR(d.[date])=YEAR(GETDATE())  
				AND  
					MONTH(d.[date])=MONTH(GETDATE())  
				AND DAY(d.[date])<=DAY(GETDATE()) 
			THEN 'Y' 
			ELSE 'N' 
		END AS MonthToDateYN, 
		CASE 
			WHEN YEAR(d.[date])=YEAR(GETDATE()) AND  
				(	 
						( MONTH(d.[date])<MONTH(GETDATE()) ) 
					OR 
						( MONTH(d.[date])=MONTH(GETDATE()) AND DAY(d.[date])<=DAY(GETDATE()) ) 
				) 
			THEN 'Y' 
			ELSE 'N' 
		END AS YearToDateYN, 
		ISNULL(SD.TradingStartTime,	@TradingStartTime) AS TradingStartTime, 
		ISNULL(SD.TradingEndTime, @TradingEndTime) AS TradingEndTime 
 
	FROM  
			dates d 
		LEFT OUTER JOIN 
			dbo.MdmSpecialDays SD 
		ON D.date = SD.SpecialDate 
	WHERE 
		YEAR(d.[date]) BETWEEN @StartYear AND @EndYear 
	OPTION (MAXRECURSION 0); 
 
 
 
 
 
 
END 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XtInterfaceUpdateTypes]'
GO
CREATE TABLE [dbo].[XtInterfaceUpdateTypes] 
( 
[InstrumentGlobalID] [varchar] (60) COLLATE Latin1_General_CI_AS NULL, 
[UpdateType] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetXtInterfaceUpdatesToApply]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 21/2/2017 
-- Description:	Get a list of updates tp apply to instrument dimension 
-- ============================================= 
CREATE PROCEDURE [dbo].[GetXtInterfaceUpdatesToApply] 
AS 
BEGIN 
	SET NOCOUNT ON; 
 
	TRUNCATE TABLE dbo.XtInterfaceUpdateTypes 
 
	INSERT INTO dbo.XtInterfaceUpdateTypes 
		SELECT 
			DISTINCT  
			InstrumentGlobalID, 
			'NEW' AS UpdateType 
		FROM 
			[dbo].[XtOdsInstrumentEquityEtfUpdate] F 
		WHERE 
			InstrumentGlobalID NOT IN ( 
					SELECT 
						InstrumentGlobalID 
					FROM 
						dbo.DwhDimInstrumentEquityEtf 
				) 
 
	INSERT INTO dbo.XtInterfaceUpdateTypes 
		SELECT 
			DISTINCT  
			F.InstrumentGlobalID, 
			'SCD-1' AS UpdateType 
		FROM 
				dbo.XtOdsInstrumentEquityEtfUpdate F 
			INNER JOIN 
				dbo.DwhDimInstrumentEquityEtf T 
			ON  
				F.InstrumentGlobalID = T.InstrumentGlobalID 
			AND  
				T.CurrentRowYN = 'Y' 
		WHERE 
			( 
				F.CompanyListedDate != T.CompanyListedDate 
			OR 
				F.CompanyApprovalType != T.CompanyApprovalType 
			OR 
				F.CompanyApprovalDate != T.CompanyApprovalDate 
			OR	 
				F.IncorporationDate != T.IncorporationDate 
			OR 
				F.IssuedDate != T.IssuedDate 
			OR 
				F.CFIName != T.CFIName 
			OR 
				F.CFICode != T.CFICode 
			OR 
				F.Note != T.Note 
			) 
 
	INSERT INTO dbo.XtInterfaceUpdateTypes 
		SELECT 
			DISTINCT  
			F.InstrumentGlobalID, 
			'SCD-2' AS UpdateType 
		FROM 
				dbo.XtOdsInstrumentEquityEtfUpdate F 
			INNER JOIN 
				dbo.DwhDimInstrumentEquityEtf T 
			ON  
				F.InstrumentGlobalID = T.InstrumentGlobalID 
			AND  
				T.CurrentRowYN = 'Y' 
		WHERE 
			( 
				F.InstrumentName != T.InstrumentName 
			OR  
				F.ISIN != T.ISIN 
			OR  
				F.SEDOL != T.SEDOL 
			OR  
				CAST(F.InstrumentStatusDate AS DATE) != T.InstrumentStatusDate 
--				F.InstrumentStatusDate != T.InstrumentStatusDate 
		--	OR F.InstrumentListedDate != T.InstrumentListedDate 
			OR 
				F.TradingSysInstrumentName != T.TradingSysInstrumentName 
			OR  
				F.IssuerName != T.IssuerName 
			OR  
				F.IssuerGlobalID != T.IssuerGlobalID 
			OR  
				F.CompanyGlobalID != T.CompanyGlobalID 
			OR  
				F.TransparencyDirectiveYN != T.TransparencyDirectiveYN 
			OR  
				F.MarketAbuseDirectiveYN != T.MarketAbuseDirectiveYN 
			OR  
				F.ProspectusDirectiveYN != T.ProspectusDirectiveYN 
			OR 
				F.IssuerDomicile != T.IssuerDomicile 
			OR  
				F.WKN != T.WKN 
			OR  
				F.MNEM != T.MNEM 
			OR  
				F.PrimaryBusinessSector != T.PrimaryBusinessSector 
			OR  
				F.SubBusinessSector1 != T.SubBusinessSector1 
			OR  
				F.SubBusinessSector2 != T.SubBusinessSector2 
			OR  
				F.SubBusinessSector3 != T.SubBusinessSector3 
			OR  
				F.SubBusinessSector4 != T.SubBusinessSector4 
			OR  
				F.SubBusinessSector5 != T.SubBusinessSector5 
			OR  
				F.OverallIndexYN != T.OverallIndexYN 
			OR  
				F.GeneralIndexYN != T.GeneralIndexYN 
			OR  
				F.FinancialIndexYN != T.FinancialIndexYN 
			OR  
				F.SmallCapIndexYN != T.SmallCapIndexYN 
			OR  
				F.ITEQIndexYN != T.ITEQIndexYN 
			OR  
				F.ISEQ20IndexYN != T.ISEQ20IndexYN 
		--	OR F.ESMIndexYN != T.ESMIndexYN 
			OR  
				F.PrimaryMarket != T.PrimaryMarket 
			OR  
				F.FinancialYearEndDate != T.FinancialYearEndDate 
			OR  
				F.LegalStructure != T.LegalStructure 
			OR  
				F.AccountingStandard != T.AccountingStandard 
			OR  
				F.TransparencyDirectiveHomeMemberCountry != T.TransparencyDirectiveHomeMemberCountry 
			OR  
				F.ProspectusDirectiveHomeMemberCountry != T.ProspectusDirectiveHomeMemberCountry 
			OR  
				F.IssuerDomicileDomesticYN != T.IssuerDomicileDomesticYN 
			OR  
				F.FeeCodeName != T.FeeCodeName 
			OR  
				F.UnitOfQuotation != T.UnitOfQuotation 
			OR  
				F.ISEQ20Freefloat != T.ISEQ20Freefloat 
			OR  
				F.ISEQOverallFreeFloat != T.ISEQOverallFreeFloat 
			OR  
				F.SecurityQualifier != T.SecurityQualifier 
			OR  
				F.IssuerSedolMasterFileName != T.IssuerSedolMasterFileName 
			--OR F.InstrumentDomesticYN != T.InstrumentDomesticYN 
			OR  
				F.InstrumentSedolMasterFileName != T.InstrumentSedolMasterFileName 
			--OR F.ExternalMarkets != T.ExternalMarkets 
			OR  
				F.TotalSharesInIssue != T.TotalSharesInIssue 
			OR  
				F.LastEXDivDateID != T.LastEXDivDateID	 
		) 
 
 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetXtOdsInstrumentEquityEtfUpdate]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 23/2/2017 
-- Description:	Get XT details preparted for DWH / ETL pipelins 
-- ============================================= 
CREATE PROCEDURE [dbo].[GetXtOdsInstrumentEquityEtfUpdate] AS 
BEGIN 
	SET NOCOUNT ON; 
 
	SELECT 
		InstrumentGlobalID,  
		InstrumentName,  
		InstrumentType,  
		SecurityType,  
		LEFT(ISIN,12) AS ISIN,  
		LEFT(SEDOL,7) AS SEDOL, 
		InstrumentStatusName,  
		InstrumentStatusDate,  
		TradingSysInstrumentName,  
		CompanyGlobalID,  
		MarketName,  
		LEFT(WKN,6) AS WKN, 
		LEFT(MNEM,4) AS MNEM,  
		GeneralIndexYN,  
		InstrumentListedDate,  
		InstrumentSedolMasterFileName,  
		ISEQ20IndexYN,  
		IssuerSedolMasterFileName,  
		ITEQIndexYN,  
		LastEXDivDateID,  
		OverallIndexYN,  
		SecurityQualifier,  
		FinancialIndexYN,  
		SmallCapIndexYN,  
		PrimaryMarket,  
		IssuedDate,  
		CurrencyISOCode,  
		UnitOfQuotation,  
		QuotationCurrencyISOCode,  
		ISEQ20Freefloat,  
		ISEQOverallFreeFloat,  
		CFIName,  
		CFICode,  
		TotalSharesInIssue,  
		CompanyListedDate,  
		CompanyApprovalDate,  
		CompanyApprovalType,  
		CompanyStatusName,  
		Note,  
		TransparencyDirectiveYN,  
		MarketAbuseDirectiveYN,  
		ProspectusDirectiveYN,  
		PrimaryBusinessSector,  
		SubBusinessSector1,  
		SubBusinessSector2,  
		SubBusinessSector3,  
		SubBusinessSector4,  
		SubBusinessSector5,  
		IssuerGlobalID,  
		IssuerName,  
		IssuerDomicile,  
		FinancialYearEndDate,  
		IncorporationDate,  
		LegalStructure,  
		AccountingStandard,  
		TransparencyDirectiveHomeMemberCountry,  
		ProspectusDirectiveHomeMemberCountry,  
		IssuerDomicileDomesticYN,  
		FeeCodeName 
	FROM 
		dbo.XtOdsInstrumentEquityEtfUpdate 
 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[FileRowCountValidationAlert]'
GO
CREATE TABLE [dbo].[FileRowCountValidationAlert] 
( 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[AlertTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[Reason] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[Action] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Saft_FileRowCount]'
GO
CREATE TABLE [dbo].[Saft_FileRowCount] 
( 
[DwhFileID] [int] NOT NULL, 
[RowCount] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Saft_TxSaft]'
GO
CREATE TABLE [dbo].[Saft_TxSaft] 
( 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[DwhFileID] [int] NULL, 
[A_MOD_TIMESTAMP] [datetime2] NULL, 
[A_TRADE_LINK_NO] [int] NULL, 
[A_SUB_TRANSACTION_NO] [int] NULL, 
[A_BUY_SELL_FLAG] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[A_ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[A_TRADE_TYPE] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[A_TRADE_DATE] [datetime2] NULL, 
[A_TRADE_TIMESTAMP] [datetime2] NULL, 
[A_OTC_TRADE_TIME] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[A_PRICE_CURRENCY] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_MATCH_PRICE_X] [decimal] (19, 6) NULL, 
[A_TRADE_SIZE_X] [decimal] (19, 6) NULL, 
[A_AUCTION_TRADE_FLAG] [varchar] (2) COLLATE Latin1_General_CI_AS NULL, 
[A_MEMBER_ID] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[A_ACCOUNT_TYPE] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_ORDER_TYPE] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_ORDER_RESTRICTION] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[A_ORDER_MARKET_VALUE] [decimal] (19, 6) NULL, 
[A_MEMBER_CTPY_ID] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[A_SETTLEMENT_DATE] [date] NULL, 
[A_SETTLEMENT_TYPE] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_MOD_REASON_CODE] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_INSERT_TIMESTAMP] [datetime2] NULL, 
[A_OTC_TRADE_FLAG_1] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_OTC_TRADE_FLAG_2] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_OTC_TRADE_FLAG_3] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_DEFERRED_IND] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[A_IND_PUBLICATION_TIME] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[A_TRADER_ID] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[A_BEST_BID_PRICE] [decimal] (19, 6) NULL, 
[A_BEST_ASK_PRICE] [decimal] (19, 6) NULL, 
[A_OFFICIAL_OPENING_PRICE] [decimal] (19, 6) NULL, 
[A_OFFICIAL_CLOSING_PRICE] [decimal] (19, 6) NULL, 
[A_TRADE_TIME_OCP] [datetime] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateFileRowCount]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 27/1/2016 
-- Description:	Validate file row counts 
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateFileRowCount] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
 
	DECLARE @RejectFile table(  
			FileName VARCHAR(50),  
			FileTag VARCHAR(50) 
		) 
   
	/* Files without row counts */ 
	UPDATE 
		dbo.FileList 
	SET 
		ProcessFileYN = 'R' 
	OUTPUT 
		inserted.FileName, 
		inserted.FileTag 
	INTO 
		@RejectFile 
	WHERE 
		[FileName] IN ( 
				SELECT 
					[FileName] 
				FROM 
					dbo.Saft_TxSaft 
				WHERE 
					DwhFileID NOT IN ( 
							SELECT 
								DwhFileID 
							FROM 
								dbo.Saft_FileRowCount 
						) 
				GROUP BY 
					[FileName] 
			) 
 
	/* Store alert details */ 
	INSERT INTO	 
			dbo.FileRowCountValidationAlert 
		( 
			FileName,  
			FileTag,  
			AlertTag,  
			Reason,  
			Action 
		) 
	SELECT 
		FileName, 
		FileTag, 
		'SAFT FILE WIHHOUT ROW COUNT', 
		'SAFT FILE [' + FileName + '] DOES NOT HAVE A ROW COUNT.', 
		'FILE REJECTED AND MOVED TO REJECT FOLDER.' 
	FROM 
		@RejectFile 
 
 
	/* EMPTY TEMP TBALE FOR NEXT VALIDATION RULE */ 
	DELETE @RejectFile  
 
 
 
	/* SAFT FILE RECEIVED WITH INCORRECT DATE */ 
	/* mark bad files as rejects!!!! */ 
	UPDATE 
		FL 
	SET 
		ProcessFileYN = 'R' 
	OUTPUT 
		inserted.FileName, 
		inserted.FileTag 
	INTO 
		@RejectFile 
	FROM 
			dbo.FileList FL 
		INNER JOIN 
		( 
			SELECT 
				FileName, 
				DwhFileID, 
				COUNT(*) AS CNT 
			FROM 
				[dbo].[Saft_TxSaft] 
			GROUP BY 
				FileName, 
				DwhFileID 
		) AS Saft 
		ON FL.FileName = Saft.FileName 
		INNER JOIN 
		( 
			SELECT 
				DwhFileID, 
				CAST([RowCount] AS INT) AS CNT 
			FROM 
				[dbo].[Saft_FileRowCount] 
		) AS RC 
		ON Saft.DwhFileID = RC.DwhFileID 
		AND Saft.CNT <> RC.CNT 		 
 
	 
	/* Store alert details */ 
	INSERT INTO	 
			dbo.FileRowCountValidationAlert 
		( 
			FileName,  
			FileTag,  
			AlertTag,  
			Reason,  
			Action 
		) 
	SELECT 
		FileName, 
		FileTag, 
		'SAFT FILE WITH INCORRECT ROW COUNT FOUND', 
		'SAFT FILE [' + FileName + '] FOUND IN SOURCE FOLDER WITH INCORRECT ROW COUNT.', 
		'FILE REJECTED AND MOVED TO REJECT FOLDER.' 
	FROM 
		@RejectFile 
 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Saft_PriceFileRowCount]'
GO
CREATE TABLE [dbo].[Saft_PriceFileRowCount] 
( 
[DwhFileID] [int] NOT NULL, 
[RowCount] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Saft_Price]'
GO
CREATE TABLE [dbo].[Saft_Price] 
( 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[DwhFileID] [int] NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[CURRENCY] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[PRICE_TIMESTAMP] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[PRICE_TIMESTAMP_NO] [int] NULL, 
[MOD_TIMESTAMP] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[PRICE_DATE] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[MARKET_PRICE_TYPE] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[BEST_BID_PRICE] [decimal] (19, 6) NULL, 
[BEST_ASK_PRICE] [decimal] (19, 6) NULL, 
[CLOSING_AUCT_BID_PRICE] [decimal] (19, 6) NULL, 
[CLOSING_AUCT_ASK_PRICE] [decimal] (19, 6) NULL, 
[INSERT_DATE] [varchar] (50) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[PriceFileRowCountValidationAlert]'
GO
CREATE TABLE [dbo].[PriceFileRowCountValidationAlert] 
( 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[AlertTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[Reason] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[Action] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidatePriceFileRowCount]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 2/2/2016 
-- Description:	Validate price file row counts 
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidatePriceFileRowCount] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
 
	DECLARE @RejectFile table(  
			FileName VARCHAR(50),  
			FileTag VARCHAR(50) 
		) 
   
	/* Files without row counts */ 
	UPDATE 
		dbo.FileList 
	SET 
		ProcessFileYN = 'R' 
	OUTPUT 
		inserted.FileName, 
		inserted.FileTag 
	INTO 
		@RejectFile 
	WHERE 
		[FileName] IN ( 
				SELECT 
					[FileName] 
				FROM	 
					dbo.Saft_Price 
				WHERE 
					DwhFileID NOT IN ( 
							SELECT 
								DwhFileID 
							FROM 
								dbo.Saft_PriceFileRowCount 
						) 
				GROUP BY 
					[FileName] 
			) 
 
	/* Store alert details */ 
	INSERT INTO	 
			dbo.PriceFileRowCountValidationAlert 
		( 
			FileName,  
			FileTag,  
			AlertTag,  
			Reason,  
			Action 
		) 
	SELECT 
		FileName, 
		FileTag, 
		'SAFT PRICE FILE WIHHOUT ROW COUNT', 
		'SAFT PRICE FILE [' + FileName + '] DOES NOT HAVE A ROW COUNT.', 
		'FILE REJECTED AND MOVED TO REJECT FOLDER.' 
	FROM 
		@RejectFile 
 
 
	/* EMPTY TEMP TBALE FOR NEXT VALIDATION RULE */ 
	DELETE @RejectFile  
 
 
 
	/* SAFT FILE RECEIVED WITH INCORRECT DATE */ 
	/* mark bad files as rejects!!!! */ 
	UPDATE 
		FL 
	SET 
		ProcessFileYN = 'R' 
	OUTPUT 
		inserted.FileName, 
		inserted.FileTag 
	INTO 
		@RejectFile 
	FROM 
			dbo.FileList FL 
		INNER JOIN 
		( 
			SELECT 
				FileName, 
				DwhFileID, 
				COUNT(*) AS CNT 
			FROM 
				dbo.Saft_Price 
			GROUP BY 
				FileName, 
				DwhFileID 
		) AS Saft 
		ON FL.FileName = Saft.FileName 
		INNER JOIN 
		( 
			SELECT 
				DwhFileID, 
				CAST([RowCount] AS INT) AS CNT 
			FROM 
				dbo.Saft_PriceFileRowCount 
		) AS RC 
		ON Saft.DwhFileID = RC.DwhFileID 
		AND Saft.CNT <> RC.CNT 		 
 
	 
	/* Store alert details */ 
	INSERT INTO	 
			dbo.FileRowCountValidationAlert 
		( 
			FileName,  
			FileTag,  
			AlertTag,  
			Reason,  
			Action 
		) 
	SELECT 
		FileName, 
		FileTag, 
		'SAFT PRICE FILE WITH INCORRECT ROW COUNT FOUND', 
		'SAFT PRICE FILE [' + FileName + '] FOUND IN SOURCE FOLDER WITH INCORRECT ROW COUNT.', 
		'FILE REJECTED AND MOVED TO REJECT FOLDER.' 
	FROM 
		@RejectFile 
 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[FileValidationAlert]'
GO
CREATE TABLE [dbo].[FileValidationAlert] 
( 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[AlertTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[Reason] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[Action] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateSaftFileDate]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 16/1/2016 
-- Description:	Validate SAFT file dates 
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateSaftFileDate] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
 
	DECLARE @RejectFile table(  
			FileName VARCHAR(50),  
			FileTag VARCHAR(50) 
		) 
   
	/* SAFT FILE RECEIVED WITH INCORRECT DATE */ 
	/* mark bad files as rejects!!!! */ 
	UPDATE 
		dbo.FileList 
	SET 
		ProcessFileYN = 'R' 
	OUTPUT 
		inserted.FileName, 
		inserted.FileTag 
	INTO 
		@RejectFile 
	WHERE 
			ProcessFileYN = 'Y'	 
		AND 
			FileTag IN ( 'TxSaft', 'PriceFile' ) 
		AND 
			LEFT(REPLACE(FileName,FilePrefix,''),8) <> CONVERT(CHAR(8),GETDATE(),112) 
	 
	/* Store alert details */ 
 
	INSERT INTO	 
			FileValidationAlert 
		( 
			FileName,  
			FileTag,  
			AlertTag,  
			Reason,  
			Action 
		) 
	SELECT 
		FileName, 
		FileTag, 
		'SAFT FILE INCORRECT DATE', 
		'SAFT FILE [' + FileName + '] FOUND IN SOURCE FOLDER.', 
		'FILE REJECTED AND MOVED TO REJECT FOLDER.' 
	FROM 
		@RejectFile 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SAFT_MaxFileLetter]'
GO
CREATE TABLE [dbo].[SAFT_MaxFileLetter] 
( 
[SaftFileLetter] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateSaftFileOrder]'
GO
 
 
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 16/1/2016 
-- Description:	Validate SAFT files-  ensur files are received in order 
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateSaftFileOrder] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
 
	DECLARE @RejectFile table(  
			FileName VARCHAR(50),  
			FileTag VARCHAR(50) 
		) 
   
 
	/* OUT OF ORDER FILE */ 
	/* ONLY CHECKS IF THE CURRENT FILE IS EARLIER OR THE SAME AS A FILE ALREADY PROCESSED */ 
	/*	DOES NOT CHECK IF A FILE WAS SKIPPED */ 
	/*	COVERS DUPLICTATES FILES */ 
 
	/* mark bad files as rejects!!!! */ 
 
	/* SHOULD COME FROM DHW */ 
	DECLARE @MostRecentFileToday CHAR(1)  
	SELECT 
		@MostRecentFileToday = SaftFileLetter 
	FROM 
		dbo.SAFT_MaxFileLetter 
 
	UPDATE 
		dbo.FileList 
	SET 
		ProcessFileYN = 'R' 
	OUTPUT 
		inserted.FileName, 
		inserted.FileTag 
	INTO 
		@RejectFile 
	FROM 
		dbo.FileList 
	WHERE 
		FileTag IN ( 'TxSaft', 'PriceFile' ) 
	AND 
		SUBSTRING(REPLACE(FileName,FilePrefix,''),9,1) <= @MostRecentFileToday 
	AND 
		ProcessFileYN = 'Y' 
 
	 
	/* Store alert details */ 
 
	INSERT INTO	 
			FileValidationAlert 
		( 
			FileName,  
			FileTag,  
			AlertTag,  
			Reason,  
			Action 
		) 
	SELECT 
		FileName, 
		FileTag, 
		'SAFT FILE RECEIVED OUT OF ORDER', 
		'SAFT FILE [' + FileName + '] FOUND IN SOURCE FOLDER WHEN A LATER FILE HAS ALREADY BEEN LOADED.', 
		'FILE REJECTED AND MOVED TO REJECT FOLDER.' 
	FROM 
		@RejectFile 
END 
 
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateSaftMatchingPair]'
GO
 
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 16/1/2016 
-- Description:	Validate SAFT files-  both sides of trade and price file pair exist 
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateSaftMatchingPair] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
 
	DECLARE @RejectFile table(  
			FileName VARCHAR(50),  
			FileTag VARCHAR(50) 
		) 
   
 
	/* TRADE FILE WIHTOUT MATCHING PRICE FILE */ 
	/* mark bad files as rejects!!!! */ 
 
	UPDATE 
		dbo.FileList 
	SET 
		ProcessFileYN = 'R' 
	OUTPUT 
		inserted.FileName, 
		inserted.FileTag 
	INTO 
		@RejectFile 
	WHERE 
		FileName IN ( 
				SELECT 
					ISNULL(T.FileName, P.FileName) AS FileName 
				FROM 
					( 
						SELECT 
							FileName, 
							/* Stub includes data and letter */ 
							REPLACE(FileName,FilePrefix,'') AS TradeStub 
						FROM 
							dbo.FileList 
						WHERE 
							FileTag =  'TxSaft' 
					) AS T 
					FULL OUTER JOIN 
					( 
						SELECT 
							FileName, 
							/* Stub includes data and letter */ 
							REPLACE(FileName,FilePrefix,'') AS PriceStub 
						FROM 
							dbo.FileList 
						WHERE 
							FileTag =  'PriceFile' 
					) AS P	 
					ON T.TradeStub = P.PriceStub 
				WHERE 
					/* NULL ENTRY ON EITHER SIDE */ 
						T.FileName IS NULL 
					OR 
						P.FileName IS NULL 
			) 
		AND 
			ProcessFileYN = 'Y' 
 
	 
	/* Store alert details */ 
 
	INSERT INTO	 
			FileValidationAlert 
		( 
			FileName,  
			FileTag,  
			AlertTag,  
			Reason,  
			Action 
		) 
	SELECT 
		FileName, 
		FileTag, 
		'SAFT FILE INCOMPLETE PAIR', 
		'SAFT FILE [' + FileName + '] FOUND IN SOURCE FOLDER WITHOUT MATCHING FILE.', 
		'FILE REJECTED AND MOVED TO REJECT FOLDER.' 
	FROM 
		@RejectFile 
END 
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XtInterfaceEmergencyFixes]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 23/2/2017 
-- Description:	Apply emergenvy fixes to XT details before pushing ito DWH 
-- ============================================= 
CREATE PROCEDURE [dbo].[XtInterfaceEmergencyFixes]  
 
AS 
BEGIN 
	SET NOCOUNT ON; 
 
 
	UPDATE 
		dbo.XtOdsInstrumentEquityEtfUpdate 
	SET 
		SecurityType = ISNULL(SecurityType, 'UNKNOWN'), 
		InstrumentStatusDate = ISNULL( InstrumentStatusDate, '19900101'), 
		TradingSysInstrumentName = ISNULL(TradingSysInstrumentName, 'UNKNOWN'), 
		MarketName = ISNULL(MarketName, 'UNK'), 
		SEDOL = ISNULL(SEDOL,'UNKNOWN'), 
		WKN = ISNULL(WKN, 'UNK'), 
		MNEM = ISNULL(MNEM, 'UNKNOWN'), 
		FinancialIndexYN = ISNULL(FinancialIndexYN, 'X'), 
		PrimaryMarket = ISNULL(PrimaryMarket, 'UNKNOWN'), 
		IssuedDate ='19900101', 
		CurrencyISOCode = ISNULL(CurrencyISOCode, 'UNK'), 
		QuotationCurrencyISOCode = ISNULL(QuotationCurrencyISOCode, 'UNK'), 
		ISEQ20Freefloat = ISNULL(ISEQ20Freefloat, 0), 
		ISEQOverallFreeFloat = ISNULL(ISEQOverallFreeFloat, 0), 
		CFIName = ISNULL(CFIName, 'UNKNOWN'), 
		CFICode = ISNULL(CFICode, 'UNKNOWN'), 
		TotalSharesInIssue = ISNULL(TotalSharesInIssue, 0), 
		CompanyListedDate = ISNULL(CompanyListedDate, '19900101'), 
		CompanyApprovalDate = ISNULL(CompanyApprovalDate, '19900101'), 
		CompanyStatusName = ISNULL(CompanyStatusName, 'UNKNOWN'), 
		Note = ISNULL( Note, ''), 
		PrimaryBusinessSector = ISNULL(PrimaryBusinessSector,''),  
		SubBusinessSector1 = ISNULL(SubBusinessSector1, ''), 
		SubBusinessSector2 = ISNULL(SubBusinessSector2, ''), 
		SubBusinessSector3 = ISNULL(SubBusinessSector3, ''), 
		SubBusinessSector4 = ISNULL(SubBusinessSector4, ''), 
		SubBusinessSector5 = ISNULL(SubBusinessSector5, ''), 
		IssuerDomicile = ISNULL(IssuerDomicile , ''), 
		FinancialYearEndDate = ISNULL(FinancialYearEndDate, '19900101'), 
		IncorporationDate = ISNULL(IncorporationDate, '19900101'),  
		LegalStructure = ISNULL(LegalStructure, 'UNKNOWN'), 
		AccountingStandard = ISNULL(AccountingStandard, 'UNKNOWN'), 
		TransparencyDirectiveHomeMemberCountry = ISNULL(TransparencyDirectiveHomeMemberCountry, 'UNKNOWN'), 
		ProspectusDirectiveHomeMemberCountry = ISNULL(ProspectusDirectiveHomeMemberCountry, 'UNKNOWN'), 
		FeeCodeName = ISNULL(FeeCodeName, 'UNKNOWN' ), 
		IssuerName = ISNULL(IssuerName, 'UNKNOWN'), 
		IssuerDomicileDomesticYN = ISNULL(IssuerDomicileDomesticYN, 'UNKNOWN') 
 
 
 
 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DwhDimInstrument]'
GO
CREATE TABLE [dbo].[DwhDimInstrument] 
( 
[InstrumentID] [int] NOT NULL, 
[InstrumentGlobalID] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentName] [varchar] (256) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[SecurityType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[SEDOL] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentStatusID] [smallint] NOT NULL, 
[InstrumentStatusDateID] [int] NOT NULL, 
[InstrumentListedDateID] [int] NOT NULL, 
[IssuerName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerGlobalID] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketID] [smallint] NOT NULL, 
[IssuerDomicile] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[FinancialYearEndDateID] [int] NOT NULL, 
[IncorporationDateID] [int] NOT NULL, 
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[TransparencyDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProspectusDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuerDomicileDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[FeeCodeName] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[WKN] [varchar] (6) COLLATE Latin1_General_CI_AS NOT NULL, 
[MNEM] [varchar] (4) COLLATE Latin1_General_CI_AS NOT NULL, 
[IssuedDateID] [int] NOT NULL, 
[IssuerSedolMasterFileName] [varchar] (35) COLLATE Latin1_General_CI_AS NOT NULL, 
[CompanyGlobalID] [varchar] (40) COLLATE Latin1_General_CI_AS NULL, 
[CompanyApprovalDateID] [int] NOT NULL, 
[CompanyApprovalType] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentDomesticYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[InstrumentSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NOT NULL, 
[StartDate] [datetime2] NOT NULL, 
[EndDate] [datetime2] NULL, 
[CurrentRowYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[BatchID] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DwhDimStatus]'
GO
CREATE TABLE [dbo].[DwhDimStatus] 
( 
[StatusID] [smallint] NOT NULL, 
[StatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[T7TradeMainDataFlowOutput]'
GO
CREATE TABLE [dbo].[T7TradeMainDataFlowOutput] 
( 
[A_BUY_SELL_FLAG] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[A_ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[A_PRICE_CURRENCY] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_AUCTION_TRADE_FLAG] [varchar] (2) COLLATE Latin1_General_CI_AS NULL, 
[A_MEMBER_ID] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[A_ACCOUNT_TYPE] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_ORDER_TYPE] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_ORDER_RESTRICTION] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[A_MOD_REASON_CODE] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_OTC_TRADE_FLAG_1] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_OTC_TRADE_FLAG_2] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_OTC_TRADE_FLAG_3] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[A_TRADER_ID] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[TradeDateID] [int] NULL, 
[TradeTimeID] [smallint] NULL, 
[TradeTimestamp] [time] NULL, 
[UTCTradeTimeStamp] [time] NULL, 
[PublishDateID] [int] NULL, 
[PublishTimeID] [smallint] NULL, 
[TradingSysTransNo] [int] NULL, 
[TradePrice] [numeric] (19, 6) NULL, 
[BidPrice] [numeric] (19, 6) NULL, 
[OfferPrice] [numeric] (19, 6) NULL, 
[TradeVolume] [numeric] (19, 6) NULL, 
[TradeTurnover] [numeric] (19, 6) NULL, 
[DelayedTradeYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[DwhFileID] [int] NULL, 
[EquityTradeJunkID] [smallint] NULL, 
[InstrumentID] [int] NULL, 
[InstrumentType] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[BrokerID] [smallint] NULL, 
[TraderID] [smallint] NULL, 
[CurrencyID] [smallint] NULL, 
[TradeModificationTypeID] [smallint] NULL, 
[BatchID] [int] NULL, 
[CancelBatchID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TradeAggregationsFactEquityTradeSnapshot]'
GO
CREATE TABLE [dbo].[TradeAggregationsFactEquityTradeSnapshot] 
( 
[AggregateDate] [date] NULL, 
[AggregateDateID] [int] NULL, 
[InstrumentID] [int] NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentType] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[OCP] [numeric] (19, 6) NULL, 
[OCP_DATEID] [int] NULL, 
[OCP_TIME] [time] NULL, 
[OCP_TIME_ID] [int] NULL, 
[OOP] [numeric] (19, 6) NULL, 
[LastPriceTimeID] [smallint] NULL, 
[LastPrice] [numeric] (19, 6) NULL, 
[LowPrice] [int] NULL, 
[HighPrice] [int] NULL, 
[Deals] [int] NULL, 
[DealsOB] [int] NULL, 
[DealsND] [int] NULL, 
[TradeVolume] [int] NULL, 
[TradeVolumeOB] [int] NULL, 
[TradeVolumeND] [int] NULL, 
[Turnover] [numeric] (38, 6) NULL, 
[TurnoverOB] [numeric] (38, 6) NULL, 
[TurnoverND] [numeric] (38, 6) NULL, 
[TurnoverEur] [numeric] (38, 11) NULL, 
[TurnoverObEur] [numeric] (38, 11) NULL, 
[TurnoverNdEur] [numeric] (38, 11) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XT_UpdateControl]'
GO
CREATE TABLE [dbo].[XT_UpdateControl] 
( 
[TableName] [varchar] (11) COLLATE Latin1_General_CI_AS NULL, 
[ExtractSequenceId] [bigint] NULL, 
[LastChecked] [datetime2] NULL, 
[LastUpdated] [datetime2] NULL, 
[LastUpdateBatchID] [int] NULL, 
[XT_ExtractSequenceId] [bigint] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetTimes]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 13/1/2017 
-- Description:	Return dataset to populate DimTime 
-- ============================================= 
CREATE PROCEDURE [dbo].[GetTimes] 
AS 
BEGIN 
	SET NOCOUNT ON; 
 
	WITH TimesCTE AS 
		( 
			SELECT 
				cast('00:00:00:00' as time(2)) AS [time], 
				1 as [Timeid] 
		UNION ALL 
			SELECT  
				DATEADD(minute, 1, [time] ),[Timeid]+1 
		FROM  
			TimesCTE  
		WHERE  
 			timeid<1440 
		) 
		SELECT  
			CAST((DATEPART(HOUR,t.time)*100) + DATEPART(MINUTE,t.time) AS SMALLINT) TimeID, 
			t.time, 
			CONVERT(VARCHAR(2),t.[time],114) as LocalTimeHrText, 
			CONVERT(VARCHAR(5),t.[time],114) as LocalTimeMinText 
		FROM  
			TimesCTE t 
		OPTION (MAXRECURSION 0); 
 
 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateSaftMainDataFlow]'
GO
 
 
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 03/2/2016 
-- Description:	WIP 
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateSaftMainDataFlow] 
AS 
BEGIN 
	SET NOCOUNT ON; 
 
 
	SELECT  
		'ISIN NOT FOUND' AS QuarantineReasom, 
		[A_MEMBER_ID], 
		[A_ISIN], 
		[TradeDateID], 
		[TradingSysTransNo], 
		[A_BUY_SELL_FLAG], 
		[DwhFileID] 
	FROM  
		[dbo].[T7TradeMianDataFlowOutput] 
	WHERE 
		InstrumentID IS NULL 
	UNION ALL 
	SELECT  
		'BROKER NOT FOUND' AS QuarantineReasom, 
		[A_MEMBER_ID], 
		[A_ISIN], 
		[TradeDateID], 
		[TradingSysTransNo], 
		[A_BUY_SELL_FLAG], 
		[DwhFileID] 
	FROM  
		[dbo].[T7TradeMianDataFlowOutput] 
	WHERE 
		[BrokerID] IS NULL 
	UNION ALL 
	SELECT  
		'GENERIC BAD KEY' AS QuarantineReasom, 
		[A_MEMBER_ID], 
		[A_ISIN], 
		[TradeDateID], 
		[TradingSysTransNo], 
		[A_BUY_SELL_FLAG], 
		[DwhFileID] 
	FROM  
		[dbo].[T7TradeMianDataFlowOutput] 
	WHERE 
		/* 
			InstrumentID IS NULL 
		OR 
			[BrokerID] IS NULL 
		*/ 
			[TradeDateID] IS NULL 
		OR 
			[TradeTimeID] IS NULL 
		OR 
			[PublishDateID] IS NULL 
		OR 
			[PublishTimeID] IS NULL 
		OR 
			[EquityTradeJunkID] IS NULL 
		OR 
			[TraderID] IS NULL 
		OR 
			[CurrencyID] IS NULL 
		OR 
			[TradeModificationTypeID] IS NULL 
		OR 
			[DwhFileID] IS NULL 
		OR 
			[BatchID] IS NULL 
		OR 
			[CancelBatchID] IS NULL 
 
 
END 
 
 
 
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
