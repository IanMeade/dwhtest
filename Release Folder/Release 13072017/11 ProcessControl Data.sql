USE ProcessControl

/* 
Run this script on: 
 
T7-DDT-07.ProcessControl    -  This database will be modified 
 
to synchronize it with: 
 
T7-DDT-01.ProcessControl 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Data Compare version 12.0.33.3389 from Red Gate Software Ltd at 13/07/2017 13:45:57 
 
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
 
PRINT(N'Delete rows from [dbo].[ScheduledActivitiesTimeExpected]')
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '08:30:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '09:30:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '10:30:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '11:30:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '12:30:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '13:30:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '14:30:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '15:30:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '16:30:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '17:30:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '17:45:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '21:00:00.0000000'
PRINT(N'Operation applied to 12 rows out of 12')
 
PRINT(N'Update rows in [dbo].[EmailMessageControl]')
UPDATE [dbo].[EmailMessageControl] SET [MessageTag]=' 
REQUIRED_PRICE_FILE_WARNING' WHERE [MessageID] = 134
UPDATE [dbo].[EmailMessageControl] SET [MessageSubject]='Early arriving facts - dimension entry has been created automagically' WHERE [MessageID] = 212
PRINT(N'Operation applied to 2 rows out of 2')
 
PRINT(N'Add rows to [dbo].[ScheduledActivitiesTimeExpected]')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '08:31:00.0000000', NULL, 'reutersload0830')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '09:31:00.0000000', NULL, 'reutersload0930')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '10:31:00.0000000', NULL, 'reutersload1030')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '11:31:00.0000000', NULL, 'reutersload1130')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '12:31:00.0000000', NULL, 'reutersload1230')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '13:31:00.0000000', NULL, 'reutersload1330')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '14:31:00.0000000', NULL, 'reutersload1430')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '15:31:00.0000000', NULL, 'reutersload1530')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '16:31:00.0000000', NULL, 'reutersload1630')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '17:31:00.0000000', NULL, 'reutersload1730')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '17:46:00.0000000', NULL, 'reutersload1745')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '21:01:00.0000000', NULL, 'reutersload2100')
PRINT(N'Operation applied to 12 rows out of 12')
COMMIT TRANSACTION
GO
