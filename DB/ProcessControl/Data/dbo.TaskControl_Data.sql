SET IDENTITY_INSERT [dbo].[TaskControl] ON
INSERT INTO [dbo].[TaskControl] ([TaskControlID], [TaskControlName], [TaskControlTag], [TaskControlEnabledYN], [TaskControlRuleSchedule]) VALUES (115, 'XT Corporate Actions', 'XT_CORPORATE_ACTION ', 'N', 'ALWAYS')
SET IDENTITY_INSERT [dbo].[TaskControl] OFF
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
