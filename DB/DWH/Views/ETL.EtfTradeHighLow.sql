SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 
CREATE VIEW [ETL].[EtfTradeHighLow] AS  
		SELECT  
			I.ISIN,  
			T.TradeDateID,  
			COUNT(*) CNT,  
			MIN(T.TradePrice) AS LowPrice,  
			MAX(T.TradePrice) AS HighPrice  
		FROM  
				DWH.FactEtfTrade T  
			INNER JOIN  
				DWH.DimInstrumentEtf I  
			ON T.InstrumentID = I.InstrumentID  
			AND I.CurrentRowYN = 'Y'  
			INNER JOIN  
				DWH.DimTradeModificationType TM  
			ON T.TradeModificationTypeID = TM.TradeModificationTypeID  
		WHERE  
			TM.CancelTradeYN <> 'N'
		GROUP BY  
			I.ISIN,  
			T.TradeDateID  
  
  
 

GO
