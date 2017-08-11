SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
   
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 2/6/2017   
-- Description:	Validate - required file found - uses validation routine to send amessage  - SAFT file 
-- =============================================   
CREATE PROCEDURE [dbo].[ValidateRequiredFileFoundSaftFile]   
AS   
BEGIN   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
	SELECT 
		808 AS Code, 
		'SAFT File not received - File letter [' + FileLetter + '] expected at ' + CAST(ExpectedStartTime AS char(5)) + ' has not been received.' AS Message 
	FROM 
		dbo.ProcessControlExpectedFileList 
	WHERE 
			FileTag = 'TxSaft'
		AND			
			ProcessFileYN = 'Y' 
		AND 
			CAST(GETDATE() AS TIME) BETWEEN WarningStartTime AND WarningEndTime 
		AND  
			FileLetter NOT IN ( 
							SELECT 
								Saftletter 
							FROM 
								FileList 
							WHERE 
								FileTag IN ( 'TxSaft' ) 
							UNION 
							SELECT 
								FileName
							FROM 
								dbo.ODS_FileList
							WHERE 
								FileTag IN ( 'TxSaft' ) 
							AND 
								CAST(Populated AS DATE) = CAST(GETDATE() AS DATE) 
					) 
   
END   
   
GO
