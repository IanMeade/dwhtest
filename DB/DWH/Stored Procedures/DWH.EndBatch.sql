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
	@BatchID INT
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	/* Close the specified batch */ 
	/* Do not change the error status */ 
	UPDATE 
		DWH.DimBatch 
	SET 
		EndTime = GETDATE() 
	WHERE 
		BatchID = @BatchID
 
END 
GO
