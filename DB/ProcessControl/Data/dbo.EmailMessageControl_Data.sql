SET IDENTITY_INSERT [dbo].[EmailMessageControl] ON
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (7, 'REUTERS_INDEX_ERROR', 'ianm@sys-ise.ie', '', 'Error processing Reuters Index Values', 'Error!!!!!!', 3, 'Y')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] OFF
SET IDENTITY_INSERT [dbo].[EmailMessageControl] ON
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (2, 'GENERIC_VALIDATION_WARNING', 'XXX', 'XXX', 'Warning raised by validation', 'Warning raised by validation', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (3, 'GENERIC_VALIDATION_ERROR', 'ianm@sys-ise.ie', '', 'Error raised by validation', 'Validation erro reaised', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (4, 'ALWAYS_FAIL2', 'ianm@sys-ise.ie', '', 'From validation suite', 'Validationm message saved in ProcessControl ValidationLogMessage', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (5, 'T7_MAIN_DATAFLOW_SIMPLE', 'ianm@sys-ise.ie', '', 'DWH - T7 Validation issue', NULL, NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (6, 'XT_EARLY_FACT', 'ianm@sys-ise.ie', '', 'XT Currency added to DWH', NULL, NULL, 'Y')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] OFF
SET IDENTITY_INSERT [dbo].[EmailMessageControl] ON
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (1, 'GENERIC_ERROR', 'ianm@sys-ise.ie', '', 'ERROR HANDLER', 'GENERIC ERROR', 3, 'Y')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] OFF
