SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 3/5/2017 
-- Description:	Add an entry to the ProcessStatus table - includes transtion to Oracle like message
-- ============================================= 
CREATE PROCEDURE [dbo].[InsertProcessStatus]
	@BatchID INT,
	@MessageTag VARCHAR(MAX)
AS 
BEGIN 
	SET NOCOUNT ON; 

	DECLARE @Message VARCHAR(MAX) = @MessageTag

	/* TRY TO GET A BETTER MESSAGE */	
	SELECT
		@Message = Message
	FROM
		dbo.ProcessStatusControl
	WHERE
		MessageTag = @MessageTag 

		
	INSERT INTO dbo.ProcessStatus
		(
			BatchID, 
			Message
		)
		VALUES
		(
			@BatchID,
			@Message
		)

END 


GO
