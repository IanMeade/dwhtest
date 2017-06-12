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

	UPDATE
		dbo.XtOdsCorporateAction
	SET
		ActionType = ISNULL(ActionType,'')
END  


GO
