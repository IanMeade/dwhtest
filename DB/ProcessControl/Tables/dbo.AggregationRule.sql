CREATE TABLE [dbo].[AggregationRule]
(
[AggregationRuleID] [smallint] NOT NULL,
[AggregationRuleName] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[AgregationRuleTag] [char] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[AggregationRuleTarget] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[AggregationRuleEnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[AggregationRuleSchedule] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AggregationRule] ADD CONSTRAINT [PK_AggregationRule] PRIMARY KEY CLUSTERED  ([AggregationRuleID]) ON [PRIMARY]
GO
