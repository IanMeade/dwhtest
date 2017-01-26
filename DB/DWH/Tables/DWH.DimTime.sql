CREATE TABLE [DWH].[DimTime]
(
[TimeID] [smallint] NOT NULL,
[Time] [time] (2) NOT NULL,
[TimeHourText] [char] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[TimeMinuteText] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimTime] ADD CONSTRAINT [PK_DimTime] PRIMARY KEY CLUSTERED  ([TimeID]) ON [PRIMARY]
GO
