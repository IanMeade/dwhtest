SET IDENTITY_INSERT [dbo].[EmailMessageControl] ON
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (1, 'GENERIC_ERROR', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'ERROR HANDLER', 'GENERIC ERROR', 3, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (2, 'GENERIC_VALIDATION_WARNING', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', 'XXX', 'Warning raised by validation', 'Warning raised by validation', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (3, 'GENERIC_VALIDATION_ERROR', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Error raised by validation', 'Validation erro reaised', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (4, 'ALWAYS_FAIL2', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'From validation suite', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (5, 'T7_MAIN_DATAFLOW_SIMPLE', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH - T7 Validation issue', NULL, NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (6, 'XT_EARLY_FACT', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'XT Currency added to DWH', NULL, NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (7, 'REUTERS_INDEX_ERROR', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Error processing Reuters Index Values', 'Error!!!!!!', 3, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (8, 'ALWAYS_PASS', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Dummy test - Pass', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (9, 'ALWAYS_FAIL', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Dummy test - Fail', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (10, 'T7_RECEIPT_ORDER', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'T7 File Receipt Order', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (11, 'T7_DATE', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'T7 File Date Check', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (12, 'T7_FILE_PAIR', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'T7 Verfiy file pair exists', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (13, 'XT_BASIC_LOOKUP', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'XT Interface - Basic lookusp', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (14, 'REQUIRED_FILE_WARNING', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Required file - warning', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (15, 'REQUIRED_FILE_ERROR', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Required file - error', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (16, 'REQUIRED_FILES_FOUND', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Required file - found', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (17, 'T7_TXSAFT_FILE_ROW_COUNT', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'T7 File row count', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (18, 'T7_TXSAFT_FILE_DELAYED_TRADE_DATE', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'T7 File delayed trades', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (19, 'T7_MISSING_ISIN', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'T7 Price / ISIN ', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (20, 'FILE_DUPLICATES', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Pre-stage - file duplcicates', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (21, 'XT_INTERFACE_INSTRUMENT_TYPE_CHANGE', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'XT - InstrumentType change', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (22, 'XT_INTERFACE_COMPANY_CHANGE', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'XT - Company GID change', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (23, 'XT_MISSING_FIELDS_WARNING', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'XT - Optional missing fields warnings', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (24, 'XT_WARNING_PLUS_FIX', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'XT - Warning plus fixes', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (25, 'T7_MAIN_DATAFLOW_BAD_DEFERRED', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'T7 Trade Validation - Bad Deffered Time', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (26, 'T7_MAIN_DATAFLOW_ND_MISSING_DEFERRED', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'T7 Trade Validation - ND Without Deffered Flag', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (108, 'FILE_PRESTAGE', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - FILE_PRESTAGE', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (109, 'MAIN_ETL_FINISH', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - MAIN_ETL_FINISH', '', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (110, 'MAIN_ETL_START', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - MAIN_ETL_START', '', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (111, 'MDM_REFRESH_FINISH', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - MDM_REFRESH_FINISH', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (112, 'MESSAGE', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - MESSAGE', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (113, 'Message 1', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - Message 1', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (114, 'RAWTC_810_DWH', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - RAWTC_810_DWH', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (115, 'RAWTC_810_ODS', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - RAWTC_810_ODS', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (116, 'REUTERS_EXCHANGE_RATES', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - REUTERS_EXCHANGE_RATES', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (117, 'SAFT_LOAD', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - SAFT_LOAD', '', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (118, 'STATESTREET_ODS', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - STATESTREET_ODS', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (119, 'STOXX_ODS', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - STOXX_ODS', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (120, 'T7_AGGREGATION', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - T7_AGGREGATION', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (121, 'T7_PRICE_STAGE', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - T7_PRICE_STAGE', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (122, 'T7_SAFT_ODS', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - T7_SAFT_ODS', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (123, 'TESTING', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - TESTING', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (124, 'Translated message', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - Translated message', '', NULL, 'N')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (125, 'XT_INTERFACE_COMPLETE', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - XT_INTERFACE_COMPLETE', '', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (126, 'XT_INTERFACE_START', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'DWH: ProcessStatus Message - XT_INTERFACE_START', '', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (134, '
REQUIRED_PRICE_FILE_WARNING', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Expected File Not Received', ' ', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (135, 'REQUIRED_SAFT_FILE_WARNING', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Expected File Not Received', '', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (208, 'DWH_INSTRUMENT_CHECK', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Validation message', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (209, 'REQUIRED_PRICE_FILE_WARNING', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Validation message', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (210, 'T7_ORDER_BOOK_WITH_DEFERRED', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Validation message', 'Validation message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (211, 'XT_CA_BASIC', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Validation message', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (213, 'PENDING_CANCELATIONS', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'There are SAFT cancellations pending review', 'There are SAFT cancellations pending review - files will not be marked complete until they are reviewed', NULL, 'Y')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] OFF
SET IDENTITY_INSERT [dbo].[EmailMessageControl] ON
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (212, 'T7_EARLY_FACTS', 'ianm@sys-ise.ie;JasonK@sys-ise.ie;Richardd@sys-ise.ie;SeamusM@sys-ise.ie;MariaK@sys-ise.ie;RosemaryL@sys-ise.ie', '', 'Early arriving facts - dimension entry has been created automagically', 'Validation message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] OFF
