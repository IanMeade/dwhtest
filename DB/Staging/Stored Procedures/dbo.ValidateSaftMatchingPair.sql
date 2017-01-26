SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Ian Meade
-- Create date: 16/1/2016
-- Description:	Validate SAFT files-  both sides of trade and price file pair exist
-- =============================================
CREATE PROCEDURE [dbo].[ValidateSaftMatchingPair]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DECLARE @RejectFile table( 
			FileName VARCHAR(50), 
			FileTag VARCHAR(50)
		)
  

	/* TRADE FILE WIHTOUT MATCHING PRICE FILE */
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
		FileName IN (
				SELECT
					ISNULL(T.FileName, P.FileName) AS FileName
				FROM
					(
						SELECT
							FileName,
							/* Stub includes data and letter */
							REPLACE(FileName,FilePrefix,'') AS TradeStub
						FROM
							dbo.FileList
						WHERE
							FileTag =  'TradeFile'
					) AS T
					FULL OUTER JOIN
					(
						SELECT
							FileName,
							/* Stub includes data and letter */
							REPLACE(FileName,FilePrefix,'') AS PriceStub
						FROM
							dbo.FileList
						WHERE
							FileTag =  'PriceFile'
					) AS P	
					ON T.TradeStub = P.PriceStub
				WHERE
					/* NULL ENTRY ON EITHER SIDE */
						T.FileName IS NULL
					OR
						P.FileName IS NULL
			)
		AND
			ProcessFileYN = 'Y'

	
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
		'SAFT FILE INCOMPLETE PAIR',
		'SAFT FILE [' + FileName + '] FOUND IN SOURCE FOLDER WITHOUT MATCHING SAFT FILE.',
		'FILE REJECTED AND MOVED TO REJECT FOLDER.'
	FROM
		@RejectFile
END


GO
