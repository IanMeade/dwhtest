SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 17/5/2017   
-- Description:	Apply emergenvy fixes to XT Corportate actions before pushing ito DWH   
-- =============================================   
CREATE PROCEDURE [dbo].[XtCorporateActionsEmergencyFixes]    
AS   
BEGIN   
	SET NOCOUNT ON;   
   
	/* Fix up Corporate Actions */ 
 
	DELETE 
		dbo.XtOdsCorporateAction 
	WHERE
		ExtractSequenceId NOT IN (
						SELECT
							MAX(ExtractSequenceId) AS ExtractSequenceId
						FROM
							dbo.XtOdsCorporateAction 
						GROUP BY
							GID
				)

	UPDATE 
		dbo.XtOdsCorporateAction 
	SET 
		SpecialActionHeadline = ISNULL(SpecialActionHeadline,'') 
		
	/* NET RELAVENT TODATETIMEOFFSET EVERY TPYE => MAKE 0 IF INVALID */
	UPDATE
		dbo.XtOdsCorporateAction
	SET	
		NumberOfNewShares = 0
	WHERE
		ISNUMERIC(NumberOfNewShares) = 0


	/* MAKE ANY MISSING CURRENCIRES EURO - NEEDED AS NON-DIVIDENDS DO NOT HAVE CURRENCIES - ANY DIVIDENED WITH NO CURRENCY SHOULD BE REMVOED BEFORE GETTING HERE */
	/* ORE OF THIS IN [ValidateXtCaBasic] */
	UPDATE
		dbo.XtOdsCorporateAction
	SET	
		Currency = 'EUR'
	WHERE
		Currency IS NULL
	OR
		Currency = ''

	/* END */
	
END   
 
 
GO
