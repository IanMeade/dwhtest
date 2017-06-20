SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 31/3/2017  
-- Description:	Get a validation message suitbale for email  
-- =============================================  
CREATE FUNCTION [dbo].[GetValidationMessage]  
(  
	@ValidationLogID INT  
)  
RETURNS VARCHAR(1000)  
AS  
BEGIN  
	/* WARNING - SCALAR UDFs CAN LEAD TO PERFORMANCE ISSUES - DO NOT USE WITHOUT CONSIDERING IMPACT */  
  
	RETURN  
	(  
		SELECT   
			TOP 1  
			'Validation routine [' + ut.ValidationUnitTestName + ' \ ' + UT.TestStoredProcedure + '] returned [' + LTRIM(STR(L.WarningCount + L.ErrorCount)) + '] messages ' + CHAR(13) + CHAR(10) +   
								'First message: ' + M.Message + CHAR(13) + CHAR(10) +   
								'Refer to the ProcessControl ValidationLog [' + LTRIM(L.ValidationLogID) + '] for more details' AS X  
										  
		FROM  
				dbo.ValidationLog L  
			INNER JOIN	  
				dbo.ValidationLogMessage M  
			ON L.ValidationLogID = M.ValidationLogID  
			INNER JOIN  
				dbo.ValidationUnitTest UT  
			ON L.ValidationUnitTestID = UT.ValidationUnitTestID  
		WHERE  
			L.ValidationLogID = @ValidationLogID  
		ORDER BY  
			L.ValidationLogID  
	)				  
  
END  
GO
