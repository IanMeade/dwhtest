SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 13/2/2017
-- Description:	Get days to aggregate
-- =============================================
CREATE PROCEDURE [dbo].[GetAggregationDateList]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		/* Today */
		CAST(GETDATE() AS DATE) AS AggregateDate,
		CAST(CONVERT(CHAR,GETDATE(),112) AS INT) AggregationDateID
	UNION
	SELECT
		CONVERT(DATE,CAST(AggregationDateID AS CHAR),112) AS AggregationDate,
		AggregationDateID
	FROM	
		dbo.AggregationRebuildManualList
	WHERE
		ProcessedAttempted = 'N'
	UNION
	SELECT
		CONVERT(DATE,CAST(AggregationDateID AS CHAR),112) AS AggregationDate,
		AggregationDateID
	FROM	
		dbo.AggregationRebuildSystemList
	WHERE
		ProcessedAttempted = 'N'
	ORDER BY
		AggregateDate

END
GO
