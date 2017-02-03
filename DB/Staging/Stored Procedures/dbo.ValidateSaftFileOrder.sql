SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		Ian Meade
-- Create date: 16/1/2016
-- Description:	Validate SAFT files-  ensur files are received in order
-- =============================================
CREATE PROCEDURE [dbo].[ValidateSaftFileOrder]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DECLARE @RejectFile table( 
			FileName VARCHAR(50), 
			FileTag VARCHAR(50)
		)
  

	/* OUT OF ORDER FILE */
	/* ONLY CHECKS IF THE CURRENT FILE IS EARLIER OR THE SAME AS A FILE ALREADY PROCESSED */
	/*	DOES NOT CHECK IF A FILE WAS SKIPPED */
	/*	COVERS DUPLICTATES FILES */

	/* mark bad files as rejects!!!! */

	/* SHOULD COME FROM DHW */
	DECLARE @MostRecentFileToday CHAR(1) 
	SELECT
		@MostRecentFileToday = SaftFileLetter
	FROM
		dbo.SAFT_MaxFileLetter

	UPDATE
		dbo.FileList
	SET
		ProcessFileYN = 'R'
	OUTPUT
		inserted.FileName,
		inserted.FileTag
	INTO
		@RejectFile
	FROM
		dbo.FileList
	WHERE
		FileTag IN ( 'TxSaft', 'PriceFile' )
	AND
		SUBSTRING(REPLACE(FileName,FilePrefix,''),9,1) <= @MostRecentFileToday
	AND
		ProcessFileYN = 'Y'

	
	/* Store alert details */

	INSERT INTO	
			FileValidationAlert
		(
			FileName, 
			FileTag, 
			AlertTag, 
			Reason, 
			Action
		)
	SELECT
		FileName,
		FileTag,
		'SAFT FILE RECEIVED OUT OF ORDER',
		'SAFT FILE [' + FileName + '] FOUND IN SOURCE FOLDER WHEN A LATER FILE HAS ALREADY BEEN LOADED.',
		'FILE REJECTED AND MOVED TO REJECT FOLDER.'
	FROM
		@RejectFile
END



GO
