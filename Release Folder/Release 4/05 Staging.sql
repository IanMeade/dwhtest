/* 
Run this script on: 
 
        T7-DDT-06.Staging    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.Staging 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 28/04/2017 15:46:59 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [Staging]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XtOdsInstrumentEquityEtfUpdate]'
GO
CREATE TABLE [dbo].[XtOdsInstrumentEquityEtfUpdate] 
( 
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentName] [varchar] (450) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentType] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SecurityType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ISIN] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SEDOL] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentStatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentStatusDate] [datetime] NULL, 
[InstrumentListedDate] [datetime] NULL, 
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CompanyGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[MarketName] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[WKN] [varchar] (6) COLLATE Latin1_General_CI_AS NULL, 
[MNEM] [varchar] (4) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NULL, 
[IssuerSedolMasterFileName] [varchar] (300) COLLATE Latin1_General_CI_AS NULL, 
[ITEQIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[ISEQ20IndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[ESMIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[LastEXDivDate] [date] NULL, 
[GeneralIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[FinancialIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[OverallIndexYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[SmallCapIndexYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryMarket] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[IssuedDate] [datetime] NULL, 
[CurrencyISOCode] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[UnitOfQuotation] [numeric] (23, 10) NULL, 
[QuotationCurrencyISOCode] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[ISEQ20Freefloat] [numeric] (23, 10) NULL, 
[ISEQOverallFreeFloat] [numeric] (23, 10) NULL, 
[CFIName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CFICode] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[TotalSharesInIssue] [numeric] (28, 6) NULL, 
[CompanyListedDate] [datetime] NULL, 
[CompanyApprovalDate] [datetime] NULL, 
[CompanyApprovalType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[CompanyStatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Note] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL, 
[TransparencyDirectiveYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[MarketAbuseDirectiveYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ProspectusDirectiveYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[PrimaryBusinessSector] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector1] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector2] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector3] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector4] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[SubBusinessSector5] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[IssuerGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[IssuerName] [varchar] (300) COLLATE Latin1_General_CI_AS NULL, 
[IssuerDomicile] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[FinancialYearEndDate] [datetime] NULL, 
[IncorporationDate] [datetime] NULL, 
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[TransparencyDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[ProspectusDirectiveHomeMemberCountry] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[IssuerDomicileDomesticYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[FeeCodeName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DwhDimInstrumentEquityEtf]'
GO
CREATE TABLE [dbo].[DwhDimInstrumentEquityEtf] 
( 
[InstrumentID] [int] NULL, 
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentName] [varchar] (256) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[SecurityType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[SEDOL] [varchar] (7) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentStatusID] [smallint] NULL, 
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[IssuerName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[IssuerGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[IssuerStatusID] [smallint] NULL, 
[CompanyGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
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
[ISEQ20Freefloat] [numeric] (19, 6) NULL, 
[ISEQOverallFreeFloat] [numeric] (19, 6) NULL, 
[IssuerSedolMasterFileName] [varchar] (35) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentDomesticYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[CFIName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CFICode] [varchar] (6) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentSedolMasterFileName] [varchar] (40) COLLATE Latin1_General_CI_AS NULL, 
[TotalSharesInIssue] [numeric] (28, 6) NULL, 
[LastEXDivDate] [date] NULL, 
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
PRINT N'Creating [dbo].[ValidateXtInterfaceInstrumentType]'
GO
 
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 7/4/2017  
-- Description:	XT Interface validation - verfiy InstrumentType cannot change 
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateXtInterfaceInstrumentType]  
AS  
BEGIN  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	/* Result tables - empty table means no invalid rows found */  
	DECLARE @Messages TABLE ( Code INT, Message VARCHAR(1000) )  
  
	/* Instruments with no ISIN */  
	INSERT INTO   
			@Messages   
		(  
			Code,   
			Message   
		)  
		SELECT  
			456 As Code,  
			'XT InstrumentType change found. Existing instruments cannot change type. GID: [' + ISNULL(XT.InstrumentGlobalID,'') + '] already in DWH as [' + RTRIM(DWH.InstrumentType) + '] is in XT_ODS as [' + RTRIM(XT.InstrumentType) + ']' AS Message  
		FROM 
				XtOdsInstrumentEquityEtfUpdate XT 
			INNER JOIN 
				DwhDimInstrumentEquityEtf DWH 
			ON XT.InstrumentGlobalID = DWH.InstrumentGlobalID 
		WHERE 
			XT.InstrumentType <> DWH.InstrumentType 
 
  
	DELETE  
		XT 
	FROM 
			XtOdsInstrumentEquityEtfUpdate XT 
		INNER JOIN 
			DwhDimInstrumentEquityEtf DWH 
		ON XT.InstrumentGlobalID = DWH.InstrumentGlobalID 
	WHERE 
		XT.InstrumentType <> DWH.InstrumentType 
 
    
	/* RETURN ALL ERROR MESSAGES */  
	SELECT   
		Code,  
		Message  
	FROM  
		@Messages  
  
  
  
END  
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateXtInterfaceCompanyGID]'
GO
 
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 7/4/2017  
-- Description:	XT Interface validation - verfiy InstrumentType cannot change 
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateXtInterfaceCompanyGID]  
AS  
BEGIN  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	/* Result tables - empty table means no invalid rows found */  
	DECLARE @Messages TABLE ( Code INT, Message VARCHAR(1000) )  
  
	/* Instruments with no ISIN */  
	INSERT INTO   
			@Messages   
		(  
			Code,   
			Message   
		)  
		SELECT  
			467 As Code,  
			'XT company change found. Existing instruments cannot change company. Instrument GID: [' + ISNULL(XT.InstrumentGlobalID,'') + '] assigned to Company GID in DWH [' + RTRIM(DWH.CompanyGlobalID) + '] is assigned to Company GID [' + RTRIM(XT.CompanyGlobalID) + ']' AS Message  
		FROM 
				XtOdsInstrumentEquityEtfUpdate XT 
			INNER JOIN 
				DwhDimInstrumentEquityEtf DWH 
			ON XT.InstrumentGlobalID = DWH.InstrumentGlobalID 
		WHERE 
			XT.CompanyGlobalID <> DWH.CompanyGlobalID 
 
 
	DELETE  
		XT 
	FROM 
			XtOdsInstrumentEquityEtfUpdate XT 
		INNER JOIN 
			DwhDimInstrumentEquityEtf DWH 
		ON XT.InstrumentGlobalID = DWH.InstrumentGlobalID 
	WHERE 
		XT.CompanyGlobalID <> DWH.CompanyGlobalID 
 
    
	/* RETURN ALL ERROR MESSAGES */  
	SELECT   
		Code,  
		Message  
	FROM  
		@Messages  
  
  
  
