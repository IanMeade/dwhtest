SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
  
  
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 9/5/2017   
-- Description:	Add an entry to the ProcessMessage - simple dump of string passed in  
-- =============================================   
CREATE PROCEDURE [dbo].[InsertProcessMessage]  
	@BatchID INT,  
	@Message VARCHAR(MAX),
	@Context VARCHAR(MAX) = NULL
AS   
BEGIN   
	SET NOCOUNT ON;   
	  
	INSERT INTO dbo.ProcessMessage  
		(  
			BatchID,   
			Message,
			Context
		)  
		VALUES  
		(  
			@BatchID,  
			@Message,
			@Context
		)  
  
END   
  
  
GO
