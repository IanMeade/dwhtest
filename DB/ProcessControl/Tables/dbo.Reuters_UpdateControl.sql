CREATE TABLE [dbo].[Reuters_UpdateControl]
(
[TableName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[LastCutOffCounterUsed] [int] NOT NULL,
[LastChecked] [datetime2] NULL,
[LastUpdated] [datetime2] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Reuters_UpdateControl] ADD CONSTRAINT [PK_Reuters_UpdateControl] PRIMARY KEY CLUSTERED  ([TableName]) ON [PRIMARY]
GO
