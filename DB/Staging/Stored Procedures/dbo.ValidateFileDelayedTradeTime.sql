SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 27/1/2016 
-- Description:	Validate file row counts 
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateFileDelayedTradeTime] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
 
	DECLARE @RejectFile table(  
			FileName VARCHAR(50),  
			FileTag VARCHAR(50)
		) 
   
   /* Validates file in staging before it gets to ODS */

	/* Files with invalid delayed trades */ 
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
		[FileName] IN ( 
				SELECT 
					[FileName] 
				FROM 
					dbo.Saft_TxSaft 
				WHERE
					A_DEFERRED_IND = 'Y'
				AND
					A_IND_PUBLICATION_TIME IS NULL					
				GROUP BY 
					[FileName] 
			) 
 
 	 
	/* Return details to validation framework */ 
	SELECT 
		189 AS Code,
		'SAFT FILE WITH DELAYED TRADE WITHOUT DELAYED DATE AND TIME FOUND [' + FileName + ' - ' + CONVERT(CHAR(8),A_TRADE_DATE,112) + '\' + RTRIM(A_TRADE_LINK_NO) + '] FILE REJECTED AND MOVED TO REJECT FOLDER.' AS Message
	FROM 
		dbo.Saft_TxSaft 
	WHERE
		A_DEFERRED_IND = 'Y'
	AND
		A_IND_PUBLICATION_TIME IS NULL					
	GROUP BY 
		[FileName],
		A_TRADE_DATE,
		A_TRADE_LINK_NO


END 
GO
