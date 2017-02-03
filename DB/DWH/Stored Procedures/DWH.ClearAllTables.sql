SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 24/1/2017
-- Description:	Clear the DWH and reset IDs
-- =============================================
CREATE PROCEDURE [DWH].[ClearAllTables]
AS
BEGIN
	SET NOCOUNT ON;

	/* TRUNCATE TABLES */
	TRUNCATE TABLE DWH.FactEquitySnapshot
	TRUNCATE TABLE DWH.FactEquityTrade
	TRUNCATE TABLE DWH.FactEtfTrade
	TRUNCATE TABLE DWH.FactExchangeRate
	TRUNCATE TABLE DWH.FactInstrumentStatusHistory

	/* EMPTY TABLES REFERENCED BY FOREIGN KEYS */
	DELETE DWH.DimIndex
	DELETE DWH.DimMarket
	DELETE DWH.DimBatch
	DELETE DWH.DimBroker
	DELETE DWH.DimCurrency
	DELETE DWH.DimDate
	DELETE DWH.DimEquityTradeJunk
	DELETE DWH.DimFile
	DELETE DWH.DimInstrument
	/* DELETE DWH.DimInstrumentDummy - don't clear this one - this will be droped later in project */
	DELETE DWH.DimInstrumentEquity
	DELETE DWH.DimStatus
	DELETE DWH.DimTime
	DELETE DWH.DimTradeModificationType
	DELETE DWH.DimTrader

	/* RESET IDENTITIES FOR DELETED TABLES */
	DBCC CHECKIDENT ('DWH.DimIndex',RESEED,1);  
	DBCC CHECKIDENT ('DWH.DimMarket',RESEED,1); 
	DBCC CHECKIDENT ('DWH.DimBatch',RESEED,1);  
	DBCC CHECKIDENT ('DWH.DimBroker',RESEED,1);  
	DBCC CHECKIDENT ('DWH.DimCurrency',RESEED,1);  
	DBCC CHECKIDENT ('DWH.DimEquityTradeJunk',RESEED,1);  
	DBCC CHECKIDENT ('DWH.DimFile',RESEED,1);  

	DBCC CHECKIDENT ('DWH.DimFile',RESEED,1);  
	DBCC CHECKIDENT ('DWH.DimInstrument',RESEED,1);  
	DBCC CHECKIDENT ('DWH.DimInstrumentDummy',RESEED,1);  
	DBCC CHECKIDENT ('DWH.DimStatus',RESEED,1);  
	DBCC CHECKIDENT ('DWH.DimTradeModificationType',RESEED,1);  
	DBCC CHECKIDENT ('DWH.DimTrader',RESEED,1);  

END
GO
