SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 16/6/2017
-- Description:	Determine if an axctivity should be run and what the expected time is
-- =============================================
CREATE FUNCTION [dbo].[GetScheduledActivitiesTimeExpected]
(	
	@Activity VARCHAR(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
		ExpectedTime,
		IIF(LastProcessed IS NULL, 1, IIF(CAST(GETDATE() AS DATE) > CAST(LastProcessed AS DATE) ,1,0)) AS WorkToDo
	FROM
			dbo.ScheduledActivitiesTimeExpected
	WHERE
		ExpectedTime IN (
				SELECT
					MAX(ExpectedTime) AS ExpectedTime
				FROM
					dbo.ScheduledActivitiesTimeExpected InSide
				WHERE
					Activity = @Activity
				AND
					ExpectedTime <= CAST(GETDATE() AS TIME)
			)
		AND
			Activity = @Activity
)
GO
