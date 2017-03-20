SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 27/1/2016 
-- Description:	Validate file row counts 
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateFileRowCount] 
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
					dbo.Saft_TxSaft 
				WHERE 
					DwhFileID NOT IN ( 
							SELECT 
								DwhFileID 
							FROM 
								dbo.Saft_FileRowCount 
						) 
				GROUP BY 
					[FileName] 
			) 
 
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
		'SAFT FILE WIHHOUT ROW COUNT', 
		'SAFT FILE [' + FileName + '] DOES NOT HAVE A ROW COUNT.', 
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
				[dbo].[Saft_TxSaft] 
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
				[dbo].[Saft_FileRowCount] 
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
		'SAFT FILE WITH INCORRECT ROW COUNT FOUND', 
		'SAFT FILE [' + FileName + '] FOUND IN SOURCE FOLDER WITH INCORRECT ROW COUNT.', 
		'FILE REJECTED AND MOVED TO REJECT FOLDER.' 
	FROM 
		@RejectFile 

	/* Integrate wih main validtion framework */
	SELECT
		99 AS Code,
		'SAFT FILE WITH INCORRECT ROW COUNT FOUND [' + FileName + '] FILE REJECTED AND MOVED TO REJECT FOLDER.' AS Message
	FROM
  		@RejectFile 

END 
GO
