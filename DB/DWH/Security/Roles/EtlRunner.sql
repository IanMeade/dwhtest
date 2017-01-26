CREATE ROLE [EtlRunner]
AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'EtlRunner', N'ETL_test'
GO
EXEC sp_addrolemember N'EtlRunner', N'STOCK_EXCHANGE\BarryM'
GO
EXEC sp_addrolemember N'EtlRunner', N'STOCK_EXCHANGE\G_DWEtlRunner'
GO
GRANT CREATE DEFAULT TO [EtlRunner]
GRANT CREATE FUNCTION TO [EtlRunner]
GRANT CREATE PROCEDURE TO [EtlRunner]
GRANT CREATE RULE TO [EtlRunner]
GRANT CREATE TABLE TO [EtlRunner]
GRANT CREATE VIEW TO [EtlRunner]
