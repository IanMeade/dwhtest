SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


 
CREATE VIEW [ETL].[EquityMarketCap] AS  
		SELECT  
			D.AggregateDateID,   
			E.InstrumentID,   
			E.TotalSharesInIssue, 
			ExRate.ExchangeRate  
		FROM
				DWH.DimInstrumentEquity E 
			CROSS JOIN			  
				ETL.AggregationDateList D
			CROSS APPLY   
			(  
				SELECT  
					TOP 1  
					ExchangeRate  
				FROM  
					DWH.FactExchangeRate EX  
				WHERE  
					D.AggregateDateID >= EX.DateID   
				AND  
					E.CurrencyID = EX.CurrencyID  
				ORDER BY  
					EX.DateID DESC  
			) AS ExRate  
  
  
 


GO
