SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 7/7/2017
-- Description:	Equity volume using function
-- =============================================
CREATE FUNCTION [ETL].[EquityVolume]
(	
	@D AS INT
)
RETURNS TABLE 
AS
RETURN 
(
	WITH Trades AS (
			SELECT
				/* Trades fro day */ 
				TradeVolume,
				TradeTurnover,
				InstrumentID,
				EquityTradeJunkID,
				CurrencyID,
				DelayedTradeYN
			FROM
				DWH.FactEquityTrade T    
			WHERE
				TradeDateID = @D
			AND
				DelayedTradeYN = 'N'
			AND
				TradeCancelled = 'N'
			UNION ALL
			SELECT
				/* Delayed trades for required day*/
				TradeVolume,
				TradeTurnover,
				InstrumentID,
				EquityTradeJunkID,
				CurrencyID,
				DelayedTradeYN
			FROM
				DWH.FactEquityTrade T    
			WHERE
				PublishDateID = @D
			AND
				PublishedDateTime < GETDATE()
			AND
				DelayedTradeYN = 'Y'
			AND
				TradeCancelled = 'N'
		)
		SELECT
			I.InstrumentGlobalID,  
			/* DEALS */    
			COUNT(*) AS Deals,    
			SUM( IIF( JK.TradeTypeCategory = 'OB',1,0) ) AS DealsOB,    
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,1) ) AS DealsND,    
			/* TRADE VOLUME */    
			SUM(TradeVolume) AS TradeVolume,    
			SUM( IIF( JK.TradeTypeCategory = 'OB',TradeVolume,0) ) AS TradeVolumeOB,    
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,TradeVolume) ) AS TradeVolumeND,    
			/* TURNOVER */    
			SUM(TradeTurnover) AS Turnover,    
			SUM( IIF( JK.TradeTypeCategory = 'OB',TradeTurnover,0) ) AS TurnoverOB,    
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,TradeTurnover) ) AS TurnoverND,    
			/* TURN OVER - EUR */    
			SUM( TradeTurnover / ExRate.ExchangeRate ) AS TurnoverEur,    
			SUM( IIF( JK.TradeTypeCategory = 'OB',TradeTurnover / ExRate.ExchangeRate ,0) ) AS TurnoverObEur,    
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,TradeTurnover / ExRate.ExchangeRate ) ) AS TurnoverNdEur,    
			MIN(ExRate.ExchangeRate ) EXR    
		FROM
				Trades T
			INNER JOIN  
				DWH.DimInstrumentEquity I  
			ON T.InstrumentID = I.InstrumentID
			INNER JOIN    
				DWH.DimEquityTradeJunk JK    
			ON T.EquityTradeJunkID = JK.EquityTradeJunkID   
			CROSS APPLY     
			(    
				SELECT    
					TOP 1    
					ExchangeRate    
				FROM    
					DWH.FactExchangeRate EX    
				WHERE    
					EX.DateID <= @D
				AND    
					T.CurrencyID = EX.CurrencyID    
				ORDER BY    
					EX.DateID DESC    
			) AS ExRate 		
		GROUP BY    
			I.InstrumentGlobalID
)
GO
