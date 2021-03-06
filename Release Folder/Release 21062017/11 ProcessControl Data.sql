use ProcessControl

/* 
Run this script on: 
 
T7-DDT-06.ProcessControl    -  This database will be modified 
 
to synchronize it with: 
 
T7-DDT-01.ProcessControl 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Data Compare version 12.0.33.3389 from Red Gate Software Ltd at 21/06/2017 17:29:11 
 
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
 
PRINT(N'Update row in [dbo].[ValidationUnitTest]')
UPDATE [dbo].[ValidationUnitTest] SET [Enabled]=1 WHERE [ValidationTestSuiteID] = 10 AND [RunOrder] = 4 AND [ValidationUnitTestID] = 50
 
PRINT(N'Update row in [dbo].[TaskControl]')
UPDATE [dbo].[TaskControl] SET [TaskControlRuleSchedule]='DAILY:[22:00:23:00]' WHERE [TaskControlTag] = 'OVERNIGHT_JOBS      ' AND [TaskControlID] = 1
 
PRINT(N'Update rows in [dbo].[ScheduledActivitiesTimeExpected]')
UPDATE [dbo].[ScheduledActivitiesTimeExpected] SET [LastProcessed]=NULL WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '09:30:00.0000000'
UPDATE [dbo].[ScheduledActivitiesTimeExpected] SET [LastProcessed]='2017-06-21 10:55:13.8066667' WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '10:30:00.0000000'
UPDATE [dbo].[ScheduledActivitiesTimeExpected] SET [LastProcessed]='2017-06-21 11:35:59.5833333' WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '11:30:00.0000000'
UPDATE [dbo].[ScheduledActivitiesTimeExpected] SET [LastProcessed]='2017-06-21 12:39:13.0266667' WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '12:30:00.0000000'
UPDATE [dbo].[ScheduledActivitiesTimeExpected] SET [LastProcessed]=NULL WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '13:30:00.0000000'
UPDATE [dbo].[ScheduledActivitiesTimeExpected] SET [LastProcessed]=NULL WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '14:30:00.0000000'
UPDATE [dbo].[ScheduledActivitiesTimeExpected] SET [LastProcessed]='2017-06-21 15:47:51.1200000' WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '15:30:00.0000000'
UPDATE [dbo].[ScheduledActivitiesTimeExpected] SET [LastProcessed]='2017-06-20 16:53:21.8733333' WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '16:30:00.0000000'
UPDATE [dbo].[ScheduledActivitiesTimeExpected] SET [LastProcessed]='2017-06-20 17:31:07.6900000' WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '17:30:00.0000000'
UPDATE [dbo].[ScheduledActivitiesTimeExpected] SET [LastProcessed]=NULL WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '17:45:00.0000000'
PRINT(N'Operation applied to 10 rows out of 10')
 
PRINT(N'Update row in [dbo].[EmailMessageControl]')
UPDATE [dbo].[EmailMessageControl] SET [MessageTag]=' 
REQUIRED_PRICE_FILE_WARNING' WHERE [MessageID] = 134
 
PRINT(N'Add row to [dbo].[EmailMessageControl]')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] ON
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (212, 'T7_EARLY_FACTS', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Early arriving facts - dimension entry ahs been created automagically', 'Validation message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] OFF
 
PRINT(N'Add row to [dbo].[ValidationUnitTest]')
SET IDENTITY_INSERT [dbo].[ValidationUnitTest] ON
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationTestSuiteID], [RunOrder], [ValidationUnitTestID], [ValidationUnitTestName], [ValidationUnitTestTag], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (10, 5, 56, 'Early arriving facts warning', 'T7_EARLY_FACTS', 'DWH', 'ETL.ValidateT7EarlyFacts', 1, 0, 1, 0)
SET IDENTITY_INSERT [dbo].[ValidationUnitTest] OFF
 
PRINT(N'Add constraints to [dbo].[ValidationUnitTest]')
ALTER TABLE [dbo].[ValidationUnitTest] WITH CHECK CHECK CONSTRAINT [FK_ValidationUnitTest_ValidationTestSuite]
COMMIT TRANSACTION
GO
