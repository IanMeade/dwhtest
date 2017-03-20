SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


 
CREATE VIEW [ETL].[EquityOfficalPrices] AS  
	/* OFFICAL CLOSING / OPENING PRICES */ 
		SELECT 
			D.AggregateDate, 
			D.AggregateDateID, 
			D.ISIN, 
 
			/* OCP */ 
			OCP = COALESCE( OCP.A_OFFICIAL_CLOSING_PRICE, LastOCP.OCP, NULL ), 
 
			/* NO LOCAL TIME CONVERSION */ 
			OCP_DATEID = COALESCE( CAST(CONVERT(CHAR,OCP.A_TRADE_TIME_OCP_GMT,112) AS INT), LastOCP.OCPDateID, NULL ), 
			OCP_TIME = COALESCE( CONVERT(TIME,OCP.A_TRADE_TIME_OCP_GMT,112), LastOCP.OCPTime, NULL), 
			OCP_TIME_UTC = COALESCE( CONVERT(TIME,OCP.A_TRADE_TIME_OCP,112), LastOCP.UtcOCPTime, NULL), 
			OCP_TIME_ID = COALESCE( CAST(REPLACE(LEFT(CONVERT(CHAR,OCP.A_TRADE_TIME_OCP_GMT,114),5),':','') AS INT), LastOCP.OCPTimeID, NULL ), 
 
			/* OOP */ 
			OOP = COALESCE( OOP.A_OFFICIAL_OPENING_PRICE, LastOCP.OCP, NULL ) 
 
		FROM 
				ETL.ActiveInstrumentsDates D 
			LEFT OUTER JOIN 
			/* OCP FOR TODAYS */ 
				ETL.OCP OCP 
			ON  
				D.AggregateDate = OCP.AggregateDate 
			AND  
				D.ISIN = OCP.A_ISIN 
			OUTER APPLY 
			/* MOST RECENT OCP RECORDED IN SNAPSHOT */ 
			( 
				SELECT 
					TOP 1 
					F.OCP, 
					F.DateID, 
					F.OCPDateID, 
					F.OCPTimeID, 
					F.OCPTime, 
					F.UtcOCPTime 
				FROM 
						DWH.FactEquitySnapshot AS F 
					INNER JOIN 
						DWH.DimInstrument I
					ON F.InstrumentID = I.InstrumentID 
				WHERE 
					D.AggregateDateID > F.DateID 
				AND 
					D.ISIN = I.ISIN 
				ORDER BY 
					F.DateID DESC 
			) AS LastOCP 
			LEFT OUTER JOIN 
				ETL.OOP OOP 
			ON  
				D.AggregateDate = OOP.AggregateDate 
			AND  
				D.ISIN = OOP.A_ISIN 
 


GO