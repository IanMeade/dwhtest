SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
   
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 17/1/2017   
-- Description:	Checks if the passed in TaskControlTag can be run now   
--				WARNING --- SCALAR FUNCTIONS ARE NOT SUITABLE FOR LARGE NUMBERS OF ROWS - USE ONLY FOPR SMALL RESULT SETS   
-- =============================================   
CREATE FUNCTION [dbo].[CheckTaskControl]    
(   
	@TaskControlTag VARCHAR(100), 
	@BatchID INT 
)   
RETURNS BIT   
AS   
BEGIN   
	-- Declare the return variable here   
	DECLARE @YesWeCan BIT = 0   
   
	SELECT   
		@YesWeCan = 1 
	FROM   
		[dbo].[TaskControl]   
	WHERE   
		TaskControlTag = @TaskControlTag   
	AND   
		TaskControlEnabledYN = 'Y'   
	AND 
		dbo.CheckScheduleTag(TaskControlRuleSchedule, TaskControlTag ) = 1 
	AND 
		dbo.CheckPrecedence(TaskControlTag, @BatchID ) = 1 
   
	-- Return the result of the function   
	RETURN @YesWeCan   
   
END   
   
GO
