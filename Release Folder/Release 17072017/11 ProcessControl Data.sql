USE ProcessControl


/* 
Run this script on: 
 
T7-DDT-07.ProcessControl    -  This database will be modified 
 
to synchronize it with: 
 
..ProcessControl 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Data Compare version 12.0.33.3389 from Red Gate Software Ltd at 17/07/2017 15:57:33 
 
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
 
PRINT(N'Drop constraints from [dbo].[ValidationUnitTest]')
ALTER TABLE [dbo].[ValidationUnitTest] NOCHECK CONSTRAINT [FK_ValidationUnitTest_ValidationTestSuite] 
 
PRINT(N'Update rows in [dbo].[ValidationUnitTest]')
UPDATE [dbo].[ValidationUnitTest] SET [ValidationUnitTestName]='Price Fle not received' WHERE [ValidationTestSuiteID] = 6 AND [RunOrder] = 2 AND [ValidationUnitTestID] = 52
UPDATE [dbo].[ValidationUnitTest] SET [ValidationUnitTestName]='SAFT File not received' WHERE [ValidationTestSuiteID] = 6 AND [RunOrder] = 3 AND [ValidationUnitTestID] = 55
PRINT(N'Operation applied to 2 rows out of 2')
 
PRINT(N'Update rows in [dbo].[TaskControl]')
UPDATE [dbo].[TaskControl] SET [TaskControlEnabledYN]='N' WHERE [TaskControlTag] = 'T7_AGGREGATIONS     ' AND [TaskControlID] = 7
PRINT(N'Operation applied to 1 rows out of 2')
 
PRINT(N'Update rows in [dbo].[FileControlTimeExpected]')
UPDATE [dbo].[FileControlTimeExpected] SET [ProcessFileYN]='N' WHERE [FileTag] = 'ISEQ20_DAILY_HOLDINGS' AND [FileLetter] = '  '
UPDATE [dbo].[FileControlTimeExpected] SET [ExpectedStartTime]='18:50:00.0000000', [WarningStartTime]='18:50:00.0000000', [WarningEndTime]='20:00:00.0000000' WHERE [FileTag] = 'ISEQ20_LEVERAGED' AND [FileLetter] = '  '
PRINT(N'Operation applied to 2 rows out of 2')
 
PRINT(N'Add constraints to [dbo].[ValidationUnitTest]')
ALTER TABLE [dbo].[ValidationUnitTest] WITH CHECK CHECK CONSTRAINT [FK_ValidationUnitTest_ValidationTestSuite]
COMMIT TRANSACTION
GO
