SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 1/3/2017
-- Description:	Validation dummy routine - always passes
-- =============================================
CREATE PROCEDURE [dbo].[ValidateAlwaysPass]
AS
BEGIN
	SET NOCOUNT ON;
	
	/* RETURN CORRECT RESULT TYPE WITH NO ROWS */

	SELECT
		0 AS Code,
		'' AS Message
	WHERE
		1=2
END
GO
