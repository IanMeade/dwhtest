CREATE TABLE [dbo].[ScheduledActivitiesTimeExpected]
(
[Activity] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[ExpectedTime] [time] NOT NULL,
[LastProcessed] [datetime2] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ScheduledActivitiesTimeExpected] ADD CONSTRAINT [PK_ScheduledActivitiesTimeExpected] PRIMARY KEY CLUSTERED  ([Activity], [ExpectedTime]) ON [PRIMARY]
GO
