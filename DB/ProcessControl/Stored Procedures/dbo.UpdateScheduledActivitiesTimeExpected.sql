SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 12/6/2017
-- Description:	Update the ScheduledActivitiesTimeExpected table with a run 
-- =============================================
CREATE PROCEDURE [dbo].[UpdateScheduledActivitiesTimeExpected] 
	@Activity VARCHAR(100),
	@ExpectedTime TIME
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE
		ScheduledActivitiesTimeExpected
	SET
		LastProcessed = GETDATE()
	WHERE
		Activity = @Activity
	AND
		ExpectedTime = @ExpectedTime

END
GO
