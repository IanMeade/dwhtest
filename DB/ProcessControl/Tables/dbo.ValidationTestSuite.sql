CREATE TABLE [dbo].[ValidationTestSuite]
(
[ValidationTestSuiteID] [int] NOT NULL IDENTITY(1, 1),
[ValidationTestSuiteName] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[ValidationTestSuiteTag] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[Enabled] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ValidationTestSuite] ADD CONSTRAINT [PK_ValidationControl] PRIMARY KEY CLUSTERED  ([ValidationTestSuiteID]) ON [PRIMARY]
GO
