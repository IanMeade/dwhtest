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
		FileTag, 
		FileNameMask, 
		FilePrefix, 
		SourceFolder, 
		ProcessFolder, 
		ArchiveFolder, 
		RejectFolder 
	FROM 
		dbo.FileControl
	WHERE 
		EnabledYN = 'Y' 
 
END 
GO
