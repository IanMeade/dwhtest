CREATE TABLE [dbo].[TaskControl]
(
[TaskControlID] [smallint] NOT NULL IDENTITY(1, 1),
[TaskControlName] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[TaskControlTag] [char] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[TaskControlEnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TaskControlRuleSchedule] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TaskControl] ADD CONSTRAINT [PK_TaskControl] PRIMARY KEY CLUSTERED  ([TaskControlID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TaskControl] ADD CONSTRAINT [IX_TaskControl] UNIQUE NONCLUSTERED  ([TaskControlID]) ON [PRIMARY]
GO
