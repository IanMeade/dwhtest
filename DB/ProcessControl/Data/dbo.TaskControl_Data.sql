SET IDENTITY_INSERT [dbo].[TaskControl] ON
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (1, 'Overnight jobs', 'OVERNIGHT_JOBS      ', 'Y', 'DAILY:[21:00:22:00]')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (2, 'MDM based dimensions', 'UPDATE_MDM_DIMS     ', 'Y', 'ALWAYS')
SET IDENTITY_INSERT [dbo].[TaskControl] OFF
