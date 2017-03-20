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
			ExtractSequenceId IN ( 
					SELECT 
						MAX(ExtractSequenceId) AS ExtractSequenceId 
					FROM 
						dbo.XtOdsIssuer 
					GROUP BY 
						Gid 
			)  
 


GO
