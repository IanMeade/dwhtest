SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 17/1/2017
-- Description:	Checks if the passed in Scheduletag can be run now
--				WARNING --- SCALAR FUNCTIONS ARE NOT SUITBALE FOR LARGE NUMBERS OF ROWS - USE ONLY FOPR SMALL RESULT SETS
-- =============================================
CREATE FUNCTION [dbo].[CheckScheduleTag] 
(
	@ScheduleTag VARCHAR(100)
)
RETURNS BIT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @YesWeCan BIT = 0

	DECLARE @TestDate DATETIME = GETDATE()
	--DECLARE @ScheduleTag VARCHAR(100)
	DECLARE @TestTime CHAR(5) = CONVERT(CHAR(5), @TestDate , 114 )

	/* SAMPLE SCHEDULE TAGS */
	/*
		SET @ScheduleTag = 'ALWAYS'
		SET @ScheduleTag = 'DAILY:[09:00=17:00]'
		SET @ScheduleTag = 'DAILY:[21:00=22:00]'
		SET @ScheduleTag = 'MONDAY:TUESDAY:THURSDAY'
		SET @ScheduleTag = 'SATURDAY:SUNDAY'
	*/

	SELECT
		@YesWeCan = ISNULL(MAX(YesWeCan), @YesWeCan ) 
	FROM
		(
			/* ALWAYS RUN */
			SELECT
				1 AS YesWeCan
			WHERE
				@ScheduleTag = 'ALWAYS'
			UNION ALL
			/* RUN DAILY BETWEEN SPECIFIED TIMES */
			SELECT
				1 AS YesWeCan
			WHERE
				LEFT(@ScheduleTag,5) = 'DAILY' 
			AND
				@TestTime BETWEEN 	SUBSTRING(@ScheduleTag,8,5) AND SUBSTRING(@ScheduleTag,14,5)
			UNION ALL
			/* NAMED DAY OF WEEK - NO TIME SPECIFIED*/
			SELECT
				1 AS YesWeCan
			WHERE
				CHARINDEX(UPPER(DATENAME(DW,@TestDate)),UPPER(@ScheduleTag)) <> 0
		) AS YesWeCan


	-- Return the result of the function
	RETURN @YesWeCan

END
GO
