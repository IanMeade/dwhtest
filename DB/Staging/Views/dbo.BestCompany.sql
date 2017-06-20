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
			/* Cannot use ExtractSequenceID due to Embracing issue */
			ID IN (   
					SELECT   
						MAX(ID) AS ID   
					FROM   
						dbo.XtOdsCompany   
					GROUP BY   
						GID   
			)    
		AND
			GID <> ''


GO
