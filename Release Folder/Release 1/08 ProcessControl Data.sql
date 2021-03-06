USE ProcessControl
GO

/* 
Run this script on: 
 
T7-DDT-06.ProcessControl    -  This database will be modified 
 
to synchronize it with: 
 
T7-DDT-01.ProcessControl 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Data Compare version 12.0.33.3389 from Red Gate Software Ltd at 24/02/2017 14:16:04 
 
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
 
PRINT(N'Drop constraints from [dbo].[FileControl]')
ALTER TABLE [dbo].[FileControl] NOCHECK CONSTRAINT [FK_FileControl_SourceSystem] 
 
PRINT(N'Add 1 row to [dbo].[EmailMessageControl]')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] ON
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (1, 'ERROR MESSAGE', 'XXX', 'XXX', 'ERROR HANDLER', 'GENERIC ERROR', 3, 'Y')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] OFF
 
PRINT(N'Add 1 row to [dbo].[EmailServer]')
INSERT INTO [dbo].[EmailServer] ([SmptServerAddress], [EnabledYN]) VALUES ('SMPT ADDRESS', 'N')
 
PRINT(N'Add 5 rows to [dbo].[SourceSystem]')
SET IDENTITY_INSERT [dbo].[SourceSystem] ON
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (1, 'DWH', 'DWH', 'XX', 'Y', NULL, NULL)
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (2, 'Staging', 'Staging', 'XX', 'Y', NULL, NULL)
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (3, 'MDM', 'MDM', 'XX', 'Y', NULL, NULL)
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (4, 'T7', 'T7', 'XX', 'Y', NULL, NULL)
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (6, 'XML', 'XML', 'XX', 'Y', NULL, NULL)
SET IDENTITY_INSERT [dbo].[SourceSystem] OFF
 
PRINT(N'Add 1 row to [dbo].[Switches]')
INSERT INTO [dbo].[Switches] ([SwitchKey], [SwitchValue]) VALUES ('EtlVersion', 'EQ1 - SYS 24/2/2017')
 
PRINT(N'Add 2 rows to [dbo].[TaskControl]')
SET IDENTITY_INSERT [dbo].[TaskControl] ON
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (1, 'Overnight jobs', 'OVERNIGHT_JOBS      ', 'Y', 'DAILY:[14:00:15:00]')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (2, 'MDM based dimensions', 'UPDATE_MDM_DIMS     ', 'Y', 'ALWAYS')
SET IDENTITY_INSERT [dbo].[TaskControl] OFF
 
PRINT(N'Add 2 rows to [dbo].[XT_UpdateControl]')
INSERT INTO [dbo].[XT_UpdateControl] ([TableName], [ExtractSequenceId], [LastChecked], [LastUpdated], [LastUpdateBatchID]) VALUES ('EquityStage', 0, '2017-02-24 09:55:04.5466667', '2017-02-24 09:55:04.5466667', -1)
INSERT INTO [dbo].[XT_UpdateControl] ([TableName], [ExtractSequenceId], [LastChecked], [LastUpdated], [LastUpdateBatchID]) VALUES ('IssuerStage', 0, '2017-02-24 09:55:04.5500000', '2017-02-24 09:55:04.5500000', -1)
 
PRINT(N'Add 3 rows to [dbo].[FileControl]')
SET IDENTITY_INSERT [dbo].[FileControl] ON
INSERT INTO [dbo].[FileControl] ([FileControlID], [SourceSystemID], [FileName], [FileTag], [FileNameMask], [FilePrefix], [SourceFolder], [ProcessFolder], [ArchiveFolder], [RejectFolder]) VALUES (1, 4, 'TradeFile', 'TxSaft', 'TXSAFT*.dat', 'TXSAFT', 'C:\DWH\Files\Source\', 'C:\DWH\Files\Process\', 'C:\DWH\Files\Archive\', 'C:\DWH\Files\Reject\')
INSERT INTO [dbo].[FileControl] ([FileControlID], [SourceSystemID], [FileName], [FileTag], [FileNameMask], [FilePrefix], [SourceFolder], [ProcessFolder], [ArchiveFolder], [RejectFolder]) VALUES (2, 4, 'PriceFile', 'PriceFile', 'TXPRICE*.dat', 'TXPRICE', 'C:\DWH\Files\Source\', 'C:\DWH\Files\Process\', 'C:\DWH\Files\Archive\', 'C:\DWH\Files\Reject\')
INSERT INTO [dbo].[FileControl] ([FileControlID], [SourceSystemID], [FileName], [FileTag], [FileNameMask], [FilePrefix], [SourceFolder], [ProcessFolder], [ArchiveFolder], [RejectFolder]) VALUES (4, 6, 'XML', 'XML', '*.xml', '', 'C:\DWH\Files\Source\', 'C:\DWH\Files\Process\', 'C:\DWH\Files\Archive\', 'C:\DWH\Files\Reject\')
SET IDENTITY_INSERT [dbo].[FileControl] OFF
 
PRINT(N'Add constraints to [dbo].[FileControl]')
ALTER TABLE [dbo].[FileControl] WITH CHECK CHECK CONSTRAINT [FK_FileControl_SourceSystem]
COMMIT TRANSACTION
GO
