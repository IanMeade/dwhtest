/* 
Run this script on: 
 
T7-DDT-06.ProcessControl    -  This database will be modified 
 
to synchronize it with: 
 
T7-DDT-01.ProcessControl 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Data Compare version 12.0.33.3389 from Red Gate Software Ltd at 15/05/2017 14:57:18 
 
*/ 
USE ProcessControl
		
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
 
PRINT(N'Add 45 rows to [dbo].[EmailMessageControl]')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] ON
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (1, 'GENERIC_ERROR', 'ianm@sys-ise.ie', '', 'ERROR HANDLER', 'GENERIC ERROR', 3, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (2, 'GENERIC_VALIDATION_WARNING', 'XXX', 'XXX', 'Warning raised by validation', 'Warning raised by validation', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (3, 'GENERIC_VALIDATION_ERROR', 'ianm@sys-ise.ie', '', 'Error raised by validation', 'Validation erro reaised', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (4, 'ALWAYS_FAIL2', 'ianm@sys-ise.ie', '', 'From validation suite', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (5, 'T7_MAIN_DATAFLOW_SIMPLE', 'ianm@sys-ise.ie', '', 'DWH - T7 Validation issue', NULL, NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (6, 'XT_EARLY_FACT', 'ianm@sys-ise.ie', '', 'XT Currency added to DWH', NULL, NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (7, 'REUTERS_INDEX_ERROR', 'ianm@sys-ise.ie', '', 'Error processing Reuters Index Values', 'Error!!!!!!', 3, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (8, 'ALWAYS_PASS', 'ianm@sys-ise.ie', '', 'Dummy test - Pass', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (9, 'ALWAYS_FAIL', 'ianm@sys-ise.ie', '', 'Dummy test - Fail', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (10, 'T7_RECEIPT_ORDER', 'ianm@sys-ise.ie', '', 'T7 File Receipt Order', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (11, 'T7_DATE', 'ianm@sys-ise.ie', '', 'T7 File Date Check', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (12, 'T7_FILE_PAIR', 'ianm@sys-ise.ie', '', 'T7 Verfiy file pair exists', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (13, 'XT_BASIC_LOOKUP', 'ianm@sys-ise.ie', '', 'XT Interface - Basic lookusp', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (14, 'REQUIRED_FILE_WARNING', 'ianm@sys-ise.ie', '', 'Required file - warning', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (15, 'REQUIRED_FILE_ERROR', 'ianm@sys-ise.ie', '', 'Required file - error', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (16, 'REQUIRED_FILES_FOUND', 'ianm@sys-ise.ie', '', 'Required file - found', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (17, 'T7_TXSAFT_FILE_ROW_COUNT', 'ianm@sys-ise.ie', '', 'T7 File row count', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (18, 'T7_TXSAFT_FILE_DELAYED_TRADE_DATE', 'ianm@sys-ise.ie', '', 'T7 File delayed trades', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (19, 'T7_MISSING_ISIN', 'ianm@sys-ise.ie', '', 'T7 Price / ISIN ', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (20, 'FILE_DUPLICATES', 'ianm@sys-ise.ie', '', 'Pre-stage - file duplcicates', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (21, 'XT_INTERFACE_INSTRUMENT_TYPE_CHANGE', 'ianm@sys-ise.ie', '', 'XT - InstrumentType change', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (22, 'XT_INTERFACE_COMPANY_CHANGE', 'ianm@sys-ise.ie', '', 'XT - Company GID change', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (23, 'XT_MISSING_FIELDS_WARNING', 'ianm@sys-ise.ie', '', 'XT - Optional missing fields warnings', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (24, 'XT_WARNING_PLUS_FIX', 'ianm@sys-ise.ie', '', 'XT - Warning plus fixes', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (25, 'T7_MAIN_DATAFLOW_BAD_DEFERRED', 'ianm@sys-ise.ie', '', 'T7 Trade Validation - Bad Deffered Time', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (26, 'T7_MAIN_DATAFLOW_ND_MISSING_DEFERRED', 'ianm@sys-ise.ie', '', 'T7 Trade Validation - ND Without Deffered Flag', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (108, 'FILE_PRESTAGE', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - FILE_PRESTAGE', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (109, 'MAIN_ETL_FINISH', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - MAIN_ETL_FINISH', '', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (110, 'MAIN_ETL_START', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - MAIN_ETL_START', '', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (111, 'MDM_REFRESH_FINISH', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - MDM_REFRESH_FINISH', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (112, 'MESSAGE', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - MESSAGE', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (113, 'Message 1', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - Message 1', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (114, 'RAWTC_810_DWH', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - RAWTC_810_DWH', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (115, 'RAWTC_810_ODS', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - RAWTC_810_ODS', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (116, 'REUTERS_EXCHANGE_RATES', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - REUTERS_EXCHANGE_RATES', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (117, 'SAFT_LOAD', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - SAFT_LOAD', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (118, 'STATESTREET_ODS', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - STATESTREET_ODS', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (119, 'STOXX_ODS', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - STOXX_ODS', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (120, 'T7_AGGREGATION', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - T7_AGGREGATION', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (121, 'T7_PRICE_STAGE', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - T7_PRICE_STAGE', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (122, 'T7_SAFT_ODS', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - T7_SAFT_ODS', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (123, 'TESTING', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - TESTING', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (124, 'Translated message', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - Translated message', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (125, 'XT_INTERFACE_COMPLETE', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - XT_INTERFACE_COMPLETE', '', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (126, 'XT_INTERFACE_START', 'ianm@sys-ise.ie', '', 'DWH: ProcessStatus Message - XT_INTERFACE_START', '', NULL, 'Y')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] OFF
 
PRINT(N'Add 1 row to [dbo].[EmailServer]')
INSERT INTO [dbo].[EmailServer] ([SmptServerAddress], [SentFromMessageBox], [EnabledYN]) VALUES ('172.20.12.44', 'ianm@sys-ise.ie', 'N')
 
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
 
PRINT(N'Add 2 rows to [dbo].[ProcessStatusControl]')
SET IDENTITY_INSERT [dbo].[ProcessStatusControl] ON
INSERT INTO [dbo].[ProcessStatusControl] ([ProcessStatusControlID], [MessageTag], [Message], [SendToOracle]) VALUES (1, 'Message', 'Translated message', 0)
INSERT INTO [dbo].[ProcessStatusControl] ([ProcessStatusControlID], [MessageTag], [Message], [SendToOracle]) VALUES (2, 'ORACLE', 'XXX', 1)
SET IDENTITY_INSERT [dbo].[ProcessStatusControl] OFF
 
PRINT(N'Add 3 rows to [dbo].[Reuters_UpdateControl]')
INSERT INTO [dbo].[Reuters_UpdateControl] ([TableName], [LastCutOffCounterUsed], [LastChecked], [LastUpdated]) VALUES ('ExchangeRateValue', 0, '2017-05-02 12:28:12.4600000', '2017-05-02 12:28:12.4600000')
INSERT INTO [dbo].[Reuters_UpdateControl] ([TableName], [LastCutOffCounterUsed], [LastChecked], [LastUpdated]) VALUES ('IndexValue', 0, '2017-05-15 12:54:02.1100000', '2017-05-15 12:54:02.1100000')
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
 
PRINT(N'Add 14 rows to [dbo].[TaskControl]')
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
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (17, 'Send ProcessStatus to Oracle', 'PST_ORACLE          ', 'N', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (18, 'Update date dimension', 'DATE_UPDATE         ', 'Y', 'DAILY_MESSAGE')
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
INSERT INTO [dbo].[XT_UpdateControl] ([TableName], [ExtractSequenceId], [LastChecked], [LastUpdated], [LastUpdateBatchID]) VALUES ('EquityStage', 0, '2017-05-15 13:09:54.4866667', '2017-05-09 13:16:56.8666667', -1)
INSERT INTO [dbo].[XT_UpdateControl] ([TableName], [ExtractSequenceId], [LastChecked], [LastUpdated], [LastUpdateBatchID]) VALUES ('IssuerStage', 0, '2017-05-15 13:09:54.4866667', '2017-05-09 13:16:56.8700000', -1)
 
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
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (31, 13, 'T7 Price \ ISIN ', 'T7_MISSING_ISIN', 1, 'DWH', 'ETL.ValidatePriceFileBidOffer', 1, 0, 1, 0)
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
