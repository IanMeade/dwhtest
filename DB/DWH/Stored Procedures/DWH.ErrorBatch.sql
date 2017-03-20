SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 06/3/2017 
-- Description:	Mark a batch as an error batch
-- ============================================= 
CREATE PROCEDURE [DWH].[ErrorBatch] 
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
		ErrorFreeYN = 'N'
	WHERE 
		BatchID = ( 
				SELECT  
					MAX(BatchID)  
				FROM  
					DWH.DimBatch 
			) 
 
 
 
END 
GO
