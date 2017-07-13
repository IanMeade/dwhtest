SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
     
CREATE VIEW [ETL].[EtfOfficalPrices] AS     
	/* OFFICAL CLOSING / OPENING PRICES */    
	SELECT
		AG.AggregateDateID,
		I.InstrumentGlobalID,
		I.ISIN,

		/* OCP */    
		OCP = COALESCE( OCP.A_OFFICIAL_CLOSING_PRICE, LastOCP.OCP, NULL ),    
    
		/* NO LOCAL TIME CONVERSION */    
		OCP_DATEID = COALESCE( CAST(CONVERT(CHAR,OCP.A_TRADE_TIME_OCP_LOCAL,112) AS INT), LastOCP.OCPDateID, NULL ),    
		OCP_TIME = COALESCE( CONVERT(TIME,OCP.A_TRADE_TIME_OCP_LOCAL,112), LastOCP.OCPTime, NULL),    
		OCP_TIME_UTC = COALESCE( CONVERT(TIME,OCP.A_TRADE_TIME_OCP,112), LastOCP.UtcOCPTime, NULL),    
		OCP_TIME_ID = COALESCE( CAST(REPLACE(LEFT(CONVERT(CHAR,OCP.A_TRADE_TIME_OCP_LOCAL,114),5),':','') AS INT), LastOCP.OCPTimeID, NULL ),    
		OCP_DATETIME = COALESCE( A_TRADE_TIME_OCP_LOCAL, LastOCP.OCPDateTime ), 
    
		/* OOP */    
		OOP = COALESCE( OOP.A_OFFICIAL_OPENING_PRICE, LastOCP.OCP, NULL )        

	FROM
		ETL.AggregationDateList AG
	CROSS APPLY
		ETL.udfGetAggregationInstruments( AG.AggregateDateID ) AS I
	LEFT OUTER JOIN
		ETL.OCP OCP    
	ON     
		AG.AggregateDate = OCP.AggregateDate    
	AND
		I.ISIN = A_ISIN
	LEFT OUTER JOIN    
		ETL.OOP OOP    
	ON     
		AG.AggregateDate = OOP.AggregateDate    
	AND		  
		I.ISIN = OOP.A_ISIN 
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
			F.UtcOCPTime, 
			F.OCPDateTime  
		FROM    
				DWH.FactEtfSnapshot AS F    
			INNER JOIN    
				DWH.DimInstrument I_2 
			ON F.InstrumentID = I.InstrumentID    
		WHERE    		
			F.DateID < AG.AggregateDateID 
		AND 
			I_2.ISIN = I.ISIN
		AND
			F.OCP IS NOT NULL		
		ORDER BY    
			F.DateID DESC    
	) AS LastOCP 

	WHERE
		SourceTable = 'Etf'
GO
