SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 14/2/2017
-- Description:	Add aggregation rebuilds requests for canceled trades
-- =============================================
CREATE PROCEDURE [dbo].[AddAggregationRebuildSystemList]
	@BatchID INT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO 
		dbo.AggregationRebuildSystemList
		(
			AggregationDateID, 
			ProcessedAttempted, 
			AggregationLogged, 
			InsertedBatchID
		)
		SELECT
			TradeDateID AS AggregationDateID, 
			'N' AS ProcessedAttempted, 
			GETDATE() AS AggregationLogged, 
			@BatchID AS InsertedBatchID
		FROM
			dbo.CanceledTradeManualList
		WHERE
			BatchID = @BatchID
		UNION
		SELECT
			TradeDateID AS AggregationDateID, 
			'N' AS ProcessedAttempted, 
			GETDATE() AS AggregationLogged, 
			@BatchID AS InsertedBatchID
		FROM
			dbo.CanceledTradeReviewList
		WHERE
			BatchID = @BatchID
END
GO
