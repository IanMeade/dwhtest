SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 19/4/2017
-- Description:	Wrapper for WAITFOR delay - used by near real time package
-- =============================================
CREATE PROCEDURE [dbo].[DelayForControlledPollingAction]
	@ACTION_TAG VARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/* TEST DELAY */

	DECLARE @NEXT_RUN AS DATETIME

	SELECT
		GETDATE()

	SELECT
		@NEXT_RUN = dbo.GetNextDateTime(@ACTION_TAG ) 

	WAITFOR
		TIME @NEXT_RUN

END
GO
