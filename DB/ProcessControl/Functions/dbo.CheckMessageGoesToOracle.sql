SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 3/5/2017 
-- Description:	Checks if the message should be sent to Oracle
-- ============================================= 
CREATE FUNCTION [dbo].[CheckMessageGoesToOracle]  
( 
	@MessageTag VARCHAR(100) 
) 
RETURNS BIT 
AS 
BEGIN 
	-- Declare the return variable here 
	DECLARE @YesWeCan BIT = 0 
 
	SELECT 
		@YesWeCan = SendToOracle
	FROM 
		dbo.ProcessStatusControl
	WHERE 
		MessageTag = @MessageTag
 
	-- Return the result of the function 
	RETURN @YesWeCan 
 
END 
 

GO
