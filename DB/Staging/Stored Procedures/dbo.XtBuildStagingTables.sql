SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 30/6/2017
-- Description:	Prepare XT staging tables
-- =============================================
CREATE PROCEDURE [dbo].[XtBuildStagingTables]
	@EquityStageID BIGINT,
	@IssuerStageID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	/* Get equities to upate */
	SELECT
		GID
	INTO
		#EquityGID
	FROM
		dbo.XtRawEquityStage
	WHERE
		Asset_Type = 'Share'
	AND
		ExtractSequenceID > @EquityStageID
	UNION
	SELECT
		/* GET ANY COMPANY IMPACTED BY EQUITY CHANGES */
		GID
	FROM
		dbo.XtRawEquityStage
	WHERE
		Asset_Type = 'Share'
	AND
		CompanyGID IN (
			SELECT
				GID
			FROM
				dbo.XtRawEquityStage
			WHERE
				Asset_Type = 'Company'
			AND
				ExtractSequenceID > @EquityStageID
			)
	UNION
	SELECT
		/* GET ANY COMPANY IMPACTED BY EQUITY CHANGES */
		GID
	FROM
		dbo.XtRawEquityStage
	WHERE
		Asset_Type = 'Share'
	AND
		CompanyGID IN (
			SELECT
				GID
			FROM
				dbo.XtRawEquityStage
			WHERE
				Asset_Type = 'Company'
			AND
				IssuerGID IN (
					SELECT
						GID
					FROM
						dbo.XtRawIssuerStage
					WHERE
						ExtractSequenceID > @IssuerStageID
					)
				)

	/* Get companies to update */
	SELECT
		GID
	INTO
		#CompanyGID
	FROM
		dbo.XtRawEquityStage
	WHERE
		Asset_Type = 'Company'
	AND
		ExtractSequenceID > @EquityStageID
	UNION
	SELECT
		/* GET ANY COMPANY IMPACTED BY EQUITY CHANGES */
		GID
	FROM
		dbo.XtRawEquityStage
	WHERE
		Asset_Type = 'Company'
	AND
		GID IN (
			SELECT
				CompanyGID 
			FROM
				dbo.XtRawEquityStage
			WHERE
				Asset_Type = 'Share'
			AND
				ExtractSequenceID > @EquityStageID
			)
	UNION
	SELECT
		GID
	FROM
		dbo.XtRawEquityStage
	WHERE
		Asset_Type = 'Company'
	AND
		IssuerGID IN (
			SELECT
				GID
			FROM
				dbo.XtRawIssuerStage
			WHERE
				ExtractSequenceID > @IssuerStageID
			)

	/* get issuers to update */
	SELECT
		GID
	INTO
		#IssuerGID
	FROM
		dbo.XtRawIssuerStage
	WHERE
		ExtractSequenceID > @IssuerStageID
	UNION
	SELECT
		GID
	FROM
		dbo.XtRawIssuerStage
	WHERE
		GID IN (
			SELECT
				IssuerGID
			FROM
				dbo.XtRawEquityStage
			WHERE
				Asset_Type = 'Company'
			AND
				ExtractSequenceID > @EquityStageID
			)
	UNION
	SELECT
		/* ISSER WHERE THE SHARE HAS CHANGED */
		GID
	FROM
		dbo.XtRawIssuerStage
	WHERE
		GID IN (
			SELECT
				IssuerGID
			FROM
				dbo.XtRawEquityStage
			WHERE
				Asset_Type = 'Company'
			AND
				GID IN (
					SELECT
						CompanyGID 
					FROM
						dbo.XtRawEquityStage
					WHERE
						Asset_Type = 'Share'
					AND
						ExtractSequenceID > @EquityStageID
					)
			)

	/* Update tables... */
	TRUNCATE TABLE dbo.XtOdsShare
	TRUNCATE TABLE dbo.XtOdsCompany
	TRUNCATE TABLE dbo.XtOdsIssuer

	INSERT INTO dbo.XtOdsShare
		SELECT
			XT.*
		FROM
				dbo.XtRawEquityStage XT
			INNER JOIN
				#EquityGID GID
			ON XT.GID = GID.GID
		ORDER BY
			XT.ExtractSequenceID

	INSERT INTO dbo.XtOdsCompany
		SELECT
			Asset_Type, 
			XT.Name, 
			XT.DelistedDefunct, 
			XT.ListingDate, 
			XT.ListingStatus, 
			XT.InstrumentStatusDate, 
			XT.InstrumentStatusCreatedDatetime, 
			XT.Sector, 
			XT.Subfocus1, 
			XT.Subfocus2, 
			XT.Subfocus3, 
			XT.Subfocus4, 
			XT.Subfocus5, 
			XT.ApprovalType, 
			XT.ApprovalDate, 
			XT.TdFlag, 
			XT.MadFlag, 
			XT.PdFlag, 
			XT.Gid, 
			XT.IssuerGid, 
			XT.Isin, 
			XT.Sedol, 
			XT.MarketType, 
			XT.SecurityType, 
			XT.DenominationCurrency, 
			XT.IteqIndexFlag, 
			XT.GeneralFinancialFlag, 
			XT.SmallCap, 
			XT.Note, 
			XT.PrimaryMarket, 
			XT.QuotationCurrency, 
			XT.UnitOfQuotation, 
			XT.Wkn, 
			XT.Mnem, 
			XT.CfiName, 
			XT.CfiCode, 
			XT.SmfName, 
			XT.TotalSharesInIssue, 
			XT.InstrumentActualListedDate, 
			XT.TradingSysInstrumentName, 
			XT.CompanyGid, 
			XT.ExtractSequenceId, 
			XT.ExtractDate, 
			XT.MessageId, 
			XT.ISEQOverallFreeFloat, 
			XT.ISEQ20IndexFlag, 
			XT.ESMIndexFlag
		FROM
				dbo.XtRawEquityStage XT
			INNER JOIN
				#CompanyGID GID
			ON XT.GID = GID.GID
		ORDER BY
			XT.ExtractSequenceID


	INSERT INTO dbo.XtOdsIssuer
		SELECT
			XT.*
		FROM
				dbo.XtRawIssuerStage XT
			INNER JOIN
				#IssuerGID GID
			ON XT.GID = GID.GID
		ORDER BY
			XT.ExtractSequenceID

	/* Clean up */
	DROP TABLE #EquityGID
	DROP TABLE #CompanyGID
	DROP TABLE #IssuerGID





END
GO
