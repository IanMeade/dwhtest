SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
   
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 1/6/2017   
-- Description:	Checks if the passed in TaskControlTag prcedance has been meet 
--				WARNING --- SCALAR FUNCTIONS ARE NOT SUITABLE FOR LARGE NUMBERS OF ROWS - USE ONLY FOPR SMALL RESULT SETS   
-- =============================================   
CREATE FUNCTION [dbo].[CheckPrecedence]    
(   
	@TaskControlTag VARCHAR(100), 
	@BatchID INT 
)   
RETURNS BIT   
AS   
BEGIN   
	-- Declare the return variable here   
	DECLARE @YesWeCan BIT = 1 
   
	SELECT 
		@YesWeCan = 0 
	WHERE 
			EXISTS ( 
					SELECT 
						* 
					FROM 
						dbo.TaskControl 
					WHERE 
						TaskControlTag = @TaskControlTag 
					AND 
						DependencyCheck = 'NEVER' 
				) 
		OR  
			EXISTS ( 
					/* LOOK FOR IDENTIFIED FILE TAG */ 
					SELECT 
						* 
					FROM 
						dbo.TaskControl TC 
					WHERE 
						TaskControlTag = @TaskControlTag 
					AND 
						DependencyCheck LIKE 'FILE_FOUND_%' 
					AND 
						NOT EXISTS ( SELECT * FROM dbo.ProcessMessage WHERE BatchID = @BatchID AND Message = TC.DependencyCheck ) 
				) 
		OR  
			EXISTS ( 
					/* LOOK FOR ANY FILE FOR SPECIFIED ODS */ 
					SELECT 
						* 
					FROM 
						dbo.TaskControl TC 
					WHERE 
						TaskControlTag = @TaskControlTag 
					AND 
						DependencyCheck LIKE 'ODS_FILE_LOAD_%' 
					AND 
						NOT EXISTS (  
									SELECT  
										*  
									FROM  
											dbo.ProcessMessage M 
										INNER JOIN 
											dbo.FileControl FC 
										ON M.Message = 'FILE_FOUND_' + FC.FileTag 
										AND CHARINDEX(FC.ODS,TC.DependencyCheck) <> 0 
									WHERE  
										BatchID = @BatchID  
								) 
				) 
		OR  
			EXISTS ( 
					SELECT 
						* 
					FROM 
						dbo.TaskControl TC 
					WHERE 
						TaskControlTag = @TaskControlTag 
					AND 
						DependencyCheck = 'FOUND_SETS' 
					AND 
						NOT EXISTS ( SELECT * FROM dbo.ProcessMessage WHERE BatchID = @BatchID AND Message = 'FOUND_SETS' ) 
				)				 
		OR 
			EXISTS ( 
					SELECT 
						* 
					FROM 
						dbo.TaskControl 
					WHERE 
						TaskControlTag = @TaskControlTag 
					AND 
						DependencyCheck = 'T7_AGGREGATION_CHECK' 
					AND 
						NOT EXISTS ( SELECT * FROM dbo.ProcessMessage WHERE BatchID = @BatchID AND Message IN ( 'FILE_FOUND_TxSaft', 'FILE_FOUND_PriceFile' ) ) 
				) 
		   
	-- Return the result of the function   
	RETURN @YesWeCan   
   
END   
   
GO
