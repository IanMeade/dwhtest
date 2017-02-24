CREATE ROLE [ReportRunner]
AUTHORIZATION [dbo]
EXEC sp_addrolemember N'ReportRunner', N'ReportRunner_test'

GO
EXEC sp_addrolemember N'ReportRunner', N'STOCK_EXCHANGE\G_DWReportRunner'
GO
