SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



  
  
CREATE VIEW [dbo].[BestShare] AS   
		SELECT  
			DISTINCT 
			*   
		FROM   
			dbo.XtOdsShare   
		WHERE   
			/* Cannot use ExtractSequenceID due to Embracing issue */
			ID IN (   
					SELECT   
						MAX(ID) AS ID   
					FROM   
						dbo.XtOdsShare   
					GROUP BY   
						Gid   
			)    
  		AND
			GID <> ''

  



GO
