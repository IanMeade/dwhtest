/* 
Run this script on: 
 
        T7-DDT-07.dwh    -  This database will be modified 
 
to synchronize it with: 
 
        ..dwh 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 01/08/2017 18:08:51 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [dwh]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Report].[RawTcC810_NEW]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Report].[RawTcC810_NEW] ALTER COLUMN [versionNo] [smallint] NULL 
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
