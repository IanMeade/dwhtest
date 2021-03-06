/* 
Run this script on: 
 
        T7-DDT-07.OracleLink    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.OracleLink 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 06/07/2017 10:47:03 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [OracleLink]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DssAddProcessStatus]'
GO
-- ============================================= 
-- Author:	Ian Meade 
-- Create date: 27/6/2017 
-- Description:	Call Stored Procedure in DSS to add entry to ProcessStatus table 
-- ============================================= 
CREATE PROCEDURE [dbo].[DssAddProcessStatus] 
	@Message VARCHAR(1000) 
AS 
BEGIN 
	SET NOCOUNT ON; 
	 
	/* CALL STORED PROCEDURES ON ORACLE */ 
 
 
	/* CREATE AN ENTRY */ 
	EXECUTE ('BEGIN  ISEDBA.PKG_IP.P_PS_STS_UP_EP_START (?); END;', @Message ) AT DSS 
 
	/* MARK ENTRY AS COMPLETE */ 
	EXECUTE ('BEGIN  ISEDBA.PKG_IP.P_PS_STS_UP_EP_END (?); END;', @Message ) AT DSS 
 
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
