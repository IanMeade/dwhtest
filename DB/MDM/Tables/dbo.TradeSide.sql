CREATE TABLE [dbo].[TradeSide]
(
[TradeSideCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[TradeSideName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TradeSide] ADD CONSTRAINT [PK__TradeSid__9D52F5B014D8C226] PRIMARY KEY CLUSTERED  ([TradeSideCode]) ON [PRIMARY]
GO
