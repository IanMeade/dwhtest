SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [ETL].[ActiveInstrumentsDates] AS
		/* NEEDS TO BE REWORKED WHEN XT DATA IS AVAILABLE */
		SELECT
			DL.AggregateDate,
			DL.AggregateDateID,
			I.InstrumentID,
			I.ISIN,
			I.InstrumentType,
			/* MIGHT BE BETTER TO USE THE INSTRUMENT TYPE */
			IIF( EQUITY.InstrumentID IS NOT NULL, 'EQUITY', 'ETF' ) AS SourceTable,
			ISNULL(EQUITY.CurrencyID, ETF.CurrencyID ) AS CurrencyID
		FROM
				DWH.DimInstrument I
			INNER JOIN
				DWH.DimStatus S
			ON I.InstrumentStatusID = S.StatusID
			LEFT OUTER JOIN
				DWH.DimInstrumentEquity EQUITY
			ON I.InstrumentID = EQUITY.InstrumentID
			LEFT OUTER JOIN
				DWH.DimInstrumentEtf ETF
			ON I.InstrumentID = ETF.InstrumentID
			CROSS JOIN
				ETL.AggregationDateList DL
		WHERE
				I.CurrentRowYN = 'Y'
			AND
				S.StatusName = 'LISTED'
						

GO
