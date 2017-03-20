CREATE TABLE [dbo].[ValidationLog]
(
[ValidationLogID] [int] NOT NULL IDENTITY(1, 1),
[BatchID] [int] NOT NULL,
[ValidationUnitTestID] [int] NOT NULL,
[UnitTestRun] [datetime2] NOT NULL CONSTRAINT [DF_ValidationLog_UnitTestRun] DEFAULT (getdate()),
[ErrorCount] [int] NOT NULL,
[WarningCount] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ValidationLog] ADD CONSTRAINT [PK_ValidationLog] PRIMARY KEY CLUSTERED  ([ValidationLogID]) ON [PRIMARY]
GO
