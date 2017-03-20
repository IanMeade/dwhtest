SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


 
	 
CREATE VIEW [dbo].[BestCompany] AS 
		SELECT 
			DISTINCT
			* 
		FROM 
			dbo.XtOdsCompany 
		WHERE 
			ExtractSequenceId IN ( 
					SELECT 
						MAX(ExtractSequenceId) AS ExtractSequenceId 
					FROM 
						dbo.XtOdsCompany 
					GROUP BY 
						GID 
			)  
 
 


GO
