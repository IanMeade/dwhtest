SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ETL].[bestCompanyDetails] AS
	/* Gets the most recenty copy of company detials in the DHW
		Used if the XT data set has no current comnpany 
	*/
WITH
	Company AS (
		/* UNION COMPANY FIELDS FROM BOTH DATA SETS */
		SELECT
			*
		FROM
			DWH.DimInstrumentEquity
		UNION ALL
		SELECT
			*
		FROM
			DWH.DimInstrumentEtf
	),
	MostRecentCompany AS (
		SELECT
			CompanyGlobalID,
			MAX(StartDate) AS StartDate,
			MAX(InstrumentID) AS InstrumentID
		FROM
			[DWH].[DimInstrumentEquity]
		GROUP BY
			CompanyGlobalID
	)
	SELECT		
		*
	FROM
		Company C
	WHERE
		EXISTS (
				SELECT	
					*
				FROM
					MostRecentCompany MRC
				WHERE
					C.InstrumentID = MRC.InstrumentID
			)
GO
