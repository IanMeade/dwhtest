/* 
Run this script on: 
 
        T7-DDT-07.Stoxx_ODS    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.Stoxx_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 06/07/2017 09:57:55 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [Stoxx_ODS]
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
[FileDate] [date] NULL, 
[EtlVersion] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[Populated] [datetime2] NOT NULL CONSTRAINT [DF_File_Populated] DEFAULT (getdate()), 
[DwhStatus] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SetFileListFileDate]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 20/4/2017   
-- Description:	Set FileDate in FileList   
-- =============================================   
CREATE PROCEDURE [dbo].[SetFileListFileDate]   
	@FileID INT   
AS   
BEGIN   
	SET NOCOUNT ON;   
   
	UPDATE   
		FileList   
	SET   
		FileDate = (   
							SELECT   
								CAST(SUBSTRING(FileName,4,8) AS DATE) AS FileDate   
							FROM   
								FileList   
							WHERE   
								FileID = @FileID   
							AND   
								FileTag = 'STATS'   
							UNION ALL    
							SELECT   
								CAST(SUBSTRING(FileName,7,8)  AS DATE) AS FileDate   
							FROM   
								FileList   
							WHERE   
								FileID = @FileID   
							AND   
								FileTag = 'ISEQ20_STATS'   
							UNION ALL 
							SELECT   
								CAST(SUBSTRING(FileName,16,8) AS DATE) AS FileDate   
							FROM   
								FileList   
							WHERE   
								FileID = @FileID   
							AND   
								FileTag = 'ISEQ20_LEVERAGED'   
							UNION ALL 
							SELECT   
								CAST(SUBSTRING(FileName,25,8) AS DATE) AS FileDate   
							FROM   
								FileList   
							WHERE   
								FileID = @FileID   
							AND   
								FileTag = 'ISEQ_OVERALL_PRICE' 
							UNION ALL 
							SELECT   
								CAST(SUBSTRING(FileName,27,8) AS DATE) AS FileDate   
							FROM   
								FileList   
							WHERE   
								FileID = @FileID   
							AND   
								FileTag = 'ISEQ_SMALL_CAP_PRICE'  
							UNION ALL 
							SELECT 
								CAST(SUBSTRING(FileName,27,8) AS DATE) AS FileDate   
							FROM   
								FileList   
							WHERE   
								FileID = @FileID   
							AND   
								FileTag = 'ISEQ_SMALL_CAP_PRICE' 
				)   
	WHERE   
		FileID = @FileID   
   
END   
 
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Iseq20CappedPrice]'
GO
CREATE TABLE [dbo].[Iseq20CappedPrice] 
( 
[Date] [date] NULL, 
[TradingSymbol] [varchar] (14) COLLATE Latin1_General_CI_AS NULL, 
[Index] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[MarketCap] [numeric] (26, 2) NULL, 
[Kt] [numeric] (16, 8) NULL, 
[Constituents] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ConstantA] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[Value] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ReportingTradingSymbol] [varchar] (23) COLLATE Latin1_General_CI_AS NULL, 
[ReportingInstrument] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[Isin2] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[Sector] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[pi0] [numeric] (16, 8) NULL, 
[pit] [numeric] (16, 8) NULL, 
[qi0] [bigint] NULL, 
[qit] [bigint] NULL, 
[ffit] [numeric] (16, 8) NULL, 
[ci] [numeric] (16, 8) NULL, 
[MarketCapInMillions] [numeric] (16, 2) NULL, 
[Fi] [numeric] (16, 8) NULL, 
[Weight] [numeric] (16, 8) NULL, 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[FileID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Iseq20Leveraged]'
GO
CREATE TABLE [dbo].[Iseq20Leveraged] 
( 
[FileID] [int] NOT NULL, 
[TRADE_DATE] [date] NULL, 
[Eonia] [numeric] (5, 2) NULL, 
[ISEQ 20 RETURN INDEX] [numeric] (12, 2) NULL, 
[ISEQ 20 PRICE INDEX] [numeric] (12, 2) NULL, 
[ISEQ LEVERAGED INDEX] [numeric] (12, 2) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Iseq20Leveraged] on [dbo].[Iseq20Leveraged]'
GO
ALTER TABLE [dbo].[Iseq20Leveraged] ADD CONSTRAINT [PK_Iseq20Leveraged] PRIMARY KEY CLUSTERED  ([FileID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Iseq20Stats]'
GO
CREATE TABLE [dbo].[Iseq20Stats] 
( 
[FileID] [int] NOT NULL, 
[Nr] [smallint] NULL, 
[Code] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Share] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[Isin] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[pi0] [numeric] (6, 2) NULL, 
[pit] [numeric] (9, 4) NULL, 
[ciPerf] [numeric] (12, 6) NULL, 
[ciPrice] [numeric] (12, 6) NULL, 
[qi0] [numeric] (16, 0) NULL, 
[qit] [numeric] (16, 0) NULL, 
[ffit] [numeric] (9, 4) NULL, 
[MarketCap] [numeric] (16, 2) NULL, 
[Fi] [numeric] (12, 6) NULL, 
[Weight] [numeric] (12, 4) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Iseq20Stats] on [dbo].[Iseq20Stats]'
GO
ALTER TABLE [dbo].[Iseq20Stats] ADD CONSTRAINT [PK_Iseq20Stats] PRIMARY KEY CLUSTERED  ([FileID], [Isin])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[IseqOverallPrice]'
GO
CREATE TABLE [dbo].[IseqOverallPrice] 
( 
[Date] [date] NULL, 
[TradingSymbol] [varchar] (14) COLLATE Latin1_General_CI_AS NULL, 
[Index] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[MarketCap] [numeric] (26, 2) NULL, 
[Kt] [numeric] (16, 8) NULL, 
[Constituents] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ConstantA] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[Value] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ReportingTradingSymbol] [varchar] (23) COLLATE Latin1_General_CI_AS NULL, 
[ReportingInstrument] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[Isin2] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[Sector] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[pi0] [numeric] (16, 8) NULL, 
[pit] [numeric] (16, 8) NULL, 
[qi0] [bigint] NULL, 
[qit] [bigint] NULL, 
[ffit] [numeric] (16, 8) NULL, 
[ci] [numeric] (16, 8) NULL, 
[MarketCapInMillions] [numeric] (16, 2) NULL, 
[Fi] [numeric] (16, 8) NULL, 
[Weight] [numeric] (16, 8) NULL, 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[FileID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[IseqSmallCapPrice]'
GO
CREATE TABLE [dbo].[IseqSmallCapPrice] 
( 
[Date] [date] NULL, 
[TradingSymbol] [varchar] (14) COLLATE Latin1_General_CI_AS NULL, 
[Index] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[MarketCap] [numeric] (26, 2) NULL, 
[Kt] [numeric] (16, 8) NULL, 
[Constituents] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ConstantA] [varchar] (10) COLLATE Latin1_General_CI_AS NULL, 
[Value] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ReportingTradingSymbol] [varchar] (23) COLLATE Latin1_General_CI_AS NULL, 
[ReportingInstrument] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[Isin2] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[Sector] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[pi0] [numeric] (16, 8) NULL, 
[pit] [numeric] (16, 8) NULL, 
[qi0] [bigint] NULL, 
[qit] [bigint] NULL, 
[ffit] [numeric] (16, 8) NULL, 
[ci] [numeric] (16, 8) NULL, 
[MarketCapInMillions] [numeric] (16, 2) NULL, 
[Fi] [numeric] (16, 8) NULL, 
[Weight] [numeric] (16, 8) NULL, 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[FileID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[STATS]'
GO
CREATE TABLE [dbo].[STATS] 
( 
[FileID] [int] NOT NULL, 
[ISIN] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[VolatilityPercentage30Days] [numeric] (6, 2) NULL, 
[Correlation30Days] [numeric] (6, 2) NULL, 
[Beta30Days] [numeric] (6, 4) NULL, 
[Beta250Days] [numeric] (6, 4) NULL, 
[ClosingPriceValue] [numeric] (10, 4) NULL, 
[Fi] [numeric] (12, 6) NULL, 
[WeightPercentage] [numeric] (6, 2) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_STATS] on [dbo].[STATS]'
GO
ALTER TABLE [dbo].[STATS] ADD CONSTRAINT [PK_STATS] PRIMARY KEY CLUSTERED  ([FileID], [ISIN])
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
