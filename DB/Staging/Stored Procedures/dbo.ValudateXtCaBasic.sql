SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================  
-- Author:		Ian Meade  
-- Create date: 16/5/2017  
-- Description:	Basic XT Corporate Action validation - misc lookups - bad data is removed from staging table  
-- =============================================  
CREATE PROCEDURE [dbo].[ValudateXtCaBasic] 
AS  
BEGIN  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
  
	/* Result tables - empty table means no invalid rows found */  
	DECLARE @Messages TABLE ( Code INT, Message VARCHAR(2000), GID VARCHAR(30) )  
  
	INSERT INTO 
			@Messages
		SELECT  
			701 AS Code,  
			'Corporate Action [] is not in MDM. Corporate Action [] has not been processed' AS Message,
			GID
		FROM  
			dbo.XtOdsCorporateAction
		WHERE  
			CorpActionType NOT IN (
					SELECT
						CorportateActionCode
					FROM
						dbo.MdmCorporateAction
				)
		UNION
		SELECT  
			702 AS Code,  
			'Corporate Action Status [] is not in MDM. Corporate Action [] has not been processed' AS Message,
			GID
		FROM  
			dbo.XtOdsCorporateAction
		WHERE  
			Status NOT IN (
					SELECT
						CorporateActionStatusCode
					FROM
						dbo.MdmCorporateActionStatus
				)
		UNION
		SELECT  
			703 AS Code,  
			'Corporate Action Action Type [] is not in MDM. Corporate Action [] has not been processed' AS Message,
			GID
		FROM  
			dbo.XtOdsCorporateAction
		WHERE  
			ActionType NOT IN (
					SELECT
						CorporateActionTypeCode
						CorporateActionStatusCode
					FROM
						dbo.MdmCorporateActionActionType
				)


	/*  Delete invalid instruments */
	DELETE
		dbo.XtOdsCorporateAction
	WHERE
		GID IN (
				SELECT 
					GID
				FROM 
					@Messages  
				)
	  
	/* RETURN ALL ERROR MESSAGES */  
	SELECT   
		Code,  
		Message  
	FROM  
		@Messages  
  
    
END  


GO
