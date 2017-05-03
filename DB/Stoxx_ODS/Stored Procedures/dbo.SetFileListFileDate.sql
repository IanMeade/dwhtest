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
							UNION 
							SELECT
								CAST(SUBSTRING(FileName,7,8)  AS DATE) AS FileDate
							FROM
								FileList
							WHERE
								FileID = @FileID
							AND
								FileTag = 'ISEQ20_STATS'
							UNION
							SELECT
								CAST(SUBSTRING(FileName,16,8) AS DATE) AS FileDate
							FROM
								FileList
							WHERE
								FileID = @FileID
							AND
								FileTag = 'ISEQ20_LEVERAGED'
				)
	WHERE
		FileID = @FileID

END
GO
