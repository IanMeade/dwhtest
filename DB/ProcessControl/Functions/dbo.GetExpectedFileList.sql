SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 8/3/2017
-- Description:	get list of espected lists and hopw long to wait for them
-- =============================================
CREATE FUNCTION [dbo].[GetExpectedFileList]
(
)
RETURNS 
	@ExpectedFileList TABLE 
(
	ExpectedFileYN CHAR(1),
	ExpectedFileName VARCHAR(50),
	ExpectedByTime TIME(7)
)
AS
BEGIN

	/* NOTE:
		
		MULTI-STATEMENT FUNCTIONS CAN CAUSE PERFORMANCE ISSUES => USE WITH CARE

		DESIGNED TO RETURN ONE FILE OMLY - INTERFACER SUPPORTS MULTIPLE FILES AND CAN BE EXTENDED

	*/

	DECLARE @ExpectedFileLetter CHAR(1) = NULL
	DECLARE @ExpectedFileName VARCHAR(50)
	DECLARE @ExpectedByTime TIME 

	SELECT
		TOP 1
		@ExpectedFileLetter = FileLetter,
		@ExpectedByTime = DATEADD( minute, ReprocessDelayMinutes, ExpectedStartTime )
	FROM
		FileControlT7
	WHERE
		CAST( GETDATE() AS TIME) BETWEEN ExpectedStartTime AND ExpectedFinishTime
	AND
		ProcessFileYN = 'Y'
	ORDER BY
		FileLetter DESC


	SELECT
		@ExpectedFileName = FilePrefix + CONVERT(CHAR(8),GETDATE(),112) + @ExpectedFileLetter 
	FROM
		FileControl
	WHERE
		FileTag = 'TxSaft'

	INSERT INTO
			@ExpectedFileList
		SELECT
			IIF( @ExpectedFileName IS NULL, 'N', 'Y' ) AS ExpectedFileYN,
			@ExpectedFileName AS ExpectedFileName,
			@ExpectedByTime AS ExpectedByTime


	RETURN 
END
GO
