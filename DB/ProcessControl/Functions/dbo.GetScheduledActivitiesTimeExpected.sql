SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 16/6/2017
-- Description:	Determine if an activity should be run and what the expected time is
-- =============================================
CREATE FUNCTION [dbo].[GetScheduledActivitiesTimeExpected]
(	
	@Activity VARCHAR(100)
)
RETURNS TABLE 
AS
RETURN 
(
	/* QUERY LLOK MORE COMPLEX THEN IF SHOULD...
	RETURN AT LEAT ONE ROW
	RETURN MOST RECETN EXPCTED TIME THAT HAS NOT BEEN PROCESSED TODAY
	*/
	

WITH Exp AS (
			SELECT
				MAX(ExpectedTime) AS ExpectedTime
			FROM
				dbo.ScheduledActivitiesTimeExpected
			WHERE
				Activity = @Activity
			AND
				ExpectedTime <= CAST(GETDATE() AS TIME)
		),
	Dummy AS (
		SELECT
			1 AS SECTION,
			IIF(SCH.LastProcessed IS NULL,1,IIF(SCH.LastProcessed < CAST(GETDATE() AS DATE),1,0)) AS WorkToDo,
			SCH.ExpectedTime,
			SCH.OracleProcessStatusTable
		FROM
				Exp
			INNER JOIN
				dbo.ScheduledActivitiesTimeExpected SCH
			ON Exp.ExpectedTime = SCH.ExpectedTime
		WHERE
			Activity = @Activity
		UNION
		SELECT
			2 AS SECTION,
			0 AS WorkToDo,
			NULL AS ExpectedTime,
			'DUMMY' AS OracleProcessStatusTable
		)
	SELECT
		TOP 1
		*
	FROM
		Dummy
	ORDER BY 
		SECTION

)
GO
