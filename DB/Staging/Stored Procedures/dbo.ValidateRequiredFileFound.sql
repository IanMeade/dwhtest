SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Ian Meade
-- Create date: 8/3/2017
-- Description:	Validate - required file found - uses validation routine to send amessage
-- =============================================
CREATE PROCEDURE [dbo].[ValidateRequiredFileFound]
AS
BEGIN
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		235 Code,
		'Required file [' + ExpectedFileName + '] found - processing continuing.' AS Message
	FROM
		dbo.ProcessControlExpectedFileList
	WHERE
		ExpectedFilename IN (
			SELECT
				LEFT(FileName,CHARINDEX('.',FileName)-1)
			FROM
				FileList
				)
	AND
		ExpectedFileYN = 'Y'


END

GO
