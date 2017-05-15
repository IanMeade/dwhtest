SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 21/3/2017
-- Description:	Apply market aggregations
-- =============================================
CREATE PROCEDURE [DWH].[ApplyFactMarketAggrgation]
	@DateID INT,
	@BatchID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		MA.MarketAggregationID,
		F.DateID,
		SUM(F.TurnoverEur) AS TurnoverEur,
		SUM(F.Volume) AS Volume,
		SUM(IIF(ConditionalTradingYN = 'Y', F.TurnoverEur, 0)) AS TurnoverEurConditional,
		SUM(IIF(ConditionalTradingYN = 'Y', F.Volume, 0)) AS VolumeConditional
	INTO
		#Aggregations
	FROM
			DWH.DimInstrumentEquity I
		INNER JOIN
			DWH.FactEquitySnapshot F
		ON I.InstrumentID = F.InstrumentID
		INNER JOIN
			DWH.DimStatus S
		ON F.InstrumentStatusID = S.StatusID
		INNER JOIN
			DWH.DimMarket MK
		ON I.MarketID = MK.MarketID
		INNER JOIN
			DWH.DimMarketAggregation MA
		ON MK.MarketCode = MA.MarketCode 
	WHERE
		F.DateID = @DateID
	GROUP BY
		MA.MarketAggregationID,
		F.DateID
	UNION ALL
	SELECT
		( /* Slightly dangerous query pattern - ccan lead to performance issues if abused */
			SELECT 
				MAX(MarketAggregationID) 
			FROM 
				DWH.DimMarketAggregation
			WHERE
				MarketCode = 'ETF'
		) AS MarketID,
		F.DateID,
		SUM(F.TurnoverEur) AS TurnoverEur,
		SUM(F.Volume) AS Volume,
		SUM(IIF(ConditionalTradingYN = 'Y', F.TurnoverEur, 0)) AS TurnoverEurConditional,
		SUM(IIF(ConditionalTradingYN = 'Y', F.Volume, 0)) AS VolumeConditional
	FROM
			DWH.DimInstrumentEtf I
		INNER JOIN
			DWH.FactEtfSnapshot F
		ON I.InstrumentID = F.InstrumentID
		INNER JOIN
			DWH.DimStatus S
		ON F.InstrumentStatusID = S.StatusID
	WHERE
		F.DateID = @DateID
	GROUP BY
		F.DateID


	UPDATE
		#Aggregations
	SET
		TurnoverEur = ISNULL(TurnoverEur,0),
		Volume = ISNULL(Volume,0),
		TurnoverEurConditional = ISNULL(TurnoverEurConditional,0),
		VolumeConditional = ISNULL(VolumeConditional,0)


	DELETE
		#Aggregations
	WHERE
		TurnoverEur = 0 
	AND
		Volume = 0
	AND
		TurnoverEurConditional = 0
	AND
		VolumeConditional = 0


	/* UPDATE EXISTING */
	
	UPDATE	
		F
	SET
		TurnoverEur = T.TurnoverEur, 
		Volume = T.Volume, 
		TurnoverEurConditional = T.TurnoverEurConditional, 
		VolumeConditional = T.VolumeConditional,
		BatchID = @BatchID
	FROM
			DWH.FactMarketAggregation F
		INNER JOIN
			#Aggregations T
		ON 
			F.MarketAggregationID = T.MarketAggregationID
		AND
			F.DateID = T.DateID


	/* INSERT */

	INSERT INTO
			DWH.FactMarketAggregation
		(
			DateID, 
			MarketAggregationID, 
			TurnoverEur, 
			Volume, 
			TurnoverEurConditional, 
			VolumeConditional,
			BatchID
		)
		SELECT
			DateID, 
			MarketAggregationID, 
			TurnoverEur, 
			Volume, 
			TurnoverEurConditional, 
			VolumeConditional,
			@BatchID
		FROM
			#Aggregations T
		WHERE
			NOT EXISTS (
				SELECT
					*
				FROM				
					DWH.FactMarketAggregation F
				WHERE
					F.MarketAggregationID = T.MarketAggregationID
				AND
					F.DateID = T.DateID
				)
				

END


GO
