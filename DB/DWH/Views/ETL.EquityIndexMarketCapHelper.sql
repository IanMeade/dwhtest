SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


  
  
CREATE VIEW [ETL].[EquityIndexMarketCapHelper] AS  
	/* Get the market caps */
	SELECT
		DateID,
		'IEEP' AS IndexCode,
		SUM(ISEQ20MarketCap) AS MarketCap
	FROM
		DWH.FactEquitySnapshot
	WHERE
		ISEQ20IndexYN = 'Y'
	GROUP BY
		DateID
	UNION ALL
	SELECT
		DateID,
		'IEOA' AS IndexCode,
		SUM(ISEQOverallMarketCap) AS MarketCap
	FROM
		DWH.FactEquitySnapshot
	WHERE
		EsmIndexYN = 'Y'
	GROUP BY
		DateID
	UNION ALL
	SELECT
		DateID,
		'IEOC' AS IndexCode,
		SUM(ISEQ20MarketCap) AS MarketCap
	FROM
		DWH.FactEquitySnapshot
	WHERE
		ISEQ20IndexYN = 'Y'
	GROUP BY
		DateID
	UNION ALL
	SELECT
		DateID,
		'IEOE' AS IndexCode,
		SUM(ISEQ20CappedMarketCap) AS MarketCap
	FROM
		DWH.FactEquitySnapshot
	WHERE
		ISEQ20IndexYN = 'Y'
	GROUP BY
		DateID
	UNION ALL
	SELECT
		DateID,
		'IEOP' AS IndexCode,
		SUM(ISEQOverallMarketCap) AS MarketCap
	FROM
		DWH.FactEquitySnapshot
	WHERE
		OverallIndexYN = 'Y'
	GROUP BY
		DateID
	UNION ALL	
	SELECT
		DateID,
		'IEQP' AS IndexCode,
		SUM(ISEQOverallMarketCap) AS MarketCap
	FROM
		DWH.FactEquitySnapshot
	WHERE
		GeneralIndexYN = 'Y'
	GROUP BY
		DateID
	UNION ALL
	SELECT
		DateID,
		'IEUP' AS IndexCode,
		SUM(ISEQOverallMarketCap) AS MarketCap
	FROM
		DWH.FactEquitySnapshot
	WHERE
		FinancialIndexYN = 'Y'
	GROUP BY
		DateID
	UNION ALL
	SELECT
		DateID,
		'IEYP' AS IndexCode,
		SUM(ISEQOverallMarketCap) AS MarketCap
	FROM
		DWH.FactEquitySnapshot
	WHERE
		SmallCapIndexYN	= 'Y'
	GROUP BY
		DateID


  


GO
