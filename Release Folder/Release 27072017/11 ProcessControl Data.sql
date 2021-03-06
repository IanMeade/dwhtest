USE ProcessControl

/* 
Run this script on: 
 
T7-DDT-07.ProcessControl    -  This database will be modified 
 
to synchronize it with: 
 
..ProcessControl 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Data Compare version 12.0.33.3389 from Red Gate Software Ltd at 26/07/2017 16:02:11 
 
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
 
PRINT(N'Add row to [dbo].[FileControl]')
SET IDENTITY_INSERT [dbo].[FileControl] ON
INSERT INTO [dbo].[FileControl] ([FileControlID], [ODS], [FileName], [EnabledYN], [FileTag], [FileNameMask], [FilePrefix], [SourceFolder], [ProcessFolder], [ArchiveFolder], [RejectFolder]) VALUES (21, 'T7_ODS', 'RawTc810_NEW', 'Y', 'RAWTC_810_NEW', '55RPTTC810XETRA*.XML*', '', 'C:\DWH\Files\Source\', 'C:\DWH\Files\Process\', 'C:\DWH\Files\Archive\', 'C:\DWH\Files\Reject\')
SET IDENTITY_INSERT [dbo].[FileControl] OFF
 
PRINT(N'Add row to [dbo].[Switches]')
INSERT INTO [dbo].[Switches] ([SwitchKey], [SwitchValue]) VALUES ('RAWTC_NEW_XSD_PATH', 'C:\DWH\Files\Resource\xetraT7_tc810_SSIS_generated.xsd')
 
PRINT(N'Add row to [dbo].[TaskControl]')
SET IDENTITY_INSERT [dbo].[TaskControl] ON
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('RAWTC_NEW_ODS       ', 219, 'RAWTC810 - load to ODS - New format', 'Y', 'WORKDAY', 'FILE_FOUND_RAWTC_810_NEW')
SET IDENTITY_INSERT [dbo].[TaskControl] OFF
COMMIT TRANSACTION
GO
