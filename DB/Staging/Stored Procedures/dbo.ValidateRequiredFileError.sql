SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 8/3/2017
-- Description:	Validate - required file error
-- =============================================
CREATE PROCEDURE [dbo].[ValidateRequiredFileError]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		235 Code,
		'Required file [' + ExpectedFileName + '] not found - timeout exceeeded. Process continuing.' AS Message
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

END
GO
