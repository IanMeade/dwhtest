SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ETL].[EtfMarketCap] AS 
		SELECT 
			AID.AggregateDate,  
			AID.AggregateDateID,  
			AID.InstrumentID,  
			AID.ISIN,  
			AID.CurrencyID,
			E.TotalSharesInIssue,
			ExRate.ExchangeRate 
		FROM 
				ETL.ActiveInstrumentsDates AID 			
			INNER JOIN 
				dwh.DimInstrumentEtf E
			ON AID.InstrumentID = E.InstrumentID
			CROSS APPLY  
			( 
				SELECT 
					TOP 1 
					ExchangeRate 
				FROM 
					DWH.FactExchangeRate EX 
				WHERE 
					AID.AggregateDateID >= EX.DateID  
				AND 
					AID.CurrencyID = EX.CurrencyID 
				ORDER BY 
					EX.DateID DESC 
			) AS ExRate 
 
 

GO
