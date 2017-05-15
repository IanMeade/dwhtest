SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [ETL].[EtfVolume] AS  
		SELECT  
			D.AggregateDateID,   
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
			SUM( TradeTurnover * ExRate.ExchangeRate ) AS TurnoverEur,  
			SUM( IIF( JK.TradeTypeCategory = 'OB',TradeTurnover / ExRate.ExchangeRate ,0) ) AS TurnoverObEur,  
			SUM( IIF( JK.TradeTypeCategory = 'OB',0,TradeTurnover / ExRate.ExchangeRate ) ) AS TurnoverNdEur,  
			MIN(ExRate.ExchangeRate ) EXR  
  
		FROM  
				ETL.AggregationDateList D
			INNER JOIN  
				DWH.FactEtfTrade T  
			ON D.AggregateDateID = T.TradeDateID  
			INNER JOIN
				DWH.DimInstrumentEtf I
			ON T.InstrumentID = I.InstrumentID
			INNER JOIN  
				DWH.DimEquityTradeJunk JK  
			ON T.EquityTradeJunkID = JK.EquityTradeJunkID 
			INNER JOIN  
				DWH.DimTradeModificationType MT  
			ON T.TradeModificationTypeID = MT.TradeModificationTypeID  
			AND MT.CancelTradeYN = 'N'
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
					T.CurrencyID = EX.CurrencyID  
				ORDER BY  
					EX.DateID DESC  
			) AS ExRate  
		WHERE  
				T.DelayedTradeYN = 'N'  
			OR  
				(  
						T.DelayedTradeYN = 'Y'  
					AND  
						T.PublishedDateTime < GETDATE()  
				)  
		GROUP BY  
			D.AggregateDateID,
			I.InstrumentGlobalID

GO
