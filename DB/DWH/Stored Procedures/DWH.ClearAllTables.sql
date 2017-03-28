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
	TRUNCATE TABLE DWH.FactEtfSnapshot  
	TRUNCATE TABLE DWH.FactEtfTrade  
	TRUNCATE TABLE DWH.FactExchangeRate  
	TRUNCATE TABLE DWH.FactInstrumentStatusHistory  
	TRUNCATE TABLE DWH.FactMarketAggregation

	/* EMPTY TABLES REFERENCED BY FOREIGN KEYS */  
	DELETE DWH.DimInstrumentEquity  
	DELETE DWH.DimInstrumentEtf 
	DELETE DWH.DimInstrument 
	DELETE DWH.DimIndex  
	DELETE DWH.DimMarket  
	DELETE DWH.DimMarketAggregation
	DELETE DWH.DimBatch  
	DELETE DWH.DimBroker  
	DELETE DWH.DimCurrency  
	DELETE DWH.DimDate  
	DELETE DWH.DimEquityTradeJunk  
	DELETE DWH.DimFile  
	DELETE DWH.DimStatus  
	DELETE DWH.DimTime  
	DELETE DWH.DimTradeModificationType  
	DELETE DWH.DimTrader  
  
	/* RESET IDENTITIES FOR DELETED TABLES */  
	DBCC CHECKIDENT ('DWH.DimIndex',RESEED,0);    
	DBCC CHECKIDENT ('DWH.DimMarket',RESEED,0);   
	DBCC CHECKIDENT ('DWH.DimBatch',RESEED,0);    
	DBCC CHECKIDENT ('DWH.DimBroker',RESEED,0);    
	DBCC CHECKIDENT ('DWH.DimCurrency',RESEED,0);    
	DBCC CHECKIDENT ('DWH.DimEquityTradeJunk',RESEED,0);   
	DBCC CHECKIDENT ('DWH.DimFile',RESEED,0);    
  
	DBCC CHECKIDENT ('DWH.DimFile',RESEED,0);    
	DBCC CHECKIDENT ('DWH.DimInstrument',RESEED,0);  
	DBCC CHECKIDENT ('DWH.DimStatus',RESEED,0);    
	DBCC CHECKIDENT ('DWH.DimTradeModificationType',RESEED,0);    
	DBCC CHECKIDENT ('DWH.DimTrader',RESEED,0);    
	DBCC CHECKIDENT ('DWH.DimMarketAggregation',RESEED,0);    
  
  
	/* SPECIAL DUMMY ENTRIES */  
	SET IDENTITY_INSERT DWH.DimBatch ON  
  
	/* GENERIC NOT A BATCH - EG A NORMAL TRADE HAS A -1 FOR THE CANCELED BATCH - A CANCELED TRADE HAS A REAL BATCH */  
	INSERT INTO  
			DWH.DimBatch   
		(  
			BatchID,   
			StartTime,   
			EndTime,   
			ErrorFreeYN,   
			ETLVersion  
		)  
		VALUES  
		(  
			-1,  
			'19991231',  
			'20000101',  
			'Y',  
			'NA'  
		)  
  
	/* SPECIAL BATCH FOR DSS MIGRATION */  
	INSERT INTO  
			DWH.DimBatch   
		(  
			BatchID,   
			StartTime,   
			EndTime,   
			ErrorFreeYN,   
			ETLVersion  
		)  
		VALUES  
		(  
			-2,  
			'19991231',  
			'20000101',  
			'Y',  
			'DSS Migration - T7'  
		)  
  
	SET IDENTITY_INSERT DWH.DimBatch OFF  
  
	/* NOT A DATE - EG NO PUBLICATION DATE */  
	INSERT INTO  
			DWH.DimDate   
		(  
			DateID,   
			DateText,   
			Day,   
			WorkingDayYN,   
			Year,   
			MonthNo,   
			MonthName,   
			QuarterNo,   
			QuarterText,   
			YearQuarterNo,   
			YearQuarterText,   
			MonthDayNo,   
			DayText,   
			MonthToDateYN,   
			YearToDateYN,   
			TradingStartTime,   
			TradingEndTime  
		)  
		VALUES  
		(  
			-1,  
			'NA',  
			'19991231',  
			'N',  
			1999,  
			0,  
			'NA',  
			0,  
			'NA',  
			0,  
			'NA',  
			0,  
			'NA',  
			'N',  
			'N',  
			'00:00',  
			'00:00'  
		)  
  
	/* Need to add using dimension manager */ 
	/* 
	/* DUMMY CURRENCIES */  
	INSERT INTO  
			DWH.FactExchangeRate  
		(  
			DateID, CurrencyID, ExchangeRate, BatchID  
		)  
		VALUES   
		( -1,	1,	1,	-1 ),  
		( -1,	2,	1,	-1 ),  
		( -1,	3,	1,	-1 ),  
		( -1,	4,	1,	-1 ),  
		( -1,	5,	1,	-1 ),  
		( -1,	6,	1,	-1 ),  
		( -1,	7,	1,	-1 ),  
		( -1,	8,	1,	-1 ),  
		( -1,	9,	1,	-1 ),  
		( -1,	10,	1,	-1 ),  
		( -1,	11,	1,	-1 )  
	*/ 
 
	/* EXTRA TABLES - THESE ARE NOT PART OF THE DWH MODEL */  
	TRUNCATE TABLE ETL.AggregationDateList  
	TRUNCATE TABLE ETL.BidOfferPrice  
	TRUNCATE TABLE ETL.ClosingPrice  
	TRUNCATE TABLE ETL.EquityTradeSnapshot  
	TRUNCATE TABLE ETL.OCP  
	TRUNCATE TABLE ETL.OOP  
	TRUNCATE TABLE Report.RefEquityFeeBand  
	TRUNCATE TABLE ETL.EquityTradeDate 
	TRUNCATE TABLE ETL.FactEquitySnapshotMerge 
	TRUNCATE TABLE ETL.FactEtfSnapshotMerge 
 
END  
GO
