SET IDENTITY_INSERT [dbo].[ProcessStatus] ON
INSERT INTO [dbo].[ProcessStatus] ([ProcessStatusID], [BatchID], [Message], [MessageDateTime]) VALUES (1, -1, 'TESTING', '2017-04-07 14:19:41.2166667')
INSERT INTO [dbo].[ProcessStatus] ([ProcessStatusID], [BatchID], [Message], [MessageDateTime]) VALUES (2, -1, 'TESTING', '2017-04-07 14:19:43.4666667')
INSERT INTO [dbo].[ProcessStatus] ([ProcessStatusID], [BatchID], [Message], [MessageDateTime]) VALUES (3, 22, '', '2017-04-07 14:26:23.8600000')
INSERT INTO [dbo].[ProcessStatus] ([ProcessStatusID], [BatchID], [Message], [MessageDateTime]) VALUES (4, -1, '', '2017-04-07 14:27:07.7633333')
INSERT INTO [dbo].[ProcessStatus] ([ProcessStatusID], [BatchID], [Message], [MessageDateTime]) VALUES (5, 22, 'Message 1', '2017-04-07 14:28:07.2500000')
SET IDENTITY_INSERT [dbo].[ProcessStatus] OFF
