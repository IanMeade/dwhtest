/* 
Run this script on: 
 
        T7-DDT-07.DWH    -  This database will be modified 
 
to synchronize it with: 
 
        ..DWH 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 26/07/2017 15:55:40 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [DWH]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Report].[RawTcC810_NEW]'
GO
CREATE TABLE [Report].[RawTcC810_NEW] 
( 
[RawTc810_NEW_ID] [int] NOT NULL, 
[T7_ODS_FileListRawTcFileID] [int] NOT NULL, 
[exchNam] [varchar] (4) COLLATE Latin1_General_CI_AS NULL, 
[envText] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[rptCod] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[rptNam] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[rptFlexKey] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[membId] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[membLglNam] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[rptPrntEffDat] [datetime] NULL, 
[rptPrntEffTim] [datetime] NULL, 
[rptPrntRunDat] [datetime] NULL, 
[participant] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[partLngName] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[membClgIdCod] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[membCcpClgIdCod] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[settlAcct] [int] NULL, 
[settlCurr] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[sumMembTotBuyOrdr] [bigint] NULL, 
[sumMembTotSellOrdr] [bigint] NULL, 
[businessUnit] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[settlLocat] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[businessUnitId] [int] NULL, 
[sumPartTotBuyOrdr] [bigint] NULL, 
[sumPartTotSellOrdr] [bigint] NULL, 
[product] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[instrumentType] [tinyint] NULL, 
[instrumentId] [bigint] NULL, 
[instrumentMnemonic] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[isinCod] [varchar] (12) COLLATE Latin1_General_CI_AS NULL, 
[wknNo] [varchar] (6) COLLATE Latin1_General_CI_AS NULL, 
[instNam] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[time18] [datetime] NULL, 
[tradeType] [tinyint] NULL, 
[matchEvent] [int] NULL, 
[matchStep] [int] NULL, 
[matchDeal] [int] NULL, 
[parentDeal] [tinyint] NULL, 
[dealItem] [int] NULL, 
[tradeNumber] [int] NULL, 
[exchangeOrderId] [numeric] (20, 0) NULL, 
[versionNo] [tinyint] NULL, 
[acctTypGrp] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[buyCod] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[ordrPrtFilCod] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[execQty] [bigint] NULL, 
[execPrc] [numeric] (28, 10) NULL, 
[ordrTyp] [tinyint] NULL, 
[limOrdrPrc] [numeric] (28, 10) NULL, 
[timeValidity] [tinyint] NULL, 
[tradingRestriction] [tinyint] NULL, 
[settlAmnt] [numeric] (28, 10) NULL, 
[settlDat] [datetime] NULL, 
[ctrPtyId] [varchar] (5) COLLATE Latin1_General_CI_AS NULL, 
[userOrdrNum] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[text] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[kindOfDepo] [tinyint] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_RawTcC810_NEW] on [Report].[RawTcC810_NEW]'
GO
ALTER TABLE [Report].[RawTcC810_NEW] ADD CONSTRAINT [PK_RawTcC810_NEW] PRIMARY KEY CLUSTERED  ([T7_ODS_FileListRawTcFileID], [RawTc810_NEW_ID])
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
