SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================   
-- Author:		Ian Meade   
-- Create date: 12/6/2017   
-- Description:	Set the WorkingDay flag 
-- =============================================   
CREATE PROCEDURE [dbo].[SetWorkingDay]
	@WorkingDayYN CHAR(1)
AS   
BEGIN   
	-- SET NOCOUNT ON added to prevent extra result sets from   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
	IF NOT EXISTS( SELECT * FROM dbo.Today )
	BEGIN
		INSERT INTO dbo.Today 
				( WorkingDayYN ) 
			VALUES 
				( @WorkingDayYN )
	END
	ELSE
	BEGIN
		UPDATE
			dbo.Today 
		SET	
			WorkingDayYN = @WorkingDayYN
	END
   
END   

GO
