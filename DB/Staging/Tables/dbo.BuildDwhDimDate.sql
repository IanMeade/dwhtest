CREATE TABLE [dbo].[BuildDwhDimDate]
(
[DateID] [int] NOT NULL,
[DateText] [varchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Day] [date] NULL,
[WorkingDayYN] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[Year] [smallint] NULL,
[MonthNo] [smallint] NULL,
[MonthName] [varchar] (20) COLLATE Latin1_General_CI_AS NULL,
[QuarterNo] [smallint] NULL,
[QuarterText] [varchar] (30) COLLATE Latin1_General_CI_AS NULL,
[YearQuarterNo] [int] NULL,
[YearQuarterText] [varchar] (30) COLLATE Latin1_General_CI_AS NULL,
[MonthDayNo] [smallint] NULL,
[DayText] [varchar] (20) COLLATE Latin1_General_CI_AS NULL,
[MonthToDateYN] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[YearToDateYN] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TradingStartTime] [time] NULL,
[TradingEndTime] [time] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BuildDwhDimDate] ADD CONSTRAINT [PK_BuildDwhDimDate] PRIMARY KEY CLUSTERED  ([DateID]) ON [PRIMARY]
GO
