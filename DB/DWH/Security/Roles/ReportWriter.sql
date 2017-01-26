CREATE ROLE [ReportWriter]
AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'ReportWriter', N'ReportWriter_test'
GO
EXEC sp_addrolemember N'ReportWriter', N'STOCK_EXCHANGE\G_DWReportWriter'
GO
GRANT CREATE DEFAULT TO [ReportWriter]
GRANT CREATE FUNCTION TO [ReportWriter]
GRANT CREATE PROCEDURE TO [ReportWriter]
GRANT CREATE RULE TO [ReportWriter]
GRANT CREATE TABLE TO [ReportWriter]
GRANT CREATE VIEW TO [ReportWriter]
