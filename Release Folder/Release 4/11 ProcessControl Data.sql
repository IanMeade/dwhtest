/* 
Run this script on: 
 
T7-DDT-06.ProcessControl    -  This database will be modified 
 
to synchronize it with: 
 
..ProcessControl 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Data Compare version 12.0.33.3389 from Red Gate Software Ltd at 02/05/2017 12:22:44 
 
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
 
PRINT(N'Add 7 rows to [dbo].[EmailMessageControl]')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] ON
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (1, 'GENERIC_ERROR', 'ianm@sys-ise.ie', '', 'ERROR HANDLER', 'GENERIC ERROR', 3, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (2, 'GENERIC_VALIDATION_WARNING', 'XXX', 'XXX', 'Warning raised by validation', 'Warning raised by validation', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (3, 'GENERIC_VALIDATION_ERROR', 'ianm@sys-ise.ie', '', 'Error raised by validation', 'Validation erro reaised', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (4, 'ALWAYS_FAIL2', 'ianm@sys-ise.ie', '', 'From validation suite', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (5, 'T7_MAIN_DATAFLOW_SIMPLE', 'ianm@sys-ise.ie', '', 'DWH - T7 Validation issue', NULL, NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (6, 'XT_EARLY_FACT', 'ianm@sys-ise.ie', '', 'XT Currency added to DWH', NULL, NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (7, 'REUTERS_INDEX_ERROR', 'ianm@sys-ise.ie', '', 'Error processing Reuters Index Values', 'Error!!!!!!', 3, 'Y')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] OFF
 
PRINT(N'Add 1 row to [dbo].[EmailServer]')
INSERT INTO [dbo].[EmailServer] ([SmptServerAddress], [SentFromMessageBox], [EnabledYN]) VALUES ('172.20.12.44', 'ianm@sys-ise.ie', 'Y')
 
PRINT(N'Add 8 rows to [dbo].[FileControl]')
SET IDENTITY_INSERT [dbo].[FileControl] ON
INSERT INTO [dbo].[FileControl] ([FileControlID], [ODS], [FileName], [EnabledYN], [FileTag], [FileNameMask], [FilePrefix], [SourceFolder], [ProcessFolder], [ArchiveFolder], [RejectFolder]) VALUES (1, 'T7_ODS', 'TradeFile', 'Y', 'TxSaft', 'TXSAFT*.dat', 'TXSAFT', 'C:\DWH\Files\Source\', 'C:\DWH\Files\Process\', 'C:\DWH\Files\Archive\', 'C:\DWH\Files\Reject\')
INSERT INTO [dbo].[FileControl] ([FileControlID], [ODS], [FileName], [EnabledYN], [FileTag], [FileNameMask], [FilePrefix], [SourceFolder], [ProcessFolder], [ArchiveFolder], [RejectFolder]) VALUES (2, 'T7_ODS', 'PriceFile', 'Y', 'PriceFile', 'TXPRICE*.dat', 'TXPRICE', 'C:\DWH\Files\Source\', 'C:\DWH\Files\Process\', 'C:\DWH\Files\Archive\', 'C:\DWH\Files\Reject\')
INSERT INTO [dbo].[FileControl] ([FileControlID], [ODS], [FileName], [EnabledYN], [FileTag], [FileNameMask], [FilePrefix], [SourceFolder], [ProcessFolder], [ArchiveFolder], [RejectFolder]) VALUES (5, 'Stoxx_ODS', 'STATS', 'Y', 'STATS', 'sf_*.csv', 'SF_', 'C:\DWH\Files\Source\', 'C:\DWH\Files\Process\', 'C:\DWH\Files\Archive\', 'C:\DWH\Files\Reject\')
INSERT INTO [dbo].[FileControl] ([FileControlID], [ODS], [FileName], [EnabledYN], [FileTag], [FileNameMask], [FilePrefix], [SourceFolder], [ProcessFolder], [ArchiveFolder], [RejectFolder]) VALUES (6, 'Stoxx_ODS', 'ISEQ20_STATS', 'Y', 'ISEQ20_STATS', 'etfsf_*.csv', 'etfsf_', 'C:\DWH\Files\Source\', 'C:\DWH\Files\Process\', 'C:\DWH\Files\Archive\', 'C:\DWH\Files\Reject\')
INSERT INTO [dbo].[FileControl] ([FileControlID], [ODS], [FileName], [EnabledYN], [FileTag], [FileNameMask], [FilePrefix], [SourceFolder], [ProcessFolder], [ArchiveFolder], [RejectFolder]) VALUES (7, 'Stoxx_ODS', 'ISEQ20_LEVERAGED', 'Y', 'ISEQ20_LEVERAGED', 'ISEQ_Leveraged_*.csv', 'ISEQ_Leveraged_', 'C:\DWH\Files\Source\', 'C:\DWH\Files\Process\', 'C:\DWH\Files\Archive\', 'C:\DWH\Files\Reject\')
INSERT INTO [dbo].[FileControl] ([FileControlID], [ODS], [FileName], [EnabledYN], [FileTag], [FileNameMask], [FilePrefix], [SourceFolder], [ProcessFolder], [ArchiveFolder], [RejectFolder]) VALUES (8, 'StateStreet_ODS', 'ISEQ20_DAILY_HOLDINGS', 'Y', 'ISEQ20_DAILY_HOLDINGS', 'ISE_Daily_Holdings_File_*.csv', 'ISE_Daily_Holdings_File_', 'C:\DWH\Files\Source\', 'C:\DWH\Files\Process\', 'C:\DWH\Files\Archive\', 'C:\DWH\Files\Reject\')
INSERT INTO [dbo].[FileControl] ([FileControlID], [ODS], [FileName], [EnabledYN], [FileTag], [FileNameMask], [FilePrefix], [SourceFolder], [ProcessFolder], [ArchiveFolder], [RejectFolder]) VALUES (9, 'StateStreet_ODS', 'ISEQ20_NAV', 'Y', 'ISEQ20_NAV', 'WISDOM_TREE_001_*.csv', 'WISDOM_TREE_001_', 'C:\DWH\Files\Source\', 'C:\DWH\Files\Process\', 'C:\DWH\Files\Archive\', 'C:\DWH\Files\Reject\')
INSERT INTO [dbo].[FileControl] ([FileControlID], [ODS], [FileName], [EnabledYN], [FileTag], [FileNameMask], [FilePrefix], [SourceFolder], [ProcessFolder], [ArchiveFolder], [RejectFolder]) VALUES (11, 'T7_ODS', 'RawTc810', 'Y', 'RAWTC_810', '55srpttc810xetra*.xmlxdub', '', 'C:\DWH\Files\Source\', 'C:\DWH\Files\Process\', 'C:\DWH\Files\Archive\', 'C:\DWH\Files\Reject\')
SET IDENTITY_INSERT [dbo].[FileControl] OFF
 
PRINT(N'Add 12 rows to [dbo].[FileControlT7]')
INSERT INTO [dbo].[FileControlT7] ([FileLetter], [ExpectedStartTime], [ExpectedFinishTime], [ProcessFileYN], [ContainsEndOfDayDetailsYN], [ReprocessDelayMinutes]) VALUES ('A ', '09:00:00.0000000', '19:00:00.0000000', 'N', 'N', 1)
INSERT INTO [dbo].[FileControlT7] ([FileLetter], [ExpectedStartTime], [ExpectedFinishTime], [ProcessFileYN], [ContainsEndOfDayDetailsYN], [ReprocessDelayMinutes]) VALUES ('B ', '10:00:00.0000000', '19:00:00.0000000', 'N', 'N', 1)
INSERT INTO [dbo].[FileControlT7] ([FileLetter], [ExpectedStartTime], [ExpectedFinishTime], [ProcessFileYN], [ContainsEndOfDayDetailsYN], [ReprocessDelayMinutes]) VALUES ('C ', '11:00:00.0000000', '19:00:00.0000000', 'N', 'N', 1)
INSERT INTO [dbo].[FileControlT7] ([FileLetter], [ExpectedStartTime], [ExpectedFinishTime], [ProcessFileYN], [ContainsEndOfDayDetailsYN], [ReprocessDelayMinutes]) VALUES ('D ', '12:00:00.0000000', '19:00:00.0000000', 'N', 'N', 1)
INSERT INTO [dbo].[FileControlT7] ([FileLetter], [ExpectedStartTime], [ExpectedFinishTime], [ProcessFileYN], [ContainsEndOfDayDetailsYN], [ReprocessDelayMinutes]) VALUES ('E ', '13:00:00.0000000', '19:00:00.0000000', 'N', 'N', 1)
INSERT INTO [dbo].[FileControlT7] ([FileLetter], [ExpectedStartTime], [ExpectedFinishTime], [ProcessFileYN], [ContainsEndOfDayDetailsYN], [ReprocessDelayMinutes]) VALUES ('F ', '14:00:00.0000000', '19:00:00.0000000', 'N', 'N', 1)
INSERT INTO [dbo].[FileControlT7] ([FileLetter], [ExpectedStartTime], [ExpectedFinishTime], [ProcessFileYN], [ContainsEndOfDayDetailsYN], [ReprocessDelayMinutes]) VALUES ('G ', '15:00:00.0000000', '19:00:00.0000000', 'N', 'N', 1)
INSERT INTO [dbo].[FileControlT7] ([FileLetter], [ExpectedStartTime], [ExpectedFinishTime], [ProcessFileYN], [ContainsEndOfDayDetailsYN], [ReprocessDelayMinutes]) VALUES ('H ', '16:00:00.0000000', '19:00:00.0000000', 'N', 'N', 1)
INSERT INTO [dbo].[FileControlT7] ([FileLetter], [ExpectedStartTime], [ExpectedFinishTime], [ProcessFileYN], [ContainsEndOfDayDetailsYN], [ReprocessDelayMinutes]) VALUES ('I ', '17:00:00.0000000', '19:00:00.0000000', 'N', 'N', 1)
INSERT INTO [dbo].[FileControlT7] ([FileLetter], [ExpectedStartTime], [ExpectedFinishTime], [ProcessFileYN], [ContainsEndOfDayDetailsYN], [ReprocessDelayMinutes]) VALUES ('J ', '18:00:00.0000000', '19:00:00.0000000', 'N', 'Y', 1)
INSERT INTO [dbo].[FileControlT7] ([FileLetter], [ExpectedStartTime], [ExpectedFinishTime], [ProcessFileYN], [ContainsEndOfDayDetailsYN], [ReprocessDelayMinutes]) VALUES ('JK', '09:00:00.0000000', '19:00:00.0000000', 'N', 'Y', 1)
INSERT INTO [dbo].[FileControlT7] ([FileLetter], [ExpectedStartTime], [ExpectedFinishTime], [ProcessFileYN], [ContainsEndOfDayDetailsYN], [ReprocessDelayMinutes]) VALUES ('K ', '19:00:00.0000000', '19:00:00.0000000', 'N', 'Y', 1)
 
PRINT(N'Add 3 rows to [dbo].[Reuters_UpdateControl]')
INSERT INTO [dbo].[Reuters_UpdateControl] ([TableName], [LastCutOffCounterUsed], [LastChecked], [LastUpdated]) VALUES ('ExchangeRateValue', 0, '2017-05-02 11:50:24.3666667', '2017-05-02 11:50:24.3666667')
INSERT INTO [dbo].[Reuters_UpdateControl] ([TableName], [LastCutOffCounterUsed], [LastChecked], [LastUpdated]) VALUES ('IndexValue', 0, NULL, NULL)
INSERT INTO [dbo].[Reuters_UpdateControl] ([TableName], [LastCutOffCounterUsed], [LastChecked], [LastUpdated]) VALUES ('SetsValue', 0, NULL, NULL)
 
PRINT(N'Add 5 rows to [dbo].[SourceSystem]')
SET IDENTITY_INSERT [dbo].[SourceSystem] ON
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (1, 'DWH', 'DWH', 'XX', 'Y', NULL, NULL)
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (2, 'Staging', 'Staging', 'XX', 'Y', NULL, NULL)
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (3, 'MDM', 'MDM', 'XX', 'Y', NULL, NULL)
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (4, 'T7', 'T7', 'XX', 'Y', NULL, NULL)
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (6, 'XML', 'XML', 'XX', 'Y', NULL, NULL)
SET IDENTITY_INSERT [dbo].[SourceSystem] OFF
 
PRINT(N'Add 5 rows to [dbo].[Switches]')
INSERT INTO [dbo].[Switches] ([SwitchKey], [SwitchValue]) VALUES ('EtlVersion', 'EQ1 - SYS 28.03.2017')
INSERT INTO [dbo].[Switches] ([SwitchKey], [SwitchValue]) VALUES ('RAWTC_XSD_PATH', 'C:\DWH\Files\Resource\processedfile.xsd')
INSERT INTO [dbo].[Switches] ([SwitchKey], [SwitchValue]) VALUES ('RAWTC_XSL_TRANSFORM_PATH', 'C:\DWH\Files\Resource\Rawtc810.xsl')
INSERT INTO [dbo].[Switches] ([SwitchKey], [SwitchValue]) VALUES ('REUTERS_INDEX_LOAD_SECONDS', '240')
INSERT INTO [dbo].[Switches] ([SwitchKey], [SwitchValue]) VALUES ('WISDOW_TREE_ETF', 'WisdomTree ISEQ 20 UCITS ETF Shares')
 
PRINT(N'Add 12 rows to [dbo].[TaskControl]')
SET IDENTITY_INSERT [dbo].[TaskControl] ON
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (1, 'Overnight jobs', 'OVERNIGHT_JOBS      ', 'N', 'DAILY:[14:00:15:00]')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (2, 'MDM based dimensions', 'UPDATE_MDM_DIMS     ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (3, 'Look for files to process', 'PRESTAGE_FILES      ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (4, 'T7 SAFT Trade files', 'T7_SAFT             ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (5, 'T7 Price files', 'T7_PRICE            ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (6, 'XT Interface', 'XT_INTERFACE        ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (7, 'T7 Aggregations', 'T7_AGGREGATIONS     ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (8, 'Stoxx load - files load to ODS', 'STOXX_ODS           ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (9, 'RAWTC810 - load to ODS', 'RAWTC_ODS           ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (10, 'StateStrret load - files to ODS', 'STATESTREET_ODS     ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (11, 'Reuters Index Load', 'REUTERS_INDEX_LOAD  ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (14, 'Exchange rates', 'REUTERS_FX_RATES    ', 'Y', 'ALWAYS')
SET IDENTITY_INSERT [dbo].[TaskControl] OFF
 
PRINT(N'Add 10 rows to [dbo].[ValidationTestSuite]')
SET IDENTITY_INSERT [dbo].[ValidationTestSuite] ON
INSERT INTO [dbo].[ValidationTestSuite] ([ValidationTestSuiteID], [ValidationTestSuiteName], [ValidationTestSuiteTag], [Enabled]) VALUES (1, 'Unit test', 'UNIT_TEST', 1)
INSERT INTO [dbo].[ValidationTestSuite] ([ValidationTestSuiteID], [ValidationTestSuiteName], [ValidationTestSuiteTag], [Enabled]) VALUES (4, 'T7 File names', 'T7_FILENAMES', 1)
INSERT INTO [dbo].[ValidationTestSuite] ([ValidationTestSuiteID], [ValidationTestSuiteName], [ValidationTestSuiteTag], [Enabled]) VALUES (5, 'XT Interface checks', 'XT_INTERFACE', 1)
INSERT INTO [dbo].[ValidationTestSuite] ([ValidationTestSuiteID], [ValidationTestSuiteName], [ValidationTestSuiteTag], [Enabled]) VALUES (6, 'Required files warning', 'REQUIRED_FILES_WARNING', 1)
INSERT INTO [dbo].[ValidationTestSuite] ([ValidationTestSuiteID], [ValidationTestSuiteName], [ValidationTestSuiteTag], [Enabled]) VALUES (8, 'Required files error', 'REQUIRED_FILES_ERROR', 1)
INSERT INTO [dbo].[ValidationTestSuite] ([ValidationTestSuiteID], [ValidationTestSuiteName], [ValidationTestSuiteTag], [Enabled]) VALUES (9, 'Required files found', 'REQUIRED_FILES_FOUND', 1)
INSERT INTO [dbo].[ValidationTestSuite] ([ValidationTestSuiteID], [ValidationTestSuiteName], [ValidationTestSuiteTag], [Enabled]) VALUES (10, 'T7 Main dataflow ', 'T7_MAIN_DATAFLOW', 1)
INSERT INTO [dbo].[ValidationTestSuite] ([ValidationTestSuiteID], [ValidationTestSuiteName], [ValidationTestSuiteTag], [Enabled]) VALUES (11, 'T7 Staging / File correctness', 'T7_TXTSAFT_FILE_STAGING', 1)
INSERT INTO [dbo].[ValidationTestSuite] ([ValidationTestSuiteID], [ValidationTestSuiteName], [ValidationTestSuiteTag], [Enabled]) VALUES (13, 'T7 Price validation', 'T7_Price_Validation', 1)
INSERT INTO [dbo].[ValidationTestSuite] ([ValidationTestSuiteID], [ValidationTestSuiteName], [ValidationTestSuiteTag], [Enabled]) VALUES (14, 'XT - Early arriving facts check', 'XT_EARLY_ARRIVING_FACTS', 1)
SET IDENTITY_INSERT [dbo].[ValidationTestSuite] OFF
 
PRINT(N'Add 2 rows to [dbo].[XT_UpdateControl]')
INSERT INTO [dbo].[XT_UpdateControl] ([TableName], [ExtractSequenceId], [LastChecked], [LastUpdated], [LastUpdateBatchID]) VALUES ('EquityStage', 0, '2017-05-02 12:16:42.6600000', '2017-05-02 11:50:21.3800000', -1)
INSERT INTO [dbo].[XT_UpdateControl] ([TableName], [ExtractSequenceId], [LastChecked], [LastUpdated], [LastUpdateBatchID]) VALUES ('IssuerStage', 0, '2017-05-02 12:16:42.6600000', '2017-05-02 11:50:21.3833333', -1)
 
PRINT(N'Add 22 rows to [dbo].[ValidationUnitTest]')
SET IDENTITY_INSERT [dbo].[ValidationUnitTest] ON
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (1, 1, 'Dummy test - Pass', 'ALWAYS_PASS', 1, 'STAGING', 'dbo.ValidateAlwaysPass', 1, 1, 0, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (2, 1, 'Dummy test - Fail', 'ALWAYS_FAIL', -1, 'STAGING', 'dbo.ValidateAlwaysFail', 0, 1, 0, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (5, 1, 'Dummy test - Fail', 'ALWAYS_FAIL2', 2, 'STAGING', 'dbo.ValidateAlwaysFail', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (6, 4, 'T7 File Receipt Order', 'T7_RECEIPT_ORDER', 1, 'STAGING', 'dbo.ValidateSaftFileOrder', 0, 1, 0, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (9, 4, 'T7 File Date Check', 'T7_DATE', 2, 'STAGING', 'dbo.ValidateSaftFileDate', 0, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (13, 4, 'T7 Verfiy file pair exists', 'T7_FILE_PAIR', 3, 'STAGING', 'dbo.ValidateSaftMatchingPair', 0, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (15, 5, 'XT Interface - Basic lookusp', 'XT_BASIC_LOOKUP', 3, 'STAGING', 'dbo.ValidateXtInterfaceBasicLookups', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (16, 6, 'Required file - warning', 'REQUIRED_FILE_WARNING', 1, 'STAGING', 'dbo.ValidateRequiredFileWarning', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (22, 8, 'Required file - error', 'REQUIRED_FILE_ERROR', 1, 'STAGING', 'dbo.ValidateRequiredFileError', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (24, 9, 'Required file - found', 'REQUIRED_FILES_FOUND', 1, 'STAGING', 'dbo.ValidateRequiredFileFound', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (25, 10, 'T7 Trade Validation', 'T7_MAIN_DATAFLOW_SIMPLE', 1, 'STAGING', 'dbo.ValidateT7TradeMainDataFlowOutputQuarantine', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (26, 11, 'T7 File row count', 'T7_TXSAFT_FILE_ROW_COUNT', 1, 'STAGING', 'dbo.ValidateFileRowCount', 1, 1, 0, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (30, 11, 'T7 File delayed trades', 'T7_TXSAFT_FILE_DELAYED_TRADE_DATE', 2, 'STAGING', 'dbo.ValidateFileDelayedTradeTime', 1, 1, 0, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (31, 13, 'T7 Price / ISIN ', 'T7_MISSING_ISIN', 1, 'DWH', 'ETL.ValidatePriceFileBidOffer', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (35, 4, 'Pre-stage - file duplcicates', 'FILE_DUPLICATES', 4, 'STAGING', 'dbo.ValidateFileDuplicates', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (37, 14, 'XT- Early arriving fact check', 'XT_EARLY_FACT', 1, 'STAGING', 'dbo.ValidateFindEarlyArrivingFacts', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (38, 5, 'XT - InstrumentType change', 'XT_INTERFACE_INSTRUMENT_TYPE_CHANGE', 1, 'STAGING', 'dbo.ValidateXtInterfaceInstrumentType', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (41, 5, 'XT - Company GID change', 'XT_INTERFACE_COMPANY_CHANGE', 4, 'STAGING', 'dbo.ValidateXtInterfaceCompanyGID', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (43, 5, 'XT - Optional missing fields warnings', 'XT_MISSING_FIELDS_WARNING', 2, 'STAGING', 'dbo.ValidateXtInterfaceOptionalFieldWarning', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (45, 5, 'XT - Warning plus fixes', 'XT_WARNING_PLUS_FIX', 4, 'STAGING', 'dbo.ValidateXtInterfacedWarningPlusFix', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (46, 10, 'T7 Trade Validation - Bad Deffered Time', 'T7_MAIN_DATAFLOW_BAD_DEFERRED', 2, 'STAGING', 'dbo.ValidateT7TradeMainDataFlowOutputQuarantine_NoDeferredDateSet', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (47, 10, 'T7 Trade Validation - ND Without Deffered Flag', 'T7_MAIN_DATAFLOW_ND_MISSING_DEFERRED', 3, 'STAGING', 'dbo.ValidateT7TradeMainDataFlowOutputQuarantine_NegotiatedTradeWithoutDelay', 1, 0, 1, 0)
SET IDENTITY_INSERT [dbo].[ValidationUnitTest] OFF
 
PRINT(N'Add constraints to [dbo].[ValidationUnitTest]')
ALTER TABLE [dbo].[ValidationUnitTest] WITH CHECK CHECK CONSTRAINT [FK_ValidationUnitTest_ValidationTestSuite]
COMMIT TRANSACTION
GO
