CREATE TABLE [dbo].[QuarantineLog]
(
[QuarantineLogID] [int] NOT NULL,
[QuarantineRuleID] [smallint] NOT NULL,
[Entity] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[RowID] [int] NOT NULL,
[QuartineEntryDatetime] [datetime2] NOT NULL,
[QuarantineExitDatetime] [datetime2] NULL,
[QuarantineLastCheckDatetime] [datetime2] NULL,
[QuartineEntryBatchID] [int] NOT NULL,
[QuartineExitBatchID] [int] NULL,
[QuartinelastCheckBatchID] [int] NULL,
[RetryCount] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuarantineLog] ADD CONSTRAINT [PK_QuarantineLog] PRIMARY KEY CLUSTERED  ([QuarantineLogID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuarantineLog] ADD CONSTRAINT [FK_QuarantineLog_QuarantineRule] FOREIGN KEY ([QuarantineRuleID]) REFERENCES [dbo].[QuarantineRule] ([QuarantineRuleID])
GO
