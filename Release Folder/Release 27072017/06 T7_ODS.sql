/* 
Run this script on: 
 
        T7-DDT-07.T7_ODS    -  This database will be modified 
 
to synchronize it with: 
 
        ..T7_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 26/07/2017 15:59:38 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [T7_ODS]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[RawTcC810]'
GO
ALTER TABLE [dbo].[RawTcC810] DROP CONSTRAINT [PK_RawTcC810]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RawTc810_NEW]'
GO
CREATE TABLE [dbo].[RawTc810_NEW] 
( 
[RawTc810_NEW_ID] [int] NOT NULL IDENTITY(1, 1), 
[FileID] [int] NOT NULL, 
[exchNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[envText] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[rptCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[rptNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[rptFlexKey] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[membId] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[membLglNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[rptPrntEffDat] [datetime] NULL, 
[rptPrntEffTim] [datetime] NULL, 
[rptPrntRunDat] [datetime] NULL, 
[participant] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[partLngName] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[membClgIdCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[membCcpClgIdCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[settlAcct] [int] NULL, 
[settlLocat] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[settlCurr] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[sumMembTotBuyOrdr] [bigint] NULL, 
[sumMembTotSellOrdr] [bigint] NULL, 
[businessUnit] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[busUntLngName] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[businessUnitId] [int] NULL, 
[sumPartTotBuyOrdr] [bigint] NULL, 
[sumPartTotSellOrdr] [bigint] NULL, 
[product] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[instrumentType] [tinyint] NULL, 
[instrumentId] [bigint] NULL, 
[instrumentMnemonic] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[isinCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[wknNo] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[instNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
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
[acctTypGrp] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[buyCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[ordrPrtFilCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[execQty] [bigint] NULL, 
[execPrc] [numeric] (28, 10) NULL, 
[ordrTyp] [tinyint] NULL, 
[limOrdrPrc] [numeric] (28, 10) NULL, 
[timeValidity] [tinyint] NULL, 
[tradingRestriction] [tinyint] NULL, 
[settlAmnt] [numeric] (28, 10) NULL, 
[settlDat] [datetime] NULL, 
[ctrPtyId] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[userOrdrNum] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[text] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[kindOfDepo] [tinyint] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_RawTc810_NEW] on [dbo].[RawTc810_NEW]'
GO
ALTER TABLE [dbo].[RawTc810_NEW] ADD CONSTRAINT [PK_RawTc810_NEW] PRIMARY KEY CLUSTERED  ([FileID], [RawTc810_NEW_ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_RawTcC810] on [dbo].[RawTcC810]'
GO
ALTER TABLE [dbo].[RawTcC810] ADD CONSTRAINT [PK_RawTcC810] PRIMARY KEY CLUSTERED  ([FileID], [RawTc810Id]) WITH (DATA_COMPRESSION = PAGE)
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
