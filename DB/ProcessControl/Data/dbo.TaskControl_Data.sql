SET IDENTITY_INSERT [dbo].[TaskControl] ON
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (3, 'Look for files to process', 'PRESTAGE_FILES      ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (4, 'T7 SAFT Trade files', 'T7_SAFT             ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (5, 'T7 Price files', 'T7_PRICE            ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (6, 'XT Interface', 'XT_INTERFACE        ', 'Y', 'ALWAYS')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (7, 'T7 Aggregations', 'T7_AGGREGATIONS     ', 'Y', 'ALWAYS')
SET IDENTITY_INSERT [dbo].[TaskControl] OFF
SET IDENTITY_INSERT [dbo].[TaskControl] ON
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (1, 'Overnight jobs', 'OVERNIGHT_JOBS      ', 'Y', 'DAILY:[14:00:15:00]')
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (2, 'MDM based dimensions', 'UPDATE_MDM_DIMS     ', 'Y', 'ALWAYS')
SET IDENTITY_INSERT [dbo].[TaskControl] OFF
