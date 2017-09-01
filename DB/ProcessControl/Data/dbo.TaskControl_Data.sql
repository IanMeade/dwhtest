SET IDENTITY_INSERT [dbo].[TaskControl] ON
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('DATE_UPDATE         ', 18, 'Update date dimension', 'Y', 'DAILY_MESSAGE', '')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('INDEX_AGGREGATION   ', 217, 'IndexValue Aggregation', 'Y', 'WORKDAY', '')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('MASTER_LOOP         ', 216, 'Run Master Package in loop', 'Y', 'DAILY:[06:00:22:30]', '')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('OVERNIGHT_JOBS      ', 1, 'Overnight jobs', 'Y', 'DAILY:[22:00:23:00]', '')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('PRESTAGE_FILES      ', 3, 'Look for files to process', 'Y', 'WORKDAY', '')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('PST_ORACLE          ', 17, 'Send ProcessStatus to Oracle', 'Y', 'ALWAYS', '')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('RAWTC_NEW_ODS       ', 219, 'RAWTC810 - load to ODS - New format', 'Y', 'WORKDAY', 'FILE_FOUND_RAWTC_810_NEW')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('RAWTC_ODS           ', 9, 'RAWTC810 - load to ODS', 'Y', 'WORKDAY', 'FILE_FOUND_RAWTC_810')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('REUTERS_FX_RATES    ', 14, 'Exchange rates', 'Y', 'WORKDAY', '')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('REUTERS_INDEX_LOAD  ', 11, 'Reuters Index Load', 'Y', 'DAILY:[06:00:23:00]', '')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('STATESTREET_ODS     ', 10, 'StateStreet load - files to ODS', 'Y', 'WORKDAY', 'ODS_FILE_LOAD_StateStreet_ODS')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('STOXX_ODS           ', 8, 'Stoxx load - files load to ODS', 'Y', 'WORKDAY', 'ODS_FILE_LOAD_Stoxx_ODS')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('T7_AGGREGATIONS_1   ', 116, 'T7 Aggregations', 'Y', 'WORKDAY', 'FILE_FOUND_TxSaft')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('T7_AGGREGATIONS_2   ', 117, 'T7 Aggregations', 'Y', 'WORKDAY', 'FILE_FOUND_PriceFile')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('T7_AGGREGATIONS_3   ', 118, 'T7 Aggregations', 'Y', 'WORKDAY', 'FOUND_SETS')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('T7_PRICE            ', 5, 'T7 Price files', 'Y', 'WORKDAY', 'FILE_FOUND_PriceFile')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('T7_SAFT             ', 4, 'T7 SAFT Trade files', 'Y', 'WORKDAY', 'FILE_FOUND_TxSaft')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('UPDATE_MDM_DIMS     ', 2, 'MDM based dimensions', 'Y', 'ALWAYS', '')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('XT_CORPORATE_ACTION ', 115, 'XT Corporate Actions', 'Y', 'WORKDAY', '')
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('XT_INTERFACE        ', 6, 'XT Interface', 'Y', 'WORKDAY', '')
SET IDENTITY_INSERT [dbo].[TaskControl] OFF
SET IDENTITY_INSERT [dbo].[TaskControl] ON
INSERT INTO [dbo].[TaskControl] ([TaskControlTag], [TaskControlID], [TaskControlName], [TaskControlEnabledYN], [TaskControlRuleSchedule], [DependencyCheck]) VALUES ('T7_AGGREGATIONS     ', 7, 'T7 Aggregations', 'Y', 'WORKDAY', '')
SET IDENTITY_INSERT [dbo].[TaskControl] OFF
