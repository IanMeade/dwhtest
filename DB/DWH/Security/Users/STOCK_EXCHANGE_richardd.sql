IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'STOCK_EXCHANGE\richardd')
CREATE LOGIN [STOCK_EXCHANGE\richardd] FROM WINDOWS
GO
