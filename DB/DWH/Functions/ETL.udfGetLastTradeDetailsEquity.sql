SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

  
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 22/5/2017  
-- Description:	Get Last Trade Prices - equity   
-- =============================================  
CREATE FUNCTION [ETL].[udfGetLastTradeDetailsEquity]  
(	  
	@DateID INT  
)  
RETURNS TABLE   
AS  
RETURN   
(  
	WITH  
		ValidTrades AS (  
			SELECT  
				I.InstrumentGlobalID,  
				T.EquityTradeID,  
				T.TradeDateID,  
				T.TradeTimeID,  
				T.TradeTimestamp,  
				T.UTCTradeTimeStamp,  
				T.TradePrice  
			FROM  
					DWH.FactEquityTrade T  
				INNER JOIN	  
					DWH.DimInstrument I  
				ON T.InstrumentID = I.InstrumentID  
			WHERE  
					T.TradeCancelled = 'N'  
				AND  
				(  
					/* Trade is not delayed */  
					DelayedTradeYN = 'N'  
				OR  
					(  
						DelayedTradeYN = 'Y'  
					AND  
						/* Trade is delayed by less tehan one day - ie published on same day as trade */	  
						T.PublishDateID = T.TradeDateID  
					AND	
						T.PublishedDateTime <= GETDATE()
					)  
				)  
				AND  
					TradeDateID <= @DateID  
		),  
		LastTradeDate AS (  
			SELECT			  
				InstrumentGlobalID,  
				MAX(TradeDateID) AS TradeDateID  
			FROM  
				ValidTrades  
			GROUP BY  
				InstrumentGlobalID  
		),  
		LastTradeTime AS (  
			SELECT  
				T.InstrumentGlobalID,  
				T.TradeDateID,  
				MAX(TradeTimestamp) AS TradeTimestamp
			FROM  
				LastTradeDate L  
			INNER JOIN  
				ValidTrades T  
			ON L.InstrumentGlobalID = T.InstrumentGlobalID  
			AND L.TradeDateID = T.TradeDateID  
			GROUP BY  
				T.InstrumentGlobalID,  
				T.TradeDateID  
		)  
		SELECT  
			@DateID AS AggregationDateID,  
			T.InstrumentGlobalID,  
			T.TradeDateID,  
			T.TradeTimeID,  
			T.TradeTimestamp,  
			T.UTCTradeTimeStamp,  
			MAX(T.TradePrice) AS TradePrice    
		FROM  
				LastTradeTime LT  
			INNER JOIN  
				ValidTrades T  
			ON LT.InstrumentGlobalID = T.InstrumentGlobalID
			AND LT.TradeDateID = T.TradeDateID
			AND LT.TradeTimestamp = T.TradeTimestamp
		GROUP BY
			T.InstrumentGlobalID,  
			T.TradeDateID,  
			T.TradeTimeID,  
			T.TradeTimestamp,  
			T.UTCTradeTimeStamp
			
)  
  

GO
