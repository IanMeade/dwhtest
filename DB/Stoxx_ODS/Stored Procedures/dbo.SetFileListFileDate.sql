SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 20/4/2017  
-- Description:	Set FileDate in FileList  
-- =============================================  
CREATE PROCEDURE [dbo].[SetFileListFileDate]  
	@FileID INT  
AS  
BEGIN  
	SET NOCOUNT ON;  
  
	UPDATE  
		FileList  
	SET  
		FileDate = (  
							SELECT  
								CAST(SUBSTRING(FileName,4,8) AS DATE) AS FileDate  
							FROM  
								FileList  
							WHERE  
								FileID = @FileID  
							AND  
								FileTag = 'STATS'  
							UNION ALL   
							SELECT  
								CAST(SUBSTRING(FileName,7,8)  AS DATE) AS FileDate  
							FROM  
								FileList  
							WHERE  
								FileID = @FileID  
							AND  
								FileTag = 'ISEQ20_STATS'  
							UNION ALL
							SELECT  
								CAST(SUBSTRING(FileName,16,8) AS DATE) AS FileDate  
							FROM  
								FileList  
							WHERE  
								FileID = @FileID  
							AND  
								FileTag = 'ISEQ20_LEVERAGED'  
							UNION ALL
							SELECT  
								CAST(SUBSTRING(FileName,25,8) AS DATE) AS FileDate  
							FROM  
								FileList  
							WHERE  
								FileID = @FileID  
							AND  
								FileTag = 'ISEQ_OVERALL_PRICE'
							UNION ALL
							SELECT  
								CAST(SUBSTRING(FileName,27,8) AS DATE) AS FileDate  
							FROM  
								FileList  
							WHERE  
								FileID = @FileID  
							AND  
								FileTag = 'ISEQ_SMALL_CAP_PRICE' 
							UNION ALL
							SELECT  
								CAST(SUBSTRING(FileName,27,8) AS DATE) AS FileDate  
							FROM  
								FileList  
							WHERE  
								FileID = @FileID  
							AND  
								FileTag = 'ISEQ20_CAPPED_PRICE'
				)  
	WHERE  
		FileID = @FileID  
  
END  

GO
