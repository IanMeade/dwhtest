CREATE TABLE [dbo].[Switches]
(
[SwitchKey] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[SwitchValue] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Switches] ADD CONSTRAINT [PK_Switches] PRIMARY KEY CLUSTERED  ([SwitchKey]) ON [PRIMARY]
GO
