/* 
Run this script on: 
 
        T7-DDT-06.StateStreet_ODS    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.StateStreet_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 15/05/2017 14:24:16 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [StateStreet_ODS]
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
[FileID] [int] NOT NULL IDENTITY(1, 1), 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[EtlVersion] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[Populated] [datetime2] NOT NULL CONSTRAINT [DF_File_Populated] DEFAULT (getdate()), 
[DwhStatus] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FileList] on [dbo].[FileList]'
GO
ALTER TABLE [dbo].[FileList] ADD CONSTRAINT [PK_FileList] PRIMARY KEY CLUSTERED  ([FileID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ISEQ20_DAILY_HOLDINGS]'
GO
CREATE TABLE [dbo].[ISEQ20_DAILY_HOLDINGS] 
( 
[FileID] [int] NOT NULL, 
[ISIN_ETF] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ISIN] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[NAME] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ColumnF] [int] NULL, 
[ColumnG] [real] NULL, 
[ColumnH] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[SharePercentage] [varchar] (50) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ISEQ20_DAILY_HOLDINGS] on [dbo].[ISEQ20_DAILY_HOLDINGS]'
GO
ALTER TABLE [dbo].[ISEQ20_DAILY_HOLDINGS] ADD CONSTRAINT [PK_ISEQ20_DAILY_HOLDINGS] PRIMARY KEY CLUSTERED  ([FileID], [ISIN])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ISEQ20_NAV]'
GO
CREATE TABLE [dbo].[ISEQ20_NAV] 
( 
[FIleID] [int] NOT NULL, 
[Umbrella_Name] [varchar] (25) COLLATE Latin1_General_CI_AS NULL, 
[Fund_Class] [varchar] (4) COLLATE Latin1_General_CI_AS NULL, 
[Valuation_Date] [datetime] NULL, 
[BASECurrency] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[QUOTCurrency] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[NAV_per_unit] [numeric] (19, 4) NULL, 
[Previous_NAV_per_unit] [numeric] (19, 4) NULL, 
[Change_in_NAV_per_unit] [numeric] (19, 4) NULL, 
[Change_Percent_in_NAV_per_unit] [numeric] (19, 4) NULL, 
[Client_Offer_Price] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Client_Offer_Percentage] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Income_Aktien] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Total_NAV_per_Class_Base_Ccy] [numeric] (19, 2) NULL, 
[Total_Net_Assets_per_Class_MIL] [numeric] (19, 2) NULL, 
[Units_In_Issue] [numeric] (19, 2) NULL, 
[DIV_Flag] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Cutas] [varchar] (6) COLLATE Latin1_General_CI_AS NULL, 
[FT] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[ISIN] [varchar] (14) COLLATE Latin1_General_CI_AS NULL, 
[BloombergTicker] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[VN] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[FMSedols] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[ISESedols] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[EuroClearCedel] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Bundesamt] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Sicovam] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[WM_ID925] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[WKN] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Aktiengewinn (KStG)] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[clio_fund_id] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Distribution_rate_per_share] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Accum_Deemed_Distrib] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Cap_Per_Unit] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Inc_Per_Unit] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Fund_Title] [varchar] (33) COLLATE Latin1_General_CI_AS NULL, 
[IFAST_account_number] [varchar] (4) COLLATE Latin1_General_CI_AS NULL, 
[IFAST_account_class] [smallint] NULL, 
[Income_Zwish] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[Unrounded_Quotations_NAV] [numeric] (19, 6) NULL, 
[Unrounded_Base_NAV] [numeric] (19, 6) NULL, 
[Exchange_Rate] [smallint] NULL, 
[ExpenseRatio] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[DividendtoMonthMethod] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[FundType] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[AccrualDate] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[MillRate] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[DailyDividend] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[DividendMonthtodate] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[DayYield1] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[DayYield7] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[DayYield30] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[MCH_account_number] [varchar] (4) COLLATE Latin1_General_CI_AS NULL, 
[MCH_account_class] [smallint] NULL, 
[Income_IG] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[Total_NAV_Per_Fund] [numeric] (19, 2) NULL, 
[Total_NAV_per_Class_Quot_Ccy] [numeric] (19, 2) NULL, 
[EndofRow] [varchar] (9) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ISEQ20_NAV] on [dbo].[ISEQ20_NAV]'
GO
ALTER TABLE [dbo].[ISEQ20_NAV] ADD CONSTRAINT [PK_ISEQ20_NAV] PRIMARY KEY CLUSTERED  ([FIleID])
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