END  
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XtOdsIssuer]'
GO
CREATE TABLE [dbo].[XtOdsIssuer] 
( 
[Name] [varchar] (300) COLLATE Latin1_General_CI_AS NULL, 
[Gid] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[SmfName] [varchar] (300) COLLATE Latin1_General_CI_AS NULL, 
[ExtractSequenceId] [bigint] NULL, 
[ExtractDate] [datetime] NULL, 
[MessageId] [varchar] (256) COLLATE Latin1_General_CI_AS NULL, 
[DateOfIncorporation] [datetime] NULL, 
[DebtorCode] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[DebtorCodeEquity] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[Domicile] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[DomicileDomesticFlag] [bit] NULL, 
[FeeCode] [int] NULL, 
[Td_Home_Member_Country] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[VatNumber] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[YearEnd] [datetime] NULL, 
[Pd_Home_Member_Country] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[Lei_Code] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[EUFlag] [bit] NULL, 
[IsoCode] [varchar] (2) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[BestIssuer]'
GO
  
  
   
CREATE VIEW [dbo].[BestIssuer] AS   
		SELECT   
			DISTINCT  
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
PRINT N'Creating [dbo].[ValidateXtInterfaceOptionalFieldWarning]'
GO
 
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 19/4/2017  
-- Description:	XT Interface validation - warning when optional fields are not populated - instruments are still allowed progress 
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateXtInterfaceOptionalFieldWarning]  
AS  
BEGIN  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	/* Simple XT Interface warnings */  
  
	/* Return warning - does not fix or remove nvalid entries */ 
  
	SELECT 
		501 As Code,  
		'WARNING: XT Instrument found with no SEDOL. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message  
	FROM 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE  
		ISNULL(	SEDOL, '' ) = '' 
	UNION 
	SELECT 
		502 As Code,  
		'WARNING: XT Instrument found with no TradingSysInstrumentName. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message  
	FROM 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE  
		ISNULL(	TradingSysInstrumentName, '' ) = '' 
	UNION 
	SELECT 
		503 As Code,  
		'WARNING: XT Instrument found with no CompanyListedDate. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message  
	FROM 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE  
		CompanyListedDate IS NULL 
	UNION 
	SELECT 
		504 As Code,  
		'WARNING: XT Instrument found with no CompanyApprovalType. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message  
	FROM 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE  
		ISNULL(	CompanyApprovalType, '' ) = '' 
	UNION 
	SELECT 
		505 As Code,  
		'WARNING: XT Instrument found with no CompanyApprovalDate. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message  
	FROM 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE  
		CompanyApprovalDate IS NULL 
	UNION 
	SELECT 
		506 As Code,  
		'WARNING: XT Instrument found with no WKN. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message  
	FROM 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE  
		ISNULL(	WKN, '' ) = '' 
	UNION 
	SELECT 
		507 As Code,  
		'WARNING: XT Instrument found with no MNEM. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message  
	FROM 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE  
		ISNULL(	MNEM, '' ) = '' 
	UNION 
	SELECT 
		508 As Code,  
		'WARNING: XT Instrument found with no PrimaryBusinessSector. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message  
	FROM 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE  
		ISNULL(	PrimaryBusinessSector, '' ) = '' 
	UNION 
	SELECT 
		509 As Code,  
		'WARNING: XT Instrument found with no PrimaryMarket. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message  
	FROM 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE  
		ISNULL(	PrimaryMarket, '' ) = '' 
  
  
