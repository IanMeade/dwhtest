SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ETL].[ActiveInstrumentsDates] AS
	/* 
		FIND BEST INSTUMENT VERSION FOR AGGREGTATION DATES - 
		REMOVE INVALID STATUS / INSTRUMENT TYPES 
	*/
	SELECT
		AGG.AggregateDate,
		AGG.AggregateDateID,
		Y.InstrumentID,
		X.ISIN,
		--	X.StartDate AS InstrumentStartDate,
		--  Y.ISIN, 
		I.InstrumentType, 
		/* MIGHT BE BETTER TO USE THE INSTRUMENT TYPE */ 
		IIF( EQUITY.InstrumentID IS NOT NULL, 'EQUITY', 'ETF' ) AS SourceTable, 
		ISNULL(EQUITY.CurrencyID, ETF.CurrencyID ) AS CurrencyID 
	FROM
			ETL.AggregationDateList AGG
		CROSS APPLY 
		(
			/* MOST RECENT START DATE FOR INSTRUMENTS */
			SELECT
				I.ISIN,
				MAX(StartDate) AS StartDate
			FROM
				DWH.DimInstrument I 
			WHERE
				I.StartDate <= AGG.AggregateDate
			GROUP BY
				I.ISIN
		) AS X
		CROSS APPLY
		(	
			/* HIGHEST InstrumentID FOR INSTRUMENTS */
			SELECT
				I.ISIN,
				MAX(InstrumentID) AS InstrumentID
			FROM
				DWH.DimInstrument I 
			WHERE
				X.ISIN = I.ISIN
			AND
				X.StartDate = I.StartDate
			GROUP BY
				I.ISIN
		) AS Y
		/* REQUIRED INSTRUMENT VERSION */
		INNER JOIN
			DWH.DimInstrument I 
		ON Y.InstrumentID = I.InstrumentID
		INNER JOIN 
			DWH.DimStatus S 
		ON I.InstrumentStatusID = S.StatusID 
		LEFT OUTER JOIN 
			DWH.DimInstrumentEquity EQUITY 
		ON I.InstrumentID = EQUITY.InstrumentID 
		LEFT OUTER JOIN 
			DWH.DimInstrumentEtf ETF 
		ON I.InstrumentID = ETF.InstrumentID 
	WHERE 
			S.StatusName IN ('Listed', 'Conditional Dealings', 'Suspended' )
		AND
			( 
				EQUITY.InstrumentID IS NOT NULL
			OR 
				ETF.InstrumentID IS NOT NULL
			)
GO
