SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 1/3/2017
-- Description:	Gte list of unti tests to run
-- =============================================
CREATE PROCEDURE [dbo].[GetUnitTestList]
	@ValidationTestSuiteTag VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		TS.ValidationTestSuiteID,
		UT.ValidationUnitTestID, 
		UT.ValidationUnitTestName, 
		UT.ValidationUnitTestTag, 
		UT.TestDatabase, 
		UT.TestStoredProcedure, 	
		UT.ErrorCondition, 
		UT.WarningCondition, 
		UT.SilentChanges
	FROM
			dbo.ValidationTestSuite TS
		INNER JOIN
			dbo.ValidationUnitTest UT
		ON TS.ValidationTestSuiteID = UT.ValidationTestSuiteID
	WHERE
		TS.ValidationTestSuiteTag = @ValidationTestSuiteTag 
	AND
		TS.Enabled = 1
	AND
		UT.Enabled = 1
	ORDER BY
		RunOrder
END
GO