END  
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XtOdsCompany]'
GO
CREATE TABLE [dbo].[XtOdsCompany] 
( 
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
[IssuedDate] [datetime] NULL, 
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
[IssuedShares] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentActualListedDate] [datetime] NULL, 
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CompanyGid] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[ExtractSequenceId] [bigint] NULL, 
[ExtractDate] [datetime] NULL, 
[MessageId] [varchar] (256) COLLATE Latin1_General_CI_AS NULL, 
[ISEQOverallFreeFloat] [numeric] (23, 10) NULL, 
[ISEQ20IndexFlag] [bit] NULL, 
[ESMIndexFlag] [bit] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[BestCompany]'
GO
  
  
   
	   
CREATE VIEW [dbo].[BestCompany] AS   
		SELECT   
			DISTINCT  
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
PRINT N'Creating [dbo].[MdmStatus]'
GO
CREATE TABLE [dbo].[MdmStatus] 
( 
[StatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[ConditionalTradingYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[ValidForEquity] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[MdmMarket]'
GO
CREATE TABLE [dbo].[MdmMarket] 
( 
[MarketCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[XtCode] [varchar] (20) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DwhDimCurrency]'
GO
CREATE TABLE [dbo].[DwhDimCurrency] 
( 
[CurrencyISOCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[CurrencyID] [smallint] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateXtInterfaceBasicLookups]'
GO
 
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 7/3/2017   
-- Description:	Basic XT Interface validation - misc lookups - bad data is removed from staging table   
-- =============================================   
CREATE PROCEDURE [dbo].[ValidateXtInterfaceBasicLookups]   
AS   
BEGIN   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
	/* Simple XT Interface validation checks */   
   
	/* SSILENTLY REMOVE EMPTY InstrumentGlobalID - SHOULD NOT BE POSSIBLE */ 
	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate    
	WHERE   
		ISNULL(InstrumentGlobalID, '') = '' 
 
	/* Result tables - empty table means no invalid rows found */   
	DECLARE @Messages TABLE ( Code INT, Message VARCHAR(2000), InstrumentGlobalID VARCHAR(30) )   
   
	/* Find invalid instruments */ 
 
	INSERT INTO  
			@Messages 
		SELECT   
			551 As Code,   
			'XT Instrument found with no InstrumentName. Instrument has not been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			ISNULL(InstrumentName,'') = '' 
		UNION 
		SELECT   
			552 As Code,   
			'XT Instrument found with no ISIN. Instrument has not been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			ISNULL(ISIN,'') = '' 
		UNION 
		SELECT   
			553 As Code,   
			'XT Instrument found with no Issuer Name. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			ISNULL(IssuerName,'') = ''  
		UNION 
		SELECT   
			554 As Code,   
			'XT Instrument found with no Issuer GID. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			ISNULL(IssuerGlobalID,'') = '' 
		UNION 
		SELECT   
			555 As Code,   
			'XT Instrument found with no Company GID. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			ISNULL(CompanyGlobalID,'') = ''  
		UNION 
		SELECT   
			556 As Code,   
			'XT Instrument found with missing Market. Verify MDM Market Table has correct XtCode entry. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			ISNULL(MarketName,'') = '' 
		UNION 
		SELECT   
			557 As Code,   
			'XT Instrument found with invalid Market. Verify MDM Market Table has correct XtCode entry. Instrument has not been processed. GID: ' + InstrumentGlobalID + ' Maket: ' + MarketName  AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			MarketName NOT IN (   
					SELECT   
						XtCode  
					FROM  
						dbo.MdmMarket  
					WHERE  
						XtCode IS NOT NULL  
				)   
		UNION 
		SELECT   
			558 As Code,   
			'XT Instrument found with missing InstrumentStatusName. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			ISNULL(InstrumentStatusName,'') = '' 
		UNION 
		SELECT   
			559 As Code,   
			'XT Instrument found with invalid InstrumentStatusName - not all status names are valid for Equity. Instrument has not been processed. GID: ' + InstrumentGlobalID + ' InstrumentStatusName: ' + InstrumentStatusName AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			InstrumentStatusName NOT IN ( 
						SELECT 
							StatusName 
						FROM 
							dbo.MdmStatus 
						WHERE 
							ValidForEquity = 'Y' 
					) 
		UNION 
		SELECT   
			560 As Code,   
			'XT Instrument found with missing InstrumentStatusDate. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			InstrumentStatusDate IS NULL 
		UNION 
		SELECT   
			561 As Code,   
			'XT Instrument found with missing InstrumentListedDate. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			InstrumentListedDate IS NULL 
		UNION 
		/* DISABLED FOR NOW - PROBABLY POPULATED IN EQ2 / CORPORATE ACTIONS */ 
		/* 
		SELECT   
			562 As Code,   
			'XT Instrument found with missing IssuedDate. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			IssuedDate IS NULL 
		UNION 
		*/ 
		SELECT   
			563 As Code,   
			'XT Instrument found without Currency. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			ISNULL(CurrencyISOCode,'') = '' 
		UNION 
		SELECT   
			564 As Code,   
			'XT Instrument found with invalid Currency. Instrument has not been processed. GID: ' + InstrumentGlobalID + 'Currency: ' + CurrencyISOCode AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			CurrencyISOCode NOT IN ( 
							SELECT 
								CurrencyISOCode 
							FROM 
								dbo.DwhDimCurrency 
					) 
		UNION 
		/* DISABLED FOR NOW - PROBABLY POPULATED IN EQ2 / CORPORATE ACTIONS */ 
		/* 
		SELECT   
			565 As Code,   
			'XT Instrument found with missing TotalSharesInIssue. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			TotalSharesInIssue IS NULL 
		UNION 
		*/ 
		SELECT   
			566 As Code,   
			'XT Instrument found with missing CompanyStatusName. Instrument has not been processed. GID: ' + InstrumentGlobalID AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			ISNULL(CompanyStatusName,'') = '' 
		UNION 
		SELECT   
			567 As Code,   
			'XT Instrument found with invalid CompanyStatusName. Instrument has not been processed. GID: ' + InstrumentGlobalID + ' CompanyStatusName: ' + CompanyStatusName AS Message, 
			InstrumentGlobalID 
		FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate    
		WHERE   
			CompanyStatusName NOT IN ( 
						SELECT 
							StatusName 
						FROM 
							dbo.MdmStatus 
					) 
 
	/*  Delete invalid instruments */ 
	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate    
	WHERE 
		InstrumentGlobalID IN ( 
				SELECT  
					InstrumentGlobalID 
				FROM  
					@Messages   
				) 
	   
	/* RETURN ALL ERROR MESSAGES */   
	SELECT    
		Code,   
		Message   
	FROM   
		@Messages   
   
     
END   
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XtOdsShare]'
GO
CREATE TABLE [dbo].[XtOdsShare] 
( 
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
[IssuedDate] [datetime] NULL, 
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
[IssuedShares] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentActualListedDate] [datetime] NULL, 
[TradingSysInstrumentName] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[CompanyGid] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[ExtractSequenceId] [bigint] NULL, 
[ExtractDate] [datetime] NULL, 
[MessageId] [varchar] (256) COLLATE Latin1_General_CI_AS NULL, 
[ISEQOverallFreeFloat] [numeric] (23, 10) NULL, 
[ISEQ20IndexFlag] [bit] NULL, 
[ESMIndexFlag] [bit] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[BestShare]'
GO
  
  
CREATE VIEW [dbo].[BestShare] AS   
		SELECT   
			DISTINCT  
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
PRINT N'Creating [dbo].[ValidateXtInterfacedWarningPlusFix]'
GO
 
 
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 19/4/2017  
-- Description:	XT Interface validation - warning when optional fields are not populated and are fixed by ETL - instruments are still allowed progress 
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateXtInterfacedWarningPlusFix]  
AS  
BEGIN  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	/* Simple XT Interface warnings - Return warning - and apples fix */ 
	SELECT 
		591 AS Code, 
		'WARNING: XT Instrument found with invalid QuotationCurrencyISOCode. Value has been set to UNKNONW and Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message  
	FROM 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE 
		QuotationCurrencyISOCode NOT IN 
					( 
						SELECT 
							CurrencyISOCode 
						FROM 
							DwhDimCurrency 
					) 
 
	/* FIX CURRENCY / FORCE TO UNKNOWN */ 
	UPDATE 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	SET 
		QuotationCurrencyISOCode = 'UNK' 
	WHERE 
		QuotationCurrencyISOCode NOT IN 
					( 
						SELECT 
							CurrencyISOCode 
						FROM 
							DwhDimCurrency 
					) 
 
		 
  
END  
 
 
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
   
	/* ASSEMBLE FULL INSTRUMENT EQUITY/ETF DETAILS FOR XT UPDATES IN CURRENT SET OF XT CHANGES */   
   
  
	;WITH  
		EquitySide AS (  
				/* Best copy of Equity side of things */  
				SELECT  
					'EQUITY' AS SRC,  
					SHARE.GID AS SHARE_GID,  
					COMPANY.GID AS COMPANY_GID,  
					ISSUER.GID AS ISSUER_GID,  
					DwhShare.InstrumentID AS DwhInstrumentID  
				FROM  
						[dbo].[BestShare] SHARE   
					LEFT OUTER JOIN   
						[dbo].[BestCompany] COMPANY   
					ON   
						SHARE.CompanyGID = COMPANY.GID   
					LEFT OUTER JOIN   
						[dbo].[BestIssuer] ISSUER   
					ON COMPANY.IssuerGid = ISSUER.Gid   
					LEFT OUTER JOIN   
						dbo.DwhDimInstrumentEquityEtf DwhShare   
					ON    
						SHARE.Gid = DwhShare.InstrumentGlobalID   
					AND   
						DwhShare.CurrentRowYN = 'Y'   
			),  
		CompanySide as (  
				SELECT  
					'COMPANY' AS SRC,  
					COMPANY.GID AS COMPANY_GID,  
					ISSUER.GID AS ISSUER_GID,  
					E.InstrumentID AS DwhInstrumentID	  
				FROM  
						[dbo].[BestCompany] COMPANY   
					INNER JOIN  
						dbo.DwhDimInstrumentEquityEtf E  
					ON COMPANY.Gid = E.CompanyGlobalID  
					AND   
						E.CurrentRowYN = 'Y'   
					LEFT OUTER JOIN   
						[dbo].[BestIssuer] ISSUER   
					ON COMPANY.IssuerGid = ISSUER.Gid   
				WHERE  
					E.InstrumentID NOT IN (  
							SELECT  
								DwhInstrumentID  
							FROM  
								EquitySide  
						)  
			),  
		IssuerSide as (  
				SELECT  
					'ISSUER' AS SRC,  
					ISSUER.GID AS ISSUER_GID,  
					E.InstrumentID AS DwhInstrumentID	  
				FROM  
						dbo.BestIssuer ISSUER   
					LEFT OUTER JOIN   
						dbo.DwhDimInstrumentEquityEtf E  
					ON ISSUER.Gid = E.IssuerGlobalID  
					AND   
						E.CurrentRowYN = 'Y'   
				WHERE  
					E.InstrumentID NOT IN (  
							SELECT  
								DwhInstrumentID  
							FROM  
								EquitySide  
						)  
			)  
	SELECT  
		SRC,  
		SHARE_GID,  
		COMPANY_GID,  
		ISSUER_GID,  
		DwhInstrumentID  
	INTO   
		#KEYS  
	FROM  
		EquitySide  
	UNION   
	SELECT  
		SRC,  
		NULL AS SHARE_GID,  
		COMPANY_GID,  
		ISSUER_GID,  
		DwhInstrumentID  
	FROM  
		CompanySide  
	UNION  
	SELECT  
		SRC,  
		NULL AS SHARE_GID,  
		NULL AS COMPANY_GID,  
		ISSUER_GID,  
		DwhInstrumentID  
	FROM  
		IssuerSide  
  
  
  
  
	INSERT INTO   
			dbo.XtOdsInstrumentEquityEtfUpdate   
		SELECT  
			/* This field should never be null */   
			COALESCE( SHARE.GID, DwhShare.InstrumentGlobalID ) AS InstrumentGlobalID,   
			COALESCE( SHARE.Name, DwhShare.InstrumentName ) AS InstrumentName,   
			COALESCE( SHARE.Asset_Type, DwhShare.InstrumentType ) AS InstrumentType,   
			COALESCE( SHARE.SecurityType, DwhShare.SecurityType, '' ) AS SecurityType,   
			COALESCE( SHARE.ISIN, DwhShare.ISIN ) AS ISIN,   
			/* DO IN PIPE / SOMEWHERE ELSE */   
			/*			InstrumentDomesticYN	*/  
			COALESCE( SHARE.SEDOL, DwhShare.SEDOL ) AS SEDOL,   
			COALESCE( SHARE.ListingStatus, DwhShare.InstrumentStatusName ) AS InstrumentStatusName,   
			COALESCE( SHARE.InstrumentStatusDate, DwhShare.InstrumentStatusDate ) AS InstrumentStatusDate,   
			COALESCE( SHARE.ListingDate, DwhShare.InstrumentListedDate ) AS InstrumentListedDate, 		  
			COALESCE( SHARE.TradingSysInstrumentName, DwhShare.TradingSysInstrumentName ) AS TradingSysInstrumentName,   
			COALESCE( SHARE.CompanyGID, DwhShare.CompanyGlobalID ) AS CompanyGlobalID,   
			COALESCE( SHARE.MarketType, DwhShare.MarketName ) AS MarketName,   
			COALESCE( SHARE.WKN, DwhShare.WKN ) AS	WKN,   
			COALESCE( SHARE.MNEM, DwhShare.MNEM ) AS MNEM,  
			COALESCE( SHARE.SmfName, DwhShare.InstrumentSedolMasterFileName ) AS InstrumentSedolMasterFileName,   
			COALESCE( ISSUER.SmfName, DwhShare.IssuerSedolMasterFileName ) AS IssuerSedolMasterFileName,   
			IIF(SHARE.IteqIndexFlag IS NOT NULL, IIF(SHARE.IteqIndexFlag = 1,'Y', 'N'), DwhShare.ITEQIndexYN ) AS ITEQIndexYN,   
			IIF(SHARE.ISEQ20IndexFlag IS NOT NULL, IIF(SHARE.ISEQ20IndexFlag = 1,'Y', 'N'), DwhShare.ISEQ20IndexYN ) AS ISEQ20IndexYN,   
			IIF(SHARE.ESMIndexFlag IS NOT NULL, IIF(SHARE.ESMIndexFlag = 1,'Y', 'N'), DwhShare.ESMIndexYN ) AS ESMIndexYN,   
			/* WILL COME FROM COROPORATE ACTIONS */  
			DwhShare.LastEXDivDate,  
			IIF(SHARE.GID IS NOT NULL, IIF(SHARE.GeneralFinancialFlag = 0, 'Y', 'N' ), DwhShare.GeneralIndexYN ) AS GeneralIndexYN,  
			IIF(SHARE.GID IS NOT NULL, IIF(SHARE.GeneralFinancialFlag = 1, 'Y', 'N' ), DwhShare.FinancialIndexYN ) AS FinancialIndexYN,  
			IIF(SHARE.GID IS NOT NULL, IIF(SHARE.GeneralFinancialFlag IS NOT NULL, 'Y', 'N' ), DwhShare.OverallIndexYN ) AS OverallIndexYN,  
			IIF(SHARE.SmallCap IS NOT NULL,IIF(SHARE.SmallCap = 1, 'Y', 'N' ), DwhShare.SmallCapIndexYN ) AS SmallCapIndexYN,   
			COALESCE( SHARE.PrimaryMarket, DwhShare.PrimaryMarket ) AS PrimaryMarket,   
			COALESCE( SHARE.IssuedDate, DwhShare.IssuedDate ) AS IssuedDate,   
			COALESCE( SHARE.DenominationCurrency, DwhShare.CurrencyISOCode ) AS CurrencyISOCode,   
			COALESCE( SHARE.UnitOfQuotation, DwhShare.UnitOfQuotation ) AS UnitOfQuotation,   
			COALESCE( SHARE.QuotationCurrency, DwhShare.QuotationCurrencyISOCode ) AS QuotationCurrencyISOCode,   
			COALESCE( SHARE.ISEQOverallFreeFloat, DwhShare.ISEQ20Freefloat ) AS ISEQ20Freefloat,   
			COALESCE( SHARE.ISEQOverallFreeFloat, DwhShare.ISEQOverallFreeFloat ) AS ISEQOverallFreeFloat,   
			COALESCE( SHARE.CFIName, DwhShare.CFIName ) AS CFIName,   
			COALESCE( SHARE.CFICode, DwhShare.CFICode ) AS CFICode,  
			COALESCE( SHARE.TotalSharesInIssue, DwhShare.TotalSharesInIssue ) AS TotalSharesInIssue,    
			COALESCE( COMPANY.ListingDate, DwhShare.CompanyListedDate ) AS CompanyListedDate,   
			COALESCE( COMPANY.ApprovalDate, DwhShare.CompanyApprovalDate ) AS CompanyApprovalDate,  
			COALESCE( COMPANY.ApprovalType, DwhShare.CompanyApprovalType ) AS CompanyApprovalType,   
			COALESCE( COMPANY.ListingStatus, DwhShare.CompanyStatusName ) AS CompanyStatusName,   
			COALESCE( SHARE.Note , DwhShare.Note ) AS Note,   
 			IIF(COMPANY.TDFlag IS NOT NULL, IIF(COMPANY.TDFlag = 1, 'Y','N') , DwhShare.TransparencyDirectiveYN ) AS TransparencyDirectiveYN,   
			IIF(COMPANY.MADFlag IS NOT NULL, IIF(COMPANY.MADFlag =1, 'Y','N'), DwhShare.MarketAbuseDirectiveYN ) AS MarketAbuseDirectiveYN,   
			IIF(COMPANY.PDFlag IS NOT NULL, IIF(COMPANY.PDFlag = 1, 'Y','N'), DwhShare.ProspectusDirectiveYN ) AS ProspectusDirectiveYN,   
			COALESCE( COMPANY.Sector, DwhShare.PrimaryBusinessSector ) AS PrimaryBusinessSector,   
			COALESCE( COMPANY.SubFocus1, DwhShare.SubBusinessSector1 ) AS SubBusinessSector1,   
			COALESCE( COMPANY.SubFocus2, DwhShare.SubBusinessSector2 ) AS SubBusinessSector2,   
			COALESCE( COMPANY.SubFocus3, DwhShare.SubBusinessSector3 ) AS SubBusinessSector3,   
			COALESCE( COMPANY.SubFocus4, DwhShare.SubBusinessSector4 ) AS SubBusinessSector4,   
			COALESCE( COMPANY.SubFocus5, DwhShare.SubBusinessSector5 ) AS SubBusinessSector5,   
			COALESCE( COMPANY.IssuerGid, ISSUER.Gid, DwhShare.IssuerGlobalID ) AS IssuerGlobalID,   
			COALESCE( ISSUER.Name, DwhShare.IssuerName ) AS IssuerName,   
			COALESCE( ISSUER.Domicile, DwhShare.IssuerDomicile ) AS IssuerDomicile,   
			COALESCE( ISSUER.YearEnd, DwhShare.FinancialYearEndDate ) AS FinancialYearEndDate,   
			COALESCE( ISSUER.DateofIncorporation, DwhShare.IncorporationDate ) AS IncorporationDate,   
			COALESCE( ISSUER.LegalStructure, DwhShare.LegalStructure ) AS LegalStructure,   
			COALESCE( ISSUER.AccountingStandard, DwhShare.AccountingStandard ) AS AccountingStandard,   
			COALESCE( ISSUER.TD_home_member_country, DwhShare.TransparencyDirectiveHomeMemberCountry ) AS TransparencyDirectiveHomeMemberCountry,   
			COALESCE( ISSUER.Pd_Home_Member_Country, DwhShare.ProspectusDirectiveHomeMemberCountry ) AS ProspectusDirectiveHomeMemberCountry,   
			IIF( ISSUER.DomicileDomesticFlag IS NOT NULL, IIF(ISSUER.DomicileDomesticFlag = 1,'Y', 'N'), DwhShare.IssuerDomicileDomesticYN) AS IssuerDomicileDomesticYN,   
			COALESCE( CAST(ISSUER.FeeCode AS CHAR(4)), DwhShare.FeeCodeName ) AS FeeCodeName   
	FROM  
			#Keys K  
		LEFT OUTER JOIN  
			[dbo].[BestShare] SHARE   
		ON   
			K.SHARE_GID = SHARE.GID  
		LEFT OUTER JOIN  
			[dbo].[BestCompany] COMPANY   
		ON   
			K.COMPANY_GID = COMPANY.GID   
		LEFT OUTER JOIN  
			[dbo].[BestIssuer] ISSUER   
		ON   
			K.ISSUER_GID = ISSUER.Gid   
		LEFT OUTER JOIN  
			dbo.DwhDimInstrumentEquityEtf DwhShare   
		ON  
			K.DwhInstrumentID  = DwhShare.InstrumentID  
/*  
	WHERE  
		COALESCE( SHARE.GID, DwhShare.InstrumentGlobalID, DwhShare.InstrumentGlobalID, DwhShare.InstrumentGlobalID ) IS NOT NULL  
*/  
	DROP TABLE #KEYS  
 
   
	/* MAKE EVERYTHING THAT IS NOT AN ETF AN EQUITY */ 
	/* COULD CAUSE ISSUES IF EquityStage IS POPULATED WITH NON-SHARE BASED INSTRUMENTS */ 
	UPDATE 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	SET 
		InstrumentType = 'Equity' 
	WHERE 
		InstrumentType NOT IN ( 'Equity', 'ETF' ) 
 
  
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
PRINT N'Creating [dbo].[MdmExtraDates]'
GO
CREATE TABLE [dbo].[MdmExtraDates] 
( 
[DateID] [int] NOT NULL, 
[DateText] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[Day] [date] NOT NULL, 
[WorkingDayYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[Year] [smallint] NOT NULL, 
[MonthNo] [smallint] NOT NULL, 
[MonthName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[QuarterNo] [smallint] NOT NULL, 
[QuarterText] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[YearQuarterNo] [int] NOT NULL, 
[YearQuarterText] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[MonthDayNo] [smallint] NOT NULL, 
[DayText] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[MonthToDateYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[YearToDateYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradingStartTime] [time] NOT NULL, 
[TradingEndTime] [time] NOT NULL 
)
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
			WHEN SD.HolidayYN IS NOT NULL AND SD.HolidayYN = 'Y' THEN 'N'  
			WHEN SD.HolidayYN IS NOT NULL AND SD.HolidayYN = 'N' THEN 'Y'  
			WHEN  DATENAME(DW,d.[date]) in ('Saturday','Sunday') THEN 'N'   
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
 
	UNION  
 
	SELECT 
		DateID,  
		DateText,  
		Day,  
		WorkingDayYN,  
		Year,  
		MonthNo,  
		MonthName,  
		QuarterNo,  
		QuarterText,  
		YearQuarterNo,  
		YearQuarterText,  
		MonthDayNo,  
		DayText,  
		MonthToDateYN,  
		YearToDateYN,  
		TradingStartTime,  
		TradingEndTime 
	FROM 
		dbo.MdmExtraDates 
	OPTION (MAXRECURSION 0);   
   
   
   
   
   
   
END   
   
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
PRINT N'Creating [dbo].[GetInstrumentStatusChanges]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 7/3/2017  
-- Description:	Get a list of instrument status chnages  
-- =============================================  
CREATE PROCEDURE [dbo].[GetInstrumentStatusChanges]  
AS  
BEGIN  
	SET NOCOUNT ON;  
  
	SELECT  
		O.GID,  
		UPPER(O.ListingStatus) AS StatusName,  
		UPPER(COALESCE(PrevState.ListingStatus, S.StatusName, 'New')) AS OldStatusName,  
		CASE   
			WHEN O.InstrumentStatusDate = '19000101' THEN -1  
			ELSE CAST(CONVERT(CHAR,O.InstrumentStatusDate,112) AS INT)   
		END AS InstrumemtStatusDateID,  
		CAST(REPLACE(LEFT(CONVERT(CHAR,O.InstrumentStatusDate,114),5),':','') AS SMALLINT) AS InstrumemtStatusTimeID,   
		CONVERT(TIME,O.InstrumentStatusDate) AS InstrumemtStatusTime,  
		CAST(CONVERT(CHAR,O.InstrumentStatusCreatedDatetime,112) AS INT) AS InstrumentStatusCreatedDateID,  
		CAST(REPLACE(LEFT(CONVERT(CHAR,O.InstrumentStatusCreatedDatetime,114),5),':','') AS SMALLINT) AS InstrumentStatusCreatedTimeID,  
		CONVERT(TIME,O.InstrumentStatusCreatedDatetime) AS InstrumentStatusCreatedTime  
	FROM  
			dbo.XtOdsShare O  
		/* ONLY PROCESS STATUS TYPES IN DWH */ 
		INNER JOIN 
			dbo.DwhDimStatus S1 
		ON O.ListingStatus = S1.StatusName 
		OUTER APPLY (  
			/* PREVIOUS STATE IN ODS SAMPLE */  
			SELECT  
				TOP 1  
				I.ListingStatus,  
				I.InstrumentStatusDate  
			FROM  
					dbo.XtOdsShare I  
				/* ONLY PROCESS STATUS TYPES IN DWH */ 
				INNER JOIN 
					dbo.DwhDimStatus S1 
				ON I.ListingStatus = S1.StatusName 
			WHERE  
				O.GID = I.GID  
			AND  
				O.ExtractSequenceId > I.ExtractSequenceId   
			ORDER BY  
				I.ExtractSequenceId DESC  
		) AS PrevState  
		/* CURRENT STATE IN DWH */  
		LEFT OUTER JOIN  
			dbo.DwhDimInstrumentEquityEtf DI  
		ON O.GID = DI.InstrumentGlobalID  
		AND DI.CurrentRowYN = 'Y'  
		LEFT OUTER JOIN  
			DwhDimStatus S  
		ON DI.InstrumentStatusID = S.StatusID  
	WHERE  
		O.ListingStatus <> COALESCE(PrevState.ListingStatus, S.StatusName, 'New' )  
  
END  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XtInterfaceUpdateTypes]'
GO
CREATE TABLE [dbo].[XtInterfaceUpdateTypes] 
( 
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
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
			dbo.XtOdsInstrumentEquityEtfUpdate F   
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
				F.SecurityType != T.SecurityType 
			OR  
				F.InstrumentStatusName != T.InstrumentStatusName 
			OR 
				CAST(F.InstrumentStatusDate AS DATE) != T.InstrumentStatusDate   
			OR  
				CAST(F.InstrumentListedDate AS DATE) != T.InstrumentListedDate   
			OR   
				CAST(F.CompanyListedDate AS DATE) != T.CompanyListedDate   
			OR   
				F.CompanyApprovalType != T.CompanyApprovalType   
			OR   
				F.CompanyApprovalDate != T.CompanyApprovalDate   
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
				F.FinancialYearEndDate != T.FinancialYearEndDate   
			OR	   
				F.IncorporationDate != T.IncorporationDate   
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
				F.IssuedDate != T.IssuedDate   
			OR   
				F.CurrencyISOCode != T.CurrencyISOCode  
			OR 
				F.UnitOfQuotation != T.UnitOfQuotation   
			OR 
				F.QuotationCurrencyISOCode != T.QuotationCurrencyISOCode 
			OR    
				F.IssuerSedolMasterFileName != T.IssuerSedolMasterFileName   
			OR    
				F.CFIName != T.CFIName   
			OR   
				F.CFICode != T.CFICode   
			OR   
				F.InstrumentSedolMasterFileName != T.InstrumentSedolMasterFileName   
			OR    
				F.CompanyStatusName != T.CompanyStatusName  
			OR    
				F.Note != T.Note   
			OR 
				F.CompanyGlobalID != T.CompanyGlobalID   
			OR  
				F.IssuerGlobalID != T.IssuerGlobalID   
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
				F.TradingSysInstrumentName != T.TradingSysInstrumentName   
			OR    
				F.IssuerName != T.IssuerName   
			OR    
				F.TransparencyDirectiveYN != T.TransparencyDirectiveYN   
			OR    
				F.MarketAbuseDirectiveYN != T.MarketAbuseDirectiveYN   
			OR    
				F.ProspectusDirectiveYN != T.ProspectusDirectiveYN   
			OR   
				F.MarketName != T.MarketName 
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
			OR   
				F.ESMIndexYN != T.ESMIndexYN   
			OR    
				F.PrimaryMarket != T.PrimaryMarket   
			OR    
				F.ISEQ20Freefloat != T.ISEQ20Freefloat   
			OR    
				F.ISEQOverallFreeFloat != T.ISEQOverallFreeFloat   
			OR    
				F.TotalSharesInIssue != T.TotalSharesInIssue   
		)   
   
   
END   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DwhDimMarket]'
GO
CREATE TABLE [dbo].[DwhDimMarket] 
( 
[MarketID] [smallint] NOT NULL, 
[MarketCode] [varchar] (15) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetXtOdsInstrumentEquityEtfUpdate]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 23/2/2017   
-- Description:	Get XT details prepared for DWH / ETL pipelins   
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
		InstrumentStatusDate,    
		TradingSysInstrumentName,    
		CompanyGlobalID,    
		I.MarketName,    
		LEFT(WKN,6) AS WKN,   
		LEFT(MNEM,4) AS MNEM,    
		GeneralIndexYN,    
		InstrumentListedDate,    
		LEFT(InstrumentSedolMasterFileName, 40) AS InstrumentSedolMasterFileName,    
		ISEQ20IndexYN,    
		LEFT(IssuerSedolMasterFileName, 40) AS IssuerSedolMasterFileName,  
		ITEQIndexYN,    
		LastEXDivDate,    
		OverallIndexYN,    
		FinancialIndexYN,    
		SmallCapIndexYN,    
		PrimaryMarket,    
		IssuedDate,    
		UnitOfQuotation,    
		ISEQ20Freefloat,    
		ISEQOverallFreeFloat,    
		CFIName,    
		CFICode,    
		TotalSharesInIssue,    
		CompanyListedDate,    
		CompanyApprovalDate,    
		CompanyApprovalType,    
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
		FeeCodeName,  
		ESMIndexYN,  
		IIF( LEFT(ISIN,2) = 'IE', 'Y', 'N' ) AS InstrumentDomesticYN, 
		ES.StatusID AS InstrumentStatusID, 
		CS.StatusID AS CompanyStatusID, 
		CC.CurrencyID AS CurrencyID, 
		QC.CurrencyID AS QuotationCurrencyID, 
		DM.MarketID 
	FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate I 
		INNER JOIN 
			dbo.DwhDimStatus ES 
		ON I.InstrumentStatusName = ES.StatusName 
		INNER JOIN 
			dbo.DwhDimStatus CS 
		ON I.CompanyStatusName = CS.StatusName 
		INNER JOIN 
			dbo.DwhDimCurrency CC  
		ON I.CurrencyISOCode = CC.CurrencyISOCode 
		INNER JOIN 
			dbo.DwhDimCurrency QC  
		ON I.QuotationCurrencyISOCode = QC.CurrencyISOCode 
		INNER JOIN 
			dbo.MdmMarket MM 
		ON I.MarketName = MM.XtCode 
		INNER JOIN 
			dbo.DwhDimMarket DM 
		ON MM.MarketCode = DM.MarketCode 
 
END   
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
PRINT N'Creating [dbo].[FileList]'
GO
CREATE TABLE [dbo].[FileList] 
( 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[ODS] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FilePrefix] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
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
PRINT N'Creating [dbo].[ValidateFileDelayedTradeTime]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 27/1/2016   
-- Description:	Validate file row counts   
-- =============================================   
CREATE PROCEDURE [dbo].[ValidateFileDelayedTradeTime]   
AS   
BEGIN   
	-- SET NOCOUNT ON added to prevent extra result sets from   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
   
	DECLARE @RejectFile table(    
			FileName VARCHAR(50),    
			FileTag VARCHAR(50)  
		)   
     
   /* Validates file in staging before it gets to ODS */  
  
	/* Files with invalid delayed trades */   
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
					A_DEFERRED_IND = 'Y'  
				AND  
					A_IND_PUBLICATION_TIME IS NULL					  
				GROUP BY   
					[FileName]   
			)   
   
 	   
	/* Return details to validation framework */   
	SELECT   
		189 AS Code,  
		'SAFT FILE WITH DELAYED TRADE WITHOUT DELAYED DATE AND TIME FOUND [' + FileName + ' - ' + CONVERT(CHAR(8),A_TRADE_DATE,112) + '\' + RTRIM(A_TRADE_LINK_NO) + '] FILE REJECTED AND MOVED TO REJECT FOLDER.' AS Message  
	FROM   
		dbo.Saft_TxSaft   
	WHERE  
		A_DEFERRED_IND = 'Y'  
	AND  
		A_IND_PUBLICATION_TIME IS NULL					  
	GROUP BY   
		[FileName],  
		A_TRADE_DATE,  
		A_TRADE_LINK_NO  
  
  
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
PRINT N'Creating [dbo].[DwhDimFile]'
GO
CREATE TABLE [dbo].[DwhDimFile] 
( 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateFileDuplicates]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 16/1/2016   
-- Description:	Validate file duplicates - only does saft and price  
-- =============================================   
CREATE PROCEDURE [dbo].[ValidateFileDuplicates]   
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
			FileName in (  
						SELECT  
							FileName  
						FROM  
							DwhDimFile  
					)  
  
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
		'Duplicate File found',   
		'File [' + FileName + '] is already in DHW',   
		'File rejected and moved to reject folder'   
	FROM   
		@RejectFile   
  
	SELECT  
		1 AS Code,  
		Message = 'Duplicate file found [' + FileName + '] is already in DWH. File rejected and moved to reject folder.'  
	FROM   
		@RejectFile   
  
END   
  
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
[PublishDateTime] [datetime] NULL, 
[UTCPublishDateTime] [datetime] NULL, 
[TradingSysTransNo] [int] NULL, 
[TradePrice] [numeric] (19, 6) NULL, 
[BidPrice] [numeric] (19, 6) NULL, 
[OfferPrice] [numeric] (19, 6) NULL, 
[TradeVolume] [numeric] (19, 6) NULL, 
[TradeTurnover] [numeric] (19, 6) NULL, 
[DelayedTradeYN] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[DwhFileID] [int] NULL, 
[EquityTradeJunkID] [smallint] NULL, 
[TradeType] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[InstrumentID] [int] NULL, 
[InstrumentType] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[StatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
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
PRINT N'Creating [dbo].[T7QuarantineTrade]'
GO
CREATE TABLE [dbo].[T7QuarantineTrade] 
( 
[TradeDateID] [int] NULL, 
[TradingSysTransNo] [int] NULL, 
[Code] [int] NOT NULL, 
[Message] [varchar] (265) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine_NoDeferredDateSet]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 28/4/2017  
-- Description: Validate T7TradeMainDataFlowOutput - move invalid rows into quarantine - Defered trade with no defered time specified 
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine_NoDeferredDateSet]  
AS  
BEGIN  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	TRUNCATE TABLE dbo.T7QuarantineTrade  
  
	INSERT INTO  
			dbo.T7QuarantineTrade  
		(  
			TradeDateID,  
			TradingSysTransNo,  
			Code,  
			Message  
		)  
		SELECT  
			TradeDateID,  
			TradingSysTransNo,  
			-99 AS Code,  
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Trade is marked DELAYED but PUBLISH TIME is not set.' AS Message  
		FROM  
			T7TradeMainDataFlowOutput  
		WHERE  
				DelayedTradeYN = 'Y' 
			AND 
				PublishDateTime IS NULL 
 
 
	/* Remove invalid rows from T7TradeMainDataFlowOutput */  
  
	DELETE  
		T7TradeMainDataFlowOutput  
	WHERE  
		EXISTS (  
					SELECT  
						*  
					FROM  
						dbo.T7QuarantineTrade Q  
					WHERE  
						T7TradeMainDataFlowOutput.TradingSysTransNo = Q.TradingSysTransNo  
					AND  
						T7TradeMainDataFlowOutput.TradeDateID = Q.TradeDateID   
			)  
  
	/* Return results to validation framework */  
	SELECT  
		Code,  
		Message  
	FROM  
		dbo.T7QuarantineTrade  
	WHERE 
		/* Only ones raised by this puppy */ 
		Code = -99 
		  
END  
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
  
	/* Integrate wih main validtion framework */  
	SELECT  
		99 AS Code,  
		'SAFT FILE WITH INCORRECT ROW COUNT FOUND [' + FileName + '] FILE REJECTED AND MOVED TO REJECT FOLDER.' AS Message  
	FROM  
  		@RejectFile   
  
END   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine_NegotiatedTradeWithoutDelay]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 28/4/2017  
-- Description: Validate T7TradeMainDataFlowOutput - move invalid rows into quarantine - Defered trade with no defered time specified 
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine_NegotiatedTradeWithoutDelay]  
AS  
BEGIN  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	TRUNCATE TABLE dbo.T7QuarantineTrade  
  
	INSERT INTO  
			dbo.T7QuarantineTrade  
		(  
			TradeDateID,  
			TradingSysTransNo,  
			Code,  
			Message  
		)  
		SELECT  
			TradeDateID,  
			TradingSysTransNo,  
			-199 AS Code,  
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Trade is marked NEGOTIATED DEAL but DEFERRED FLAG is not set.' AS Message  
		FROM  
				T7TradeMainDataFlowOutput  
		WHERE  
				TradeType = 'ND' 
			AND 
				DelayedTradeYN IS NULL 
 
 
	/* Remove invalid rows from T7TradeMainDataFlowOutput */  
  
	DELETE  
		T7TradeMainDataFlowOutput  
	WHERE  
		EXISTS (  
					SELECT  
						*  
					FROM  
						dbo.T7QuarantineTrade Q  
					WHERE  
						T7TradeMainDataFlowOutput.TradingSysTransNo = Q.TradingSysTransNo  
					AND  
						T7TradeMainDataFlowOutput.TradeDateID = Q.TradeDateID   
			)  
  
	/* Return results to validation framework */  
	SELECT  
		Code,  
		Message  
	FROM  
		dbo.T7QuarantineTrade  
	WHERE 
		/* Only ones raised by this puppy */ 
		Code = -199 
		  
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
PRINT N'Creating [dbo].[ProcessControlExpectedFileList]'
GO
CREATE TABLE [dbo].[ProcessControlExpectedFileList] 
( 
[ExpectedFileYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ExpectedFileName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ExpectedByTime] [time] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateRequiredFileError]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 8/3/2017  
-- Description:	Validate - required file error  
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateRequiredFileError]  
AS  
BEGIN  
	-- SET NOCOUNT ON added to prevent extra result sets from  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	SELECT  
		235 Code,  
		'Required file [' + ExpectedFileName + '] not found - timeout exceeeded. Process continuing.' AS Message  
	FROM  
		dbo.ProcessControlExpectedFileList  
	WHERE  
		ExpectedFilename NOT IN (  
			SELECT  
				LEFT(FileName,CHARINDEX('.',FileName)-1)  
			FROM  
				FileList  
				)  
	AND  
		ExpectedFileYN = 'Y'  
  
