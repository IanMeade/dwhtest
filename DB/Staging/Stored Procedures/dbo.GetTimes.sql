SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 13/1/2017
-- Description:	Return dataset to populate DimTime
-- =============================================
CREATE PROCEDURE [dbo].[GetTimes]
AS
BEGIN
	SET NOCOUNT ON;

	WITH TimesCTE AS
		(
			SELECT
				cast('00:00:00:00' as time(2)) AS [time],
				1 as [Timeid]
		UNION ALL
			SELECT 
				DATEADD(minute, 1, [time] ),[Timeid]+1
		FROM 
			TimesCTE 
		WHERE 
 			timeid<1440
		)
		SELECT 
			CAST((DATEPART(HOUR,t.time)*100) + DATEPART(MINUTE,t.time) AS SMALLINT) TimeID,
			t.time,
			CONVERT(VARCHAR(2),t.[time],114) as LocalTimeHrText,
			CONVERT(VARCHAR(5),t.[time],114) as LocalTimeMinText
		FROM 
			TimesCTE t
		OPTION (MAXRECURSION 0);


END
GO
