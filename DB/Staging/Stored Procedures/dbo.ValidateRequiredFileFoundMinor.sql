SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 
   
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 2/6/2017   
-- Description:	Validate - required file found - uses validation routine to send amessage  - T7 Project non-core T7 files  
-- =============================================   
CREATE PROCEDURE [dbo].[ValidateRequiredFileFoundMinor]   
AS   
BEGIN   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
	DECLARE @Date AS DATE = CAST(GETDATE() AS DATE)


	SELECT 
		813 AS Code, 
		'Expected file not received - File Tag [' + FileTag  + '] expected at ' + CAST(ExpectedStartTime AS char(5)) + ' has not been received.' AS Message 
	FROM 
		dbo.ProcessControlExpectedFileList 
	WHERE 
			FileTag NOT IN ( 'PriceFile', 'TxSaft' ) 
		AND 
			CAST(GETDATE() AS TIME) BETWEEN WarningStartTime AND WarningEndTime 
		AND
			FileTag NOT IN  (
				SELECT
					FileTag
				FROM
					dbo.FileList
				UNION ALL
				SELECT
					FileTag
				FROM
					dbo.ODS_FileList
				WHERE
					CAST(Populated AS date ) = @Date
			)

END   
   
 
 

GO