END  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateRequiredFileFound]'
GO
  
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 8/3/2017  
-- Description:	Validate - required file found - uses validation routine to send amessage  
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateRequiredFileFound]  
AS  
BEGIN  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	SELECT  
		235 Code,  
		'Required file [' + ExpectedFileName + '] found - processing continuing.' AS Message  
	FROM  
		dbo.ProcessControlExpectedFileList  
	WHERE  
		ExpectedFilename IN (  
			SELECT  
				LEFT(FileName,CHARINDEX('.',FileName)-1)  
			FROM  
				FileList  
				)  
	AND  
		ExpectedFileYN = 'Y'  
  
  
END  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateRequiredFilesExistWithWaitForDelayIncluded]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 8/3/2017  
-- Description:	validate that required files are present- includes delay  
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateRequiredFilesExistWithWaitForDelayIncluded]  
AS  
BEGIN  
	SET NOCOUNT ON;  
  
	DECLARE @TestCondition TINYINT = NULL  
	/*  
		@TestCondition   
			1 - ALL REQUIRED FULES FOUND  
			2 - FILE MiSSING -> RETRY  
			3 - FILE MISSING -> TIMEOUT EXCEEDED   
	*/  
  
  
	/* LIST OF EXPECTED FILES THAT HAVE NOT BEEN FOUND */  
	SELECT  
		ExpectedFileName,  
		ExpectedByTime  
	INTO  
		#RequiredFiles  
	FROM  
		dbo.ProcessControlExpectedFileList  
	WHERE  
		ExpectedFilename NOT IN (  
			SELECT  
				LEFT(FileName,CHARINDEX('.',FileName)-1)  
			FROM  
				FileList  
				)  
	AND  
		ExpectedFileYN = 'Y'  
  
	IF NOT EXISTS ( SELECT * FROM #RequiredFiles )  
	BEGIN  
		SET @TestCondition = 1  
	END  
	ELSE  
	IF EXISTS ( SELECT * FROM #RequiredFiles WHERE ExpectedByTime > CAST(GETDATE() AS TIME) )  
	BEGIN  
		WAITFOR  
			DELAY '00:00:10'  
		SET @TestCondition = 2  
	END  
	ELSE  
	BEGIN  
		SET @TestCondition = 3  
	END  
  
	DROP TABLE #RequiredFiles   
  
  
	/* RETURN RESULT */  
	SELECT  
			@TestCondition AS TestCondition   
	/*  
		@TestCondition   
			1 - ALL REQUIRED FULES FOUND  
			2 - FILE MiSSING -> RETRY  
			3 - FILE MISSING -> TIMEOUT EXCEEDED   
	*/  
  
END  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateRequiredFileWarning]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 8/3/2017  
-- Description:	Validate - required file warning  
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateRequiredFileWarning]  
AS  
BEGIN  
	-- SET NOCOUNT ON added to prevent extra result sets from  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	SELECT  
		234 Code,  
		'Required file [' + ExpectedFileName + '] not found - retry in 30 seconds.' AS Message  
	FROM  
		dbo.ProcessControlExpectedFileList  
	WHERE  
		ExpectedFilename NOT IN (  
			SELECT  
				LEFT(FileName,CHARINDEX('.',FileName)-1)  
			FROM  
				FileList  
				)  
	AND  
		ExpectedFileYN = 'Y'  
  
  
