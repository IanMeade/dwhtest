/* 
Run this script on: 
 
        T7-DDT-07.Stoxx_ODS    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.Stoxx_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 13/07/2017 13:24:17 
 
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
PRINT N'Altering [dbo].[SetFileListFileDate]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 20/4/2017   
-- Description:	Set FileDate in FileList   
-- =============================================   
ALTER PROCEDURE [dbo].[SetFileListFileDate]   
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
								FileTag = 'ISEQ20_CAPPED_PRICE' 
				)   
	WHERE   
		FileID = @FileID   
   
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
