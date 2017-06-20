SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



  
  
   
CREATE VIEW [dbo].[BestIssuer] AS   
		SELECT   
			DISTINCT
			*   
		FROM   
				dbo.XtOdsIssuer   
		WHERE   
			/* Cannot use ExtractSequenceID due to Embracing issue */
			ID IN (   

					SELECT   
						MAX(ID) AS ID   
					FROM   
						dbo.XtOdsIssuer   
					GROUP BY   
						Gid   
			)    
		AND
			GID <> ''
   



GO
