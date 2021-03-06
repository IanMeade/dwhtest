/* 
Run this script on: 
 
        T7-SYS-DW-01.ProcessControl    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.ProcessControl 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 21/06/2017 17:14:32 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [ProcessControl]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[GetScheduledActivitiesTimeExpected]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 16/6/2017 
-- Description:	Determine if an activity should be run and what the expected time is 
-- ============================================= 
ALTER FUNCTION [dbo].[GetScheduledActivitiesTimeExpected] 
(	 
	@Activity VARCHAR(100) 
) 
RETURNS TABLE  
AS 
RETURN  
( 
	SELECT 
		ExpectedTime, 
		IIF(LastProcessed IS NULL, 1, IIF(CAST(GETDATE() AS DATE) > CAST(LastProcessed AS DATE) ,1,0)) AS WorkToDo 
	FROM 
			dbo.ScheduledActivitiesTimeExpected 
	WHERE 
		ExpectedTime IN ( 
				SELECT 
					MAX(ExpectedTime) AS ExpectedTime 
				FROM 
					dbo.ScheduledActivitiesTimeExpected InSide 
				WHERE 
					Activity = @Activity 
				AND 
					ExpectedTime <= CAST(GETDATE() AS TIME) 
			) 
		AND 
			Activity = @Activity 
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
