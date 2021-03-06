USE ProcessControl
GO


/* 
Run this script on: 
 
T7-DDT-07.ProcessControl    -  This database will be modified 
 
to synchronize it with: 
 
T7-DDT-01.ProcessControl 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Data Compare version 12.0.33.3389 from Red Gate Software Ltd at 11/07/2017 15:28:23 
 
*/ 
		
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)
 
PRINT(N'Update rows in [dbo].[TaskControl]')
UPDATE [dbo].[TaskControl] SET [TaskControlRuleSchedule]='DAILY:[06:00:22:30]' WHERE [TaskControlTag] = 'MASTER_LOOP         ' AND [TaskControlID] = 216
UPDATE [dbo].[TaskControl] SET [TaskControlEnabledYN]='Y' WHERE [TaskControlTag] = 'PST_ORACLE          ' AND [TaskControlID] = 17
UPDATE [dbo].[TaskControl] SET [TaskControlRuleSchedule]='DAILY:[06:00:23:00]' WHERE [TaskControlTag] = 'REUTERS_INDEX_LOAD  ' AND [TaskControlID] = 11
PRINT(N'Operation applied to 3 rows out of 3')
 
PRINT(N'Update row in [dbo].[FileControlTimeExpected]')
UPDATE [dbo].[FileControlTimeExpected] SET [OracleProcessStatusTable]='saftload2100' WHERE [FileTag] = 'TxSaft' AND [FileLetter] = 'JK'
COMMIT TRANSACTION
GO
