CREATE TABLE [dbo].[MdmSpecialDays]
(
[SpecialDate] [date] NOT NULL,
[HolidayYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TradingStartTime] [time] NOT NULL,
[TradingEndTime] [time] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MdmSpecialDays] ADD CONSTRAINT [PK_MdmSpecialDays] PRIMARY KEY CLUSTERED  ([SpecialDate]) ON [PRIMARY]
GO
