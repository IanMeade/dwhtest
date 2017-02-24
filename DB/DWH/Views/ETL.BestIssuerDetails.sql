SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ETL].[BestIssuerDetails] AS
	/* Gets the most recenty copy of issuer detials in the DHW
		Used if the XT data set has no current issuer
	*/
WITH
	MostRecentIssuer AS (
		SELECT
			IssuerGlobalID,
			MAX(InstrumentID) AS InstrumentID
		FROM
			DWH.DimInstrument
		GROUP BY
			IssuerGlobalID

	)
	SELECT		
		*
	FROM
		DWH.DimInstrument C
	WHERE
		EXISTS (
				SELECT	
					*
				FROM
					MostRecentIssuer MRC
				WHERE
					C.InstrumentID = MRC.InstrumentID
			)
GO