END  
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
  
	SELECT  
		1 AS Code,  
		Message = 'SAFT File has incorrect date [' + FileName + '] rejected and moved to reject folder.'  
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
-- Description:	Validate SAFT files-  ensure files are received in order   
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
  
  
	SELECT  
		1 AS Code,  
		Message = 'SAFT file received out of order. [' + FileName + '] found in source folder when a later file has already been loaded.'  
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
  
  
	SELECT   
		1 as Code,  
		Message = 'SAFT files incomplete pair found. [' + FileName + '] found in source without matching pair.'  
	FROM   
		@RejectFile   
  
  
END   
   
   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 8/3/2017  
-- Description: Validate T7TradeMainDataFlowOutput - move invalid rows into quarantine  
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine]  
AS  
BEGIN  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	TRUNCATE TABLE dbo.T7QuarantineTrade  
  
	INSERT INTO  
			dbo.T7QuarantineTrade  
		(  
			TradeDateID,  
			TradingSysTransNo,  
			Code,  
			Message  
		)  
		SELECT  
			TradeDateID,  
			TradingSysTransNo,  
			1 AS Code,  
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: ISIN [' + A_ISIN + '] could not be assigned to an instrument' AS Message  
		FROM  
			T7TradeMainDataFlowOutput  
		WHERE  
			InstrumentID IS NULL  
		UNION 
		SELECT  
			TradeDateID,  
			TradingSysTransNo,  
			2 AS Code,  
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Currency [' + A_PRICE_CURRENCY + '] could not be assigned' AS Message  
		FROM  
			T7TradeMainDataFlowOutput  
		WHERE  
			CurrencyID IS NULL  
		UNION 
		SELECT  
			TradeDateID,  
			TradingSysTransNo,  
			3 AS Code,  
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Junk dimension cannot be assigned. Check TradeSideCode, TradeOrderType, TradeOrderRestrictionCode, TradeType, PrincipalAgentCode, AuctionFlagCode and TradeFlags are valid and in MDM' AS Message  
		FROM  
			T7TradeMainDataFlowOutput  
		WHERE  
			EquityTradeJunkID IS NULL  
		UNION 
		SELECT  
			TradeDateID,  
			TradingSysTransNo,  
			4 AS Code,  
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Trade Modification Type [' + A_MOD_REASON_CODE + '] cannot be assigned. Check TradeSideCode, TradeOrderType, TradeOrderRestrictionCode, TradeType, PrincipalAgentCode, AuctionFlagCode and TradeFlags are valid and in MDM' AS Message  
		FROM  
			T7TradeMainDataFlowOutput  
		WHERE  
			TradeModificationTypeID IS NULL  
		UNION 
		SELECT  
			TradeDateID,  
			TradingSysTransNo,  
			5 AS Code,  
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Broker [' + A_MEMBER_ID + '] cannot be assigned. Check Broker is in MDM' AS Message  
		FROM  
			T7TradeMainDataFlowOutput  
		WHERE  
			BrokerID IS NULL  
		/* MOVED TO SEPERATE STORED PROCEDURE TO ALLOW CONTROL FROM PROCESS CONTROL */ 
		/* 
		UNION  
		SELECT  
			TradeDateID,  
			TradingSysTransNo,  
			6 AS Code,  
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Trade is marked DELAYED but PUBLISH TIME is not set.' AS Message  
		FROM  
			T7TradeMainDataFlowOutput  
		WHERE  
				DelayedTradeYN = 'Y' 
			AND 
				PublishDateTime IS NULL 
		*/ 
		UNION 
		SELECT  
			TradeDateID,  
			TradingSysTransNo,  
			6 AS Code,  
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: ISIN [' + A_ISIN + '] with Instrument Status [' + StatusName + '] is not supported .' AS Message  
		FROM  
			T7TradeMainDataFlowOutput  
		WHERE  
			StatusName NOT IN ( 'Listed', 'Conditional Dealings' ) 
		UNION 
		SELECT  
			TradeDateID,  
			TradingSysTransNo,  
			7 AS Code,  
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: ISIN [' + A_ISIN + '] with Instrument Type [' + InstrumentType + '] is not supported.' AS Message  
		FROM  
			T7TradeMainDataFlowOutput  
		WHERE  
			InstrumentType NOT IN ( 'EQUITY', 'ETF' ) 
 
	/* Second set of validation - removes trades without 2 rws in thetrade. Possible 1 row has been removed by validation above and left an orphan */ 
 	INSERT INTO  
			dbo.T7QuarantineTrade  
		(  
			TradeDateID,  
			TradingSysTransNo,  
			Code,  
			Message  
		)  
 
		SELECT 
			TradeDateID, 
			TradingSysTransNo, 
			101 as Code, 
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine. [' + STR(COUNT(*)) + '] rows in trade - expcected 2 (Buy and Sell).' AS Message  
		FROM  
			T7TradeMainDataFlowOutput  
		WHERE 
			A_MOD_REASON_CODE = '001' 
		GROUP BY 
			TradeDateID, 
			TradingSysTransNo 
		HAVING 
			COUNT(*) <> 2 
		 
 
		/* Remove invalid rows from T7TradeMainDataFlowOutput */  
  
		DELETE  
			T7TradeMainDataFlowOutput  
		WHERE  
			EXISTS (  
						SELECT  
							*  
						FROM  
							dbo.T7QuarantineTrade Q  
						WHERE  
							T7TradeMainDataFlowOutput.TradingSysTransNo = Q.TradingSysTransNo  
						AND  
							T7TradeMainDataFlowOutput.TradeDateID = Q.TradeDateID   
				)  
  
		/* Return results to validation framework */  
		SELECT  
			Code,  
			Message  
		FROM  
			dbo.T7QuarantineTrade  
  
  
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
   
	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE 
		ISIN IS NULL 
 
	DELETE 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	WHERE 
		IssuerGlobalID IS NULL 
   
	/* MAKE EVERYTHING THAT IS NOT AN ETF AN EQUITY */ 
	/* COULD CAUSE ISSUES IF EquityStage IS POPULATED WITH NON-SHARE BASED INSTRUMENTS */ 
	UPDATE 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	SET 
		InstrumentType = 'Equity' 
	WHERE 
		InstrumentType NOT IN ( 'Equity', 'ETF' ) 
 
	/* REPLACE NULLS WITH EMPTY STRINGS */ 
	UPDATE   
		dbo.XtOdsInstrumentEquityEtfUpdate   
	SET   
		SecurityType = ISNULL(SecurityType, ''), 
		ISIN = ISNULL(ISIN, ''), 
		SEDOL = ISNULL(SEDOL, ''), 
		TradingSysInstrumentName = ISNULL( TradingSysInstrumentName, ''), 
		CompanyApprovalType = ISNULL( CompanyApprovalType, ''), 
		TransparencyDirectiveYN = ISNULL( TransparencyDirectiveYN, ''), 
		MarketAbuseDirectiveYN = ISNULL( MarketAbuseDirectiveYN, ''), 
		ProspectusDirectiveYN = ISNULL( ProspectusDirectiveYN, ''), 
		IssuerDomicile = ISNULL( IssuerDomicile, ''), 
		WKN = ISNULL( WKN, ''), 
		MNEM = ISNULL( MNEM, ''), 
		PrimaryBusinessSector = ISNULL(PrimaryBusinessSector, ''), 
		SubBusinessSector1 = ISNULL(SubBusinessSector1, ''), 
		SubBusinessSector2 = ISNULL(SubBusinessSector2, ''), 
		SubBusinessSector3 = ISNULL(SubBusinessSector3, ''), 
		SubBusinessSector4 = ISNULL(SubBusinessSector4, ''), 
		SubBusinessSector5 = ISNULL(SubBusinessSector5, ''), 
		PrimaryMarket = ISNULL(PrimaryMarket, ''), 
		LegalStructure = ISNULL(LegalStructure, ''), 
		AccountingStandard = ISNULL(AccountingStandard, ''), 
		TransparencyDirectiveHomeMemberCountry = ISNULL(TransparencyDirectiveHomeMemberCountry, ''), 
		ProspectusDirectiveHomeMemberCountry = ISNULL(ProspectusDirectiveHomeMemberCountry, ''), 
		IssuerDomicileDomesticYN = ISNULL(IssuerDomicileDomesticYN, ''), 
		FeeCodeName = ISNULL(FeeCodeName, ''), 
		UnitOfQuotation = ISNULL(UnitOfQuotation, 0), 
		IssuerSedolMasterFileName = ISNULL(IssuerSedolMasterFileName, ''), 
		CFIName = ISNULL(CFIName, ''), 
		CFICode = ISNULL(CFICode, ''), 
		InstrumentSedolMasterFileName = ISNULL(InstrumentSedolMasterFileName, ''), 
		Note = ISNULL(Note, '') 
 
	/* EXPECT TO REMOVE IN EQ2 */ 
	UPDATE   
		dbo.XtOdsInstrumentEquityEtfUpdate   
	SET   
		TotalSharesInIssue = ISNULL(TotalSharesInIssue,0) 
 
   
   
