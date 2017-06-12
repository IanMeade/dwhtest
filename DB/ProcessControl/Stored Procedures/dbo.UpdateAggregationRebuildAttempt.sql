SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 26/5/2017
-- Description:	Update aggregation attempts
-- =============================================
CREATE PROCEDURE [dbo].[UpdateAggregationRebuildAttempt]
	@DateID INT,
	@BatchID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE
		dbo.AggregationRebuildSystemList
	SET
		ProcessedAttempted = 'Y',
		ProcessedSucceeded = 'Y',
		AggregationProcessed = GETDATE(),
		ProcessedBatchID = @BatchID
	WHERE
		ProcessedAttempted = 'N'
	AND
		AggregationDateID = @DateID

	UPDATE
		dbo.AggregationRebuildManualList
	SET
		ProcessedAttempted = 'Y',
		ProcessedSucceeded = 'Y',
		AggregationProcessed = GETDATE(),
		ProcessedBatchID = @BatchID
	WHERE
		ProcessedAttempted = 'N'
	AND
		AggregationDateID = @DateID


END
GO
