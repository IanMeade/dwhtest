USE ProcessControl

/* 
Run this script on: 
 
T7-DDT-06.ProcessControl    -  This database will be modified 
 
to synchronize it with: 
 
T7-DDT-01.ProcessControl 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Data Compare version 12.0.33.3389 from Red Gate Software Ltd at 30/08/2017 15:40:21 
 
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
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '08:31:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '09:31:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '10:31:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '11:31:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '12:31:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '13:31:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '14:31:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '15:31:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '16:31:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '17:31:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '17:46:00.0000000'
DELETE FROM [dbo].[ScheduledActivitiesTimeExpected] WHERE [Activity] = 'REFRESH_FactEquityIndexSnapshot' AND [ExpectedTime] = '21:01:00.0000000'
PRINT(N'Operation applied to 12 rows out of 12')
 
PRINT(N'Update row in [dbo].[Switches]')
UPDATE [dbo].[Switches] SET [SwitchValue]='30/8/2017' WHERE [SwitchKey] = 'EtlVersion'
 
PRINT(N'Update row in [dbo].[Switches]')
UPDATE [dbo].[Switches] SET [SwitchValue]='30/8/2017' WHERE [SwitchKey] = 'EtlVersion'
 
PRINT(N'Update rows in [dbo].[FileControl]')
/* MANUAL CHANGE - ONLY SET ENABLED FLAG */
UPDATE [dbo].[FileControl] 
	SET [EnabledYN]='N'
WHERE [FileControlID] = 8
PRINT(N'Operation applied to 1 rows out of 11')
 
PRINT(N'Add rows to [dbo].[ScheduledActivitiesTimeExpected]')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '08:30:00.0000000', NULL, 'reutersload0830')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '09:30:00.0000000', NULL, 'reutersload0930')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '10:30:00.0000000', NULL, 'reutersload1030')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '11:30:00.0000000', NULL, 'reutersload1130')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '12:30:00.0000000', NULL, 'reutersload1230')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '13:30:00.0000000', NULL, 'reutersload1330')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '14:30:00.0000000', NULL, 'reutersload1430')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '15:30:00.0000000', NULL, 'reutersload1530')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '16:30:00.0000000', NULL, 'reutersload1630')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '17:30:00.0000000', NULL, 'reutersload1730')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '17:45:00.0000000', NULL, 'reutersload1745')
INSERT INTO [dbo].[ScheduledActivitiesTimeExpected] ([Activity], [ExpectedTime], [LastProcessed], [OracleProcessStatusTable]) VALUES ('REFRESH_FactEquityIndexSnapshot', '21:00:00.0000000', NULL, 'reutersload2100')
PRINT(N'Operation applied to 12 rows out of 12')
COMMIT TRANSACTION
GO