END   
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateFindEarlyArrivingFacts]'
GO
 
   
   
   
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 4/4/2016   
-- Description:	Validate XT early arriving fatcs - look for reference details that have not been defined nad will be added by later stages 
-- =============================================   
CREATE PROCEDURE [dbo].[ValidateFindEarlyArrivingFacts] 
AS   
BEGIN   
	SET NOCOUNT ON;   
   
	/* MAKE SURE QUERY MATCHES THE QUERY USED TO ADD INFERRED CURRENCIES INTO THE DWH */ 
 
	SELECT 
		864 AS Code, 
		Message = 'Currency found in XT ODS that is not in the DWH Currency table. Currency [' + LEFT(Currency,3) + '] has been added to the dimension'  
	FROM 
		( 
			SELECT 
				DenominationCurrency AS Currency 
			FROM 
				BestCompany 
			WHERE 
				DenominationCurrency IS NOT NULL 
			UNION 
			SELECT 
				QuotationCurrency AS Currency 
			FROM 
				BestCompany 
			WHERE 
				DenominationCurrency IS NOT NULL 
			UNION 
			SELECT 
				DenominationCurrency AS Currency 
			FROM 
				BestShare 
			WHERE 
				DenominationCurrency IS NOT NULL 
			UNION 
			SELECT 
				QuotationCurrency AS Currency 
			FROM 
				BestShare 
			WHERE 
				QuotationCurrency IS NOT NULL 
		) AS X 
	WHERE 
		Currency NOT IN ( 
				SELECT 
					CurrencyISOCode 
				FROM 
					dbo.DwhDimCurrency 
			) 
 
