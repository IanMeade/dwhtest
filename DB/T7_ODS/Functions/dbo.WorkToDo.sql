SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Ian Meade
-- Create date: 12/6/2017
-- Description:	Work to do - used by master package precedence rules
-- =============================================
CREATE FUNCTION [dbo].[WorkToDo]
(
)
RETURNS BIT
AS
BEGIN
	DECLARE @ResultVar BIT

	SELECT
		@ResultVar = IIF(X.CNT=0,0,1)
	FROM
		(
				SELECT	
					COUNT(*) AS CNT
				FROM
					FileList
				WHERE
					DwhStatus NOT IN ( 'COMPLETE', 'REJECT' )
		) AS X

	RETURN @ResultVar

END

GO
