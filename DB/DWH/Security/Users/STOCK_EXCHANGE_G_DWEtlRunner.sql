IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'STOCK_EXCHANGE\G_DWEtlRunner')
CREATE LOGIN [STOCK_EXCHANGE\G_DWEtlRunner] FROM WINDOWS
GO
