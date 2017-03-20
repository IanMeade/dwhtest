SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 8/3/2017
-- Description:	validate that required files are present- includes delay
-- =============================================
CREATE PROCEDURE [dbo].[ValidateRequiredFilesExistWithWaitForDelayIncluded]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TestCondition TINYINT = NULL
	/*
		@TestCondition 
			1 - ALL REQUIRED FULES FOUND
			2 - FILE MiSSING -> RETRY
			3 - FILE MISSING -> TIMEOUT EXCEEDED 
	*/


	/* LIST OF EXPECTED FILES THAT HAVE NOT BEEN FOUND */
	SELECT
		ExpectedFileName,
		ExpectedByTime
	INTO
		#RequiredFiles
	FROM
		dbo.ProcessControlExpectedFileList
	WHERE
		ExpectedFilename NOT IN (
			SELECT
				LEFT(FileName,CHARINDEX('.',FileName)-1)
			FROM
				FileList
				)
	AND
		ExpectedFileYN = 'Y'

	IF NOT EXISTS ( SELECT * FROM #RequiredFiles )
	BEGIN
		SET @TestCondition = 1
	END
	ELSE
	IF EXISTS ( SELECT * FROM #RequiredFiles WHERE ExpectedByTime > CAST(GETDATE() AS TIME) )
	BEGIN
		WAITFOR
			DELAY '00:00:10'
		SET @TestCondition = 2
	END
	ELSE
	BEGIN
		SET @TestCondition = 3
	END

	DROP TABLE #RequiredFiles 


	/* RETURN RESULT */
	SELECT
			@TestCondition AS TestCondition 
	/*
		@TestCondition 
			1 - ALL REQUIRED FULES FOUND
			2 - FILE MiSSING -> RETRY
			3 - FILE MISSING -> TIMEOUT EXCEEDED 
	*/

END
GO
