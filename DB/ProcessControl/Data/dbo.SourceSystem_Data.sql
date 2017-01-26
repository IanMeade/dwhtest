SET IDENTITY_INSERT [dbo].[SourceSystem] ON
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (1, 'DWH', 'DWH', 'XX', 'Y', NULL, NULL)
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (2, 'Staging', 'Staging', 'XX', 'Y', NULL, NULL)
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (3, 'MDM', 'MDM', 'XX', 'Y', NULL, NULL)
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (4, 'T7', 'T7', 'XX', 'Y', NULL, NULL)
INSERT INTO [dbo].[SourceSystem] ([SourceSystemID], [SourceSystemName], [SourceSystemTag], [ConnectionString], [EnabledYN], [CutOffMechanismTag], [CutOffChar]) VALUES (6, 'XML', 'XML', 'XX', 'Y', NULL, NULL)
SET IDENTITY_INSERT [dbo].[SourceSystem] OFF
