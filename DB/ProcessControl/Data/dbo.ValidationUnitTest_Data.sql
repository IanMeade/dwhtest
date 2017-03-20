SET IDENTITY_INSERT [dbo].[ValidationUnitTest] ON
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (1, 1, 'Dummy test - Pass', 'ALWAYS_PASS', 1, 'STAGING', 'dbo.ValidateAlwaysPass', 1, 1, 0, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (2, 5, 'Dummy test - Fail', 'ALWAYS_FAIL', -1, 'STAGING', 'dbo.ValidateAlwaysFail', 0, 1, 0, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (5, 1, 'Dummy test - Fail', 'ALWAYS_FAIL2', 2, 'STAGING', 'dbo.ValidateAlwaysFail', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (6, 4, 'T7 File Receipt Order', 'T7_RECEIPT_ORDER', 1, 'STAGING', 'dbo.ValidateSaftFileOrder', 0, 1, 0, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (9, 4, 'T7 File Date Check', 'T7_DATE', 2, 'STAGING', 'dbo.ValidateSaftFileDate', 0, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (13, 4, 'T7 Verfiy file pair exists', 'T7_FILE_PAIR', 3, 'STAGING', 'dbo.ValidateSaftMatchingPair', 0, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (15, 5, 'XT Interface - Basic lookusp', 'XT_BASIC_LOOKUP', 1, 'STAGING', 'dbo.ValidateXtInterfaceBasicLookups', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (16, 6, 'Required file - warning', 'REQUIRED_FILE_WARNING', 1, 'STAGING', 'dbo.ValidateRequiredFileWarning', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (22, 8, 'Required file - error', 'REQUIRED_FILE_ERROR', 1, 'STAGING', 'dbo.ValidateRequiredFileError', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (24, 9, 'Required file - found', 'REQUIRED_FILES_FOUND', 1, 'STAGING', 'dbo.ValidateRequiredFileFound', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (25, 10, 'T7 Trade Validation', 'T7_MAIN_DATAFLOW_SIMPLE', 1, 'STAGING', 'dbo.ValidateT7TradeMainDataFlowOutputQuarantine', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (26, 11, 'T7 File row count', 'T7_TXSAFT_FILE_ROW_COUNT', 1, 'STAGING', 'dbo.ValidateFileRowCount', 1, 1, 0, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (30, 11, 'T7 File delayed trades', 'T7_TXSAFT_FILE_DELAYED_TRADE_DATE', 2, 'STAGING', 'dbo.ValidateFileDelayedTradeTime', 1, 1, 0, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (31, 13, 'T7 Price / ISIN ', 'xxx', 1, 'DWH', 'ETL.ValidatePriceFileBidOffer', 1, 0, 1, 0)
INSERT INTO [dbo].[ValidationUnitTest] ([ValidationUnitTestID], [ValidationTestSuiteID], [ValidationUnitTestName], [ValidationUnitTestTag], [RunOrder], [TestDatabase], [TestStoredProcedure], [Enabled], [ErrorCondition], [WarningCondition], [SilentChanges]) VALUES (35, 4, 'Pre-stage - file duplcicates', 'FILE_DUPLICATES', 4, 'STAGING', 'dbo.ValidateFileDuplicates', 1, 0, 1, 0)
SET IDENTITY_INSERT [dbo].[ValidationUnitTest] OFF