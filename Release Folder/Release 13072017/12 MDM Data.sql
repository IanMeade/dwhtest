USE MDM

/* 
Run this script on: 
 
T7-DDT-07.MDM    -  This database will be modified 
 
to synchronize it with: 
 
T7-DDT-01.MDM 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Data Compare version 12.0.33.3389 from Red Gate Software Ltd at 13/07/2017 13:41:13 
 
*/ 
		
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)
 
PRINT(N'Add rows to [dbo].[SpecialDays]')
INSERT INTO [dbo].[SpecialDays] ([SpecialDate], [HolidayYN], [TradingStartTime], [TradingEndTime]) VALUES ('2017-04-14', 'Y', '00:00:00.0000000', '00:00:00.0000000')
INSERT INTO [dbo].[SpecialDays] ([SpecialDate], [HolidayYN], [TradingStartTime], [TradingEndTime]) VALUES ('2017-04-17', 'Y', '00:00:00.0000000', '00:00:00.0000000')
INSERT INTO [dbo].[SpecialDays] ([SpecialDate], [HolidayYN], [TradingStartTime], [TradingEndTime]) VALUES ('2017-05-01', 'Y', '00:00:00.0000000', '00:00:00.0000000')
INSERT INTO [dbo].[SpecialDays] ([SpecialDate], [HolidayYN], [TradingStartTime], [TradingEndTime]) VALUES ('2017-06-05', 'Y', '00:00:00.0000000', '00:00:00.0000000')
INSERT INTO [dbo].[SpecialDays] ([SpecialDate], [HolidayYN], [TradingStartTime], [TradingEndTime]) VALUES ('2017-12-25', 'Y', '00:00:00.0000000', '00:00:00.0000000')
INSERT INTO [dbo].[SpecialDays] ([SpecialDate], [HolidayYN], [TradingStartTime], [TradingEndTime]) VALUES ('2017-12-26', 'Y', '00:00:00.0000000', '00:00:00.0000000')
INSERT INTO [dbo].[SpecialDays] ([SpecialDate], [HolidayYN], [TradingStartTime], [TradingEndTime]) VALUES ('2018-01-01', 'Y', '00:00:00.0000000', '00:00:00.0000000')
PRINT(N'Operation applied to 7 rows out of 7')
COMMIT TRANSACTION
GO
