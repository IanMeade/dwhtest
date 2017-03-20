SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Ian Meade
-- Create date: 1/3/2017
-- Description:	Validation dummy routine - always fails
-- =============================================
CREATE PROCEDURE [dbo].[ValidateAlwaysFail]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		CAST(99 AS INT) AS Code,
		CAST('TEST FAILED' AS VARCHAR(1000)) AS Message


END

GO
