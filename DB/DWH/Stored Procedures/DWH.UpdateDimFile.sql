SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 20/1/2017
-- Description:	Update DimFile 
-- =============================================
CREATE PROCEDURE [DWH].[UpdateDimFile]
	@FileName VARCHAR(50), 
	@FileTypeTag VARCHAR(50), 
	@SaftFileLetter CHAR(1), 
	@FilePrcocessedStatus VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @File TABLE (
				FileName VARCHAR(50), 
				FileTypeTag VARCHAR(50), 
				SaftFileLetter CHAR(1), 
				FilePrcocessedStatus VARCHAR(50)
		)
	INSERT INTO
			@File
		VALUES
			(
				@FileName,
				@FileTypeTag,
				@SaftFileLetter,
				@FilePrcocessedStatus
			)


	MERGE
		DWH.DimFile AS F
	USING
		@File AS I
	ON F.FileName = I.Filename
	WHEN MATCHED THEN
		UPDATE
			SET
				FileProcessedTime = GETDATE(),
				FilePrcocessedStatus = I.FilePrcocessedStatus
	WHEN NOT MATCHED THEN
		INSERT 
				( FileName, FileType, FileTypeTag, SaftFileLetter, FileProcessedTime, FilePrcocessedStatus )
			VALUES 
				( I.FileName, I.FileTypeTag, I.FileTypeTag, I.SaftFileLetter, GETDATE(), I.FilePrcocessedStatus );

END
GO