END   
   
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[StateStreetISEQ20_DAILY_HOLDINGS]'
GO
CREATE TABLE [dbo].[StateStreetISEQ20_DAILY_HOLDINGS] 
( 
[ISIN_ETF] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[NAME] [varchar] (28) COLLATE Latin1_General_CI_AS NULL, 
[ColumnF] [int] NULL, 
[ColumnG] [real] NULL, 
[ColumnH] [real] NULL, 
[SharePercentage] [varchar] (50) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[StateStreet_ISEQ20_NAV]'
GO
CREATE TABLE [dbo].[StateStreet_ISEQ20_NAV] 
( 
[ValuationDateID] [int] NULL, 
[NAV_per_unit] [numeric] (19, 4) NULL, 
[Units_In_Issue] [numeric] (19, 2) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[StoxxIseq20Leveraged]'
GO
CREATE TABLE [dbo].[StoxxIseq20Leveraged] 
( 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[TRADE_DATE] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Eonia] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ISEQ 20 RETURN INDEX] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ISEQ 20 PRICE INDEX] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ISEQ LEVERAGED INDEX] [varchar] (50) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[StoxxIseq20Stats]'
GO
CREATE TABLE [dbo].[StoxxIseq20Stats] 
( 
[ID] [int] NOT NULL IDENTITY(1, 1), 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 0] [varchar] (300) COLLATE Latin1_General_CI_AS NULL, 
[Column 1] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 2] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 3] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 4] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 5] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 6] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 7] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 8] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 9] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 10] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 11] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 12] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 13] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 14] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 15] [varchar] (50) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[StoxxStats]'
GO
CREATE TABLE [dbo].[StoxxStats] 
( 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 0] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 1] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 2] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 3] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 4] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 5] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 6] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Column 7] [varchar] (50) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[T7QuarantineTradeCount]'
GO
CREATE TABLE [dbo].[T7QuarantineTradeCount] 
( 
[CNT] [int] NULL 
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
PRINT N'Creating [dbo].[ValidationResult]'
GO
CREATE TABLE [dbo].[ValidationResult] 
( 
[ErrorCount] [int] NULL, 
[Message1] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL 
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
PRINT N'Creating [dbo].[ValidateAlwaysFail]'
GO
  
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 1/3/2017  
-- Description:	Validation dummy routine - always fails  
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateAlwaysFail]  
AS  
BEGIN  
	SET NOCOUNT ON;  
  
	SELECT  
		CAST(99 AS INT) AS Code,  
		CAST('TEST FAILED' AS VARCHAR(1000)) AS Message  
  
  
END  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidateAlwaysPass]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 1/3/2017  
-- Description:	Validation dummy routine - always passes  
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateAlwaysPass]  
AS  
BEGIN  
	SET NOCOUNT ON;  
	  
	/* RETURN CORRECT RESULT TYPE WITH NO ROWS */  
  
	SELECT  
		0 AS Code,  
		'' AS Message  
	WHERE  
		1=2  
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
