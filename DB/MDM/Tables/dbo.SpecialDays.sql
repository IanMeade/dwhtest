CREATE TABLE [dbo].[SpecialDays]
(
[SpecialDate] [date] NOT NULL,
[HolidayYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TradingStartTime] [time] NOT NULL,
[TradingEndTime] [time] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SpecialDays] ADD CONSTRAINT [PK_SpecialDays] PRIMARY KEY CLUSTERED  ([SpecialDate]) ON [PRIMARY]
GO
