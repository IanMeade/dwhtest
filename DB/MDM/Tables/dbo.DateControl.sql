CREATE TABLE [dbo].[DateControl]
(
[StartYear] [smallint] NOT NULL,
[EndYear] [smallint] NOT NULL,
[NormalTradingStartTime] [time] NOT NULL,
[NormalTradingEndTime] [time] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DateControl] ADD CONSTRAINT [PK_DateControl] PRIMARY KEY CLUSTERED  ([StartYear]) ON [PRIMARY]
GO
