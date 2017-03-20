SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 16/1/2016 
-- Description:	Validate file duplicates - only does saft and price
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateFileDuplicates] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
 
	DECLARE @RejectFile table(  
			FileName VARCHAR(50),  
			FileTag VARCHAR(50) 
		) 
   
	/* SAFT FILE RECEIVED WITH INCORRECT DATE */ 
	/* mark bad files as rejects!!!! */ 
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
			ProcessFileYN = 'Y'	 
		AND 
			FileTag IN ( 'TxSaft', 'PriceFile' ) 
		AND
			FileName in (
						SELECT
							FileName
						FROM
							DwhDimFile
					)

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
		'Duplicate File found', 
		'File [' + FileName + '] is already in DHW', 
		'File rejected and moved to reject folder' 
	FROM 
		@RejectFile 

	SELECT
		1 AS Code,
		Message = 'Duplicate file found [' + FileName + '] is already in DWH. File rejected and moved to reject folder.'
	FROM 
		@RejectFile 

END 

GO
