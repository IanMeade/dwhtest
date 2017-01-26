CREATE TABLE [dbo].[PrincipalAgent]
(
[PrincipalAgentCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[PrincipalAgentName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PrincipalAgent] ADD CONSTRAINT [PK_PrincipalAgent] PRIMARY KEY CLUSTERED  ([PrincipalAgentCode]) ON [PRIMARY]
GO
