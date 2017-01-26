SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 16/1/2017
-- Description:	Start an ETL batch
-- =============================================
CREATE PROCEDURE [DWH].[StartBatch]
	@EtlVersion varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/* Close any existing batch */
	UPDATE
		DWH.DimBatch
	SET
		EndTime = GETDATE(),
		ErrorFreeYN = 'N'
	WHERE
		EndTime IS NULL

	/* Create a new batch */
	INSERT INTO	
			DWH.DimBatch
		(
			ETLVersion
		)
		OUTPUT
			inserted.BatchID
		VALUES
		(
			@EtlVersion
		)

END
GO
