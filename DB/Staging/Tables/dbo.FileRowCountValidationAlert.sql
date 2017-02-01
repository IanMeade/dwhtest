CREATE TABLE [dbo].[FileRowCountValidationAlert]
(
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[AlertTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Reason] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL,
[Action] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
