SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ETL].[EquityIndexMarketCapHelper] AS
	WITH ISEQ20_Common  AS (
				SELECT
					DateID,
					SUM(ISEQOverallMarketCap) AS MarketCap
				FROM
						DWH.FactEquitySnapshot F
					INNER JOIN
						ETL.AggregationDateList A
					ON F.DateID = A.AggregateDateID
				WHERE
					ISEQ20IndexYN = 'Y'
				GROUP BY
					DateID
			)
		SELECT
			DateID,
			'IEOP' AS IndexCode,
			SUM(ISEQOverallMarketCap) AS MarketCap
		FROM
				DWH.FactEquitySnapshot F
			INNER JOIN
				ETL.ActiveInstrumentsDates A
			ON F.DateID = A.AggregateDateID
		WHERE
			OverallIndexYN = 'Y'
		GROUP BY
			DateID

		UNION ALL
		SELECT
			DateID,
			'IEUP' AS IndexCode,
			SUM(ISEQOverallMarketCap) AS MarketCap
		FROM
				DWH.FactEquitySnapshot F
			INNER JOIN
				ETL.ActiveInstrumentsDates A
			ON F.DateID = A.AggregateDateID
		WHERE
			FinancialIndexYN = 'Y'
		GROUP BY
			DateID
		UNION ALL
		SELECT
			DateID,
			'IEQP' AS IndexCode,
			SUM(ISEQOverallMarketCap) AS MarketCap
		FROM
				DWH.FactEquitySnapshot F
			INNER JOIN
				ETL.ActiveInstrumentsDates A
			ON F.DateID = A.AggregateDateID
		WHERE
			GeneralIndexYN = 'Y'
		GROUP BY
			DateID
		UNION ALL
		SELECT
			DateID,
			'IEYP' AS IndexCode,
			SUM(ISEQOverallMarketCap) AS MarketCap
		FROM
				DWH.FactEquitySnapshot F
			INNER JOIN
				ETL.ActiveInstrumentsDates A
			ON F.DateID = A.AggregateDateID
		WHERE
			SmallCapIndexYN = 'Y'
		GROUP BY
			DateID
		UNION ALL

		SELECT
			DateID,
			'IEOA' AS IndexCode,
			SUM(ISEQOverallMarketCap) AS MarketCap
		FROM
				DWH.FactEquitySnapshot F
			INNER JOIN
				ETL.ActiveInstrumentsDates A
			ON F.DateID = A.AggregateDateID
		WHERE
			ESMIndexYN = 'Y'
		GROUP BY
			DateID
		UNION ALL
		SELECT
			DateID,
			'IEEP' AS IndexCode,
			MarketCap
		FROM
			ISEQ20_Common  
		UNION ALL
		SELECT
			DateID,
			'IEOD' AS IndexCode,
			MarketCap
		FROM
			ISEQ20_Common  
		UNION ALL
		SELECT
			DateID,
			'IEOC' AS IndexCode,
			MarketCap
		FROM
			ISEQ20_Common  
		UNION ALL
		SELECT
			DateID,
			'IEOE' AS IndexCode,
			MarketCap
		FROM
			ISEQ20_Common  
	

GO
