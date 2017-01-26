SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 16/1/2017
-- Description:	End an ETL batch
-- =============================================
CREATE PROCEDURE [DWH].[EndBatch]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/* Close the current batch / highest number */
	/* Do not chnage the error status */
	UPDATE
		DWH.DimBatch
	SET
		EndTime = GETDATE()
	WHERE
		BatchID = (
				SELECT 
					MAX(BatchID) 
				FROM 
					DWH.DimBatch
			)



END
GO
