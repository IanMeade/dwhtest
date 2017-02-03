CREATE ROLE [ReportRunner]
AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'ReportRunner', N'STOCK_EXCHANGE\G_DWReportRunner'
GO
