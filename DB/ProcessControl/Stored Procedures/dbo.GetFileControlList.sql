SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 16/1/2017
-- Description:	Get file control details
-- =============================================
CREATE PROCEDURE [dbo].[GetFileControlList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		SS.SourceSystemID,
		SourceSystemTag,
		FC.FileTag,
		FC.FileNameMask,
		FC.FilePrefix,
		FC.SourceFolder,
		FC.ProcessFolder,
		FC.ArchiveFolder,
		FC.RejectFolder
	FROM
			dbo.SourceSystem SS
		INNER JOIN
			dbo.FileControl FC
		ON SS.SourceSystemID = FC.SourceSystemID
	WHERE
		SS.EnabledYN = 'Y'

END
GO
