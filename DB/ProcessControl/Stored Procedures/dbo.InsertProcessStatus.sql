SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 1/3/2017 
-- Description:	Add an entry to the ProcessStatus table
-- ============================================= 
CREATE PROCEDURE [dbo].[InsertProcessStatus]
	@BatchID INT,
	@Message VARCHAR(MAX)
AS 
BEGIN 
	SET NOCOUNT ON; 
 
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
