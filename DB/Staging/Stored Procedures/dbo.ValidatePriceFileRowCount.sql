SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 2/2/2016
-- Description:	Validate price file row counts
-- =============================================
CREATE PROCEDURE [dbo].[ValidatePriceFileRowCount]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DECLARE @RejectFile table( 
			FileName VARCHAR(50), 
			FileTag VARCHAR(50)
		)
  
	/* Files without row counts */
	UPDATE
		dbo.FileList
	SET
		ProcessFileYN = 'R'
	OUTPUT
		inserted.FileName,
		inserted.FileTag
	INTO
		@RejectFile
	WHERE
		[FileName] IN (
				SELECT
					[FileName]
				FROM	
					dbo.Saft_Price
				WHERE
					DwhFileID NOT IN (
							SELECT
								DwhFileID
							FROM
								dbo.Saft_PriceFileRowCount
						)
				GROUP BY
					[FileName]
			)

	/* Store alert details */
	INSERT INTO	
			dbo.PriceFileRowCountValidationAlert
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
		'SAFT PRICE FILE WIHHOUT ROW COUNT',
		'SAFT PRICE FILE [' + FileName + '] DOES NOT HAVE A ROW COUNT.',
		'FILE REJECTED AND MOVED TO REJECT FOLDER.'
	FROM
		@RejectFile


	/* EMPTY TEMP TBALE FOR NEXT VALIDATION RULE */
	DELETE @RejectFile 



	/* SAFT FILE RECEIVED WITH INCORRECT DATE */
	/* mark bad files as rejects!!!! */
	UPDATE
		FL
	SET
		ProcessFileYN = 'R'
	OUTPUT
		inserted.FileName,
		inserted.FileTag
	INTO
		@RejectFile
	FROM
			dbo.FileList FL
		INNER JOIN
		(
			SELECT
				FileName,
				DwhFileID,
				COUNT(*) AS CNT
			FROM
				dbo.Saft_Price
			GROUP BY
				FileName,
				DwhFileID
		) AS Saft
		ON FL.FileName = Saft.FileName
		INNER JOIN
		(
			SELECT
				DwhFileID,
				CAST([RowCount] AS INT) AS CNT
			FROM
				dbo.Saft_PriceFileRowCount
		) AS RC
		ON Saft.DwhFileID = RC.DwhFileID
		AND Saft.CNT <> RC.CNT 		

	
	/* Store alert details */
	INSERT INTO	
			dbo.FileRowCountValidationAlert
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
		'SAFT PRICE FILE WITH INCORRECT ROW COUNT FOUND',
		'SAFT PRICE FILE [' + FileName + '] FOUND IN SOURCE FOLDER WITH INCORRECT ROW COUNT.',
		'FILE REJECTED AND MOVED TO REJECT FOLDER.'
	FROM
		@RejectFile

END
GO
