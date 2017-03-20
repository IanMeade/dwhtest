SET IDENTITY_INSERT [dbo].[EmailMessageControl] ON
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (2, 'GENERIC_VALIDATION_WARNING', 'XXX', 'XXX', 'Warning raised by validation', 'Warning raised by validation', NULL, 'Y')
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (3, 'GENERIC_VALIDATION_ERROR', 'XXX', 'XXX', 'Error raised by validation', 'Validation erro reaised', NULL, 'Y')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] OFF
SET IDENTITY_INSERT [dbo].[EmailMessageControl] ON
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (1, 'GENERIC_ERROR', 'XXX', 'XXX', 'ERROR HANDLER', 'GENERIC ERROR', 3, ' ')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] OFF
