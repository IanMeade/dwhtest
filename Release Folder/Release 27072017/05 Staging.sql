/* 
Run this script on: 
 
        T7-DDT-07.Staging    -  This database will be modified 
 
to synchronize it with: 
 
        ..Staging 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 26/07/2017 15:56:31 
 
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
PRINT N'Creating [dbo].[RAWTC_810_NEW_InstrumentGrp]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_InstrumentGrp] 
( 
[product] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[instrumentType] [tinyint] NULL, 
[instrumentId] [bigint] NULL, 
[instrumentMnemonic] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[isinCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[wknNo] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[instNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[tc810KeyGrp4_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_businessUnitGrp]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_businessUnitGrp] 
( 
[businessUnit] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[busUntLngName] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[businessUnitId] [int] NULL, 
[tc810KeyGrp1_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_participantGrp]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_participantGrp] 
( 
[participant] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[partLngName] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[tc810KeyGrp_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_rptHdr]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_rptHdr] 
( 
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
[tc810_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_tc810]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_tc810] 
( 
[tc810_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_tc810grp1]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_tc810grp1] 
( 
[tc810Grp1_Id] [numeric] (20, 0) NULL, 
[membClgIdCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[membCcpClgIdCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[settlAcct] [int] NULL, 
[settlLocat] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[settlCurr] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[sumMembTotBuyOrdr] [bigint] NULL, 
[sumMembTotSellOrdr] [bigint] NULL, 
[tc810Grp_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_tc810grp2]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_tc810grp2] 
( 
[tc810Grp2_Id] [numeric] (20, 0) NULL, 
[sumPartTotBuyOrdr] [bigint] NULL, 
[sumPartTotSellOrdr] [bigint] NULL, 
[tc810Grp1_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_tc810grp3]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_tc810grp3] 
( 
[tc810Grp3_Id] [numeric] (20, 0) NULL, 
[tc810Grp2_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_tc810grp4]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_tc810grp4] 
( 
[tc810Grp4_Id] [numeric] (20, 0) NULL, 
[tc810Grp3_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_tc810grp]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_tc810grp] 
( 
[tc810Grp_Id] [numeric] (20, 0) NULL, 
[tc810_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_tc810keygrp1]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_tc810keygrp1] 
( 
[tc810KeyGrp1_Id] [numeric] (20, 0) NULL, 
[tc810Grp1_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_tc810keygrp2]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_tc810keygrp2] 
( 
[user] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[tc810Grp2_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_tc810keygrp3]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_tc810keygrp3] 
( 
[product] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[tc810Grp3_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_tc810keygrp4]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_tc810keygrp4] 
( 
[tc810KeyGrp4_Id] [numeric] (20, 0) NULL, 
[tc810Grp4_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_tc810keygrp]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_tc810keygrp] 
( 
[tc810KeyGrp_Id] [numeric] (20, 0) NULL, 
[tc810Grp_Id] [numeric] (20, 0) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RAWTC_810_NEW_tc810rec]'
GO
CREATE TABLE [dbo].[RAWTC_810_NEW_tc810rec] 
( 
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
[execPrc] [decimal] (28, 10) NULL, 
[ordrTyp] [tinyint] NULL, 
[limOrdrPrc] [decimal] (28, 10) NULL, 
[timeValidity] [tinyint] NULL, 
[tradingRestriction] [tinyint] NULL, 
[settlAmnt] [decimal] (28, 10) NULL, 
[settlDat] [datetime] NULL, 
[ctrPtyId] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[userOrdrNum] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[text] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[kindOfDepo] [tinyint] NULL, 
[tc810Grp4_Id] [numeric] (20, 0) NULL 
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
