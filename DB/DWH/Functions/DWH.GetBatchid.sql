SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 19/1/2017 
-- Description:	Gets current batch  
--				WARNING --- SCALAR FUNCTIONS ARE NOT SUITABLE FOR LARGE NUMBERS OF ROWS - USE ONLY FOR SMALL RESULT SETS 
-- ============================================= 
CREATE FUNCTION [DWH].[GetBatchid] 
( 
) 
RETURNS INT 
AS 
BEGIN 
	-- Declare the return variable here 
	DECLARE @BatchId INT = 0 
 
	SELECT 
		@BatchId = MAX(BatchID)  
	FROM 
		DWH.DimBatch		 
 
	-- Return the result of the function 
	RETURN @BatchId 
 
END 
 
 
GO
