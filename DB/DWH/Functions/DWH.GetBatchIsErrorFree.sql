SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 06/3/2017 
-- Description:	Gets error status of current batch  
--				WARNING --- SCALAR FUNCTIONS ARE NOT SUITABLE FOR LARGE NUMBERS OF ROWS - USE ONLY FOR SMALL RESULT SETS 
-- ============================================= 
CREATE FUNCTION [DWH].[GetBatchIsErrorFree] 
( 
) 
RETURNS CHAR(1) 
AS 
BEGIN 
	-- Declare the return variable here 
	DECLARE @ErrorFreeYN CHAR(1)
 

	SELECT
		@ErrorFreeYN = ErrorFreeYN
	FROM
		DWH.DimBatch
	WHERE
		BatchID = DWH.GetBatchid()

	-- Return the result of the function 
	RETURN @ErrorFreeYN 
 
END 
 
 

GO
