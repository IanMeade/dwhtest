CREATE TABLE [dbo].[MdmExtraDates]
(
[DateID] [int] NOT NULL,
[DateText] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[Day] [date] NOT NULL,
[WorkingDayYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[Year] [smallint] NOT NULL,
[MonthNo] [smallint] NOT NULL,
[MonthName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[QuarterNo] [smallint] NOT NULL,
[QuarterText] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[YearQuarterNo] [int] NOT NULL,
[YearQuarterText] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[MonthDayNo] [smallint] NOT NULL,
[DayText] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[MonthToDateYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[YearToDateYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TradingStartTime] [time] NOT NULL,
[TradingEndTime] [time] NOT NULL
) ON [PRIMARY]
GO
