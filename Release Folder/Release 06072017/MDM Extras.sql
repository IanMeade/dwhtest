
PRINT N'Creating [dbo].[TradeSide]'
GO
CREATE TABLE [dbo].[TradeSide] 
( 
[TradeSideCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeSideName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__TradeSid__9D52F5B014D8C226] on [dbo].[TradeSide]'
GO
ALTER TABLE [dbo].[TradeSide] ADD CONSTRAINT [PK__TradeSid__9D52F5B014D8C226] PRIMARY KEY CLUSTERED  ([TradeSideCode])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO






PRINT(N'Add 2 rows to [dbo].[TradeSide]')
INSERT INTO [dbo].[TradeSide] ([TradeSideCode], [TradeSideName]) VALUES ('B', 'Buy')
INSERT INTO [dbo].[TradeSide] ([TradeSideCode], [TradeSideName]) VALUES ('S', 'Sell')