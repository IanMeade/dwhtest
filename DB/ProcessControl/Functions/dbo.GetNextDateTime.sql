SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 18/4/2017
-- Description:	Determine next time the choosen function can run - based on configured delay time
-- =============================================
CREATE FUNCTION [dbo].[GetNextDateTime]
(
	@TaskControlTag VARCHAR(50)
)
RETURNS DATETIME
AS
BEGIN
	DECLARE @DELAY_SECONDS INT
	DECLARE @NEXT_RUN AS DATETIME

	SELECT
		@DELAY_SECONDS = CAST(SwitchValue AS INT)
	FROM
		dbo.Switches 
	WHERE
		SwitchKey = @TaskControlTag

	SELECT
		@NEXT_RUN = CAST(DATEADD(SECOND, @DELAY_SECONDS, GETDATE()) AS TIME)

	RETURN @NEXT_RUN 
END
GO
