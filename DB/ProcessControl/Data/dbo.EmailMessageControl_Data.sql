SET IDENTITY_INSERT [dbo].[EmailMessageControl] ON
INSERT INTO [dbo].[EmailMessageControl] ([MessageID], [MessageTag], [MessageTo], [MessageCC], [MessageSubject], [MessageBody], [MessagePriority], [MessageEnabledYN]) VALUES (1, 'ERROR MESSAGE', 'XXX', 'XXX', 'ERROR HANDLER', 'GENERIC ERROR', 3, 'Y')
SET IDENTITY_INSERT [dbo].[EmailMessageControl] OFF
