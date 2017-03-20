SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 16/1/2016 
-- Description:	Validate SAFT file dates 
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateSaftFileDate] 
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
			LEFT(REPLACE(FileName,FilePrefix,''),8) <> CONVERT(CHAR(8),GETDATE(),112) 
	 
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
		'SAFT FILE INCORRECT DATE', 
		'SAFT FILE [' + FileName + '] FOUND IN SOURCE FOLDER.', 
		'FILE REJECTED AND MOVED TO REJECT FOLDER.' 
	FROM 
		@RejectFile 

	SELECT
		1 AS Code,
		Message = 'SAFT File has incorrect date [' + FileName + '] rejected and moved to reject folder.'
	FROM 
		@RejectFile 

END 
GO
