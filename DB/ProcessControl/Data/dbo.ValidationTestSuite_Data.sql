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
SET IDENTITY_INSERT [dbo].[ValidationTestSuite] OFF
