CREATE TABLE [dbo].[ValidationUnitTest]
(
[ValidationUnitTestID] [int] NOT NULL IDENTITY(1, 1),
[ValidationTestSuiteID] [int] NOT NULL,
[ValidationUnitTestName] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[ValidationUnitTestTag] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[RunOrder] [int] NOT NULL,
[TestDatabase] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[TestStoredProcedure] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[Enabled] [bit] NOT NULL,
[ErrorCondition] [bit] NOT NULL,
[WarningCondition] [bit] NOT NULL,
[SilentChanges] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ValidationUnitTest] ADD CONSTRAINT [PK_ValidationTest] PRIMARY KEY CLUSTERED  ([ValidationUnitTestID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ValidationUnitTest] ON [dbo].[ValidationUnitTest] ([ValidationUnitTestTag]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ValidationUnitTest] ADD CONSTRAINT [FK_ValidationUnitTest_ValidationTestSuite] FOREIGN KEY ([ValidationTestSuiteID]) REFERENCES [dbo].[ValidationTestSuite] ([ValidationTestSuiteID])
GO
