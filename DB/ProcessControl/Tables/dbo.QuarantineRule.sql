CREATE TABLE [dbo].[QuarantineRule]
(
[QuarantineRuleID] [smallint] NOT NULL,
[QuarantineRuleTag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[Entity] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[EnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[RuleDescription] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[RuleFunction] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuarantineRule] ADD CONSTRAINT [PK_QuarantineRule] PRIMARY KEY CLUSTERED  ([QuarantineRuleID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuarantineRule] ADD CONSTRAINT [IX_QuarantineRule] UNIQUE NONCLUSTERED  ([QuarantineRuleTag]) ON [PRIMARY]
GO
