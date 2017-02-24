CREATE ROLE [ReportWriter]
AUTHORIZATION [dbo]
EXEC sp_addrolemember N'ReportWriter', N'ReportWriter_test'

EXEC sp_addrolemember N'ReportWriter', N'STOCK_EXCHANGE\richardd'
GRANT CREATE DEFAULT TO [ReportWriter]
GRANT CREATE FUNCTION TO [ReportWriter]
GRANT CREATE PROCEDURE TO [ReportWriter]
GRANT CREATE RULE TO [ReportWriter]
GRANT CREATE TABLE TO [ReportWriter]
GRANT CREATE VIEW TO [ReportWriter]







GO
EXEC sp_addrolemember N'ReportWriter', N'STOCK_EXCHANGE\G_DWReportWriter'
GO
