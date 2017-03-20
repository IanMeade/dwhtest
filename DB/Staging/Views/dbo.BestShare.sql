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
			ExtractSequenceId IN ( 
					SELECT 
						MAX(ExtractSequenceId) AS ExtractSequenceId 
					FROM 
						dbo.XtOdsShare 
					GROUP BY 
						Gid 
			)  


GO
