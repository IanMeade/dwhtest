SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================   
-- Author:		Ian Meade   
-- Create date: 20/2/2017   
-- Description:	Get XT Interface changes   
-- =============================================   
CREATE PROCEDURE [dbo].[XtAssembleXtInterfaceEquityEtfUpdate]   
	@SPECIAL_ISIN VARCHAR(12)
AS   
BEGIN   
	-- SET NOCOUNT ON added to prevent extra result sets from   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
	TRUNCATE TABLE dbo.XtOdsInstrumentEquityEtfUpdate   
    
	/* EMERGENCY FIX - 12/6/2017 - MAKE INVALID TotalSharesInIssue 0 */
	/* NOT NEEDED IN PRODUCTION */
	/* START */
	UPDATE
		[dbo].[XtOdsShare]
	SET
		TotalSharesInIssue = 0
	WHERE
		ISNUMERIC(TotalSharesInIssue) = 0
	/*	END */

	/* ASSEMBLE FULL INSTRUMENT EQUITY/ETF DETAILS FOR XT UPDATES IN CURRENT SET OF XT CHANGES */   
   
	;
	WITH XtShare AS (
			SELECT
				BS.Gid AS InstrumentGlobalID,
				DWH.InstrumentID DwhInstrumentID,
				COALESCE(BS.CompanyGid, DWH.CompanyGlobalID) AS CompanyGID,
				COALESCE(BC.IssuerGid, DWH.IssuerGlobalID) AS IssuerGID
			FROM
					BestShare BS
				LEFT OUTER JOIN
					DwhDimInstrumentEquityEtf DWH
				ON BS.Gid = DWH.InstrumentGlobalID 
				AND DWH.CurrentRowYN = 'Y'
				LEFT OUTER JOIN
					BestCompany BC 
				ON BS.CompanyGid = BC.Gid
				LEFT OUTER JOIN
					BestIssuer BI
				ON BC.IssuerGid = BI.Gid
		),
		XtCompany AS (
			SELECT
				DWH.InstrumentGlobalID,
				DWH.InstrumentID AS DwhInstrumentID,
				DWH.CompanyGlobalID AS CompanyGID,
				COALESCE(BC.IssuerGid, DWH.IssuerGlobalID) AS IssuerGID
			FROM
					BestCompany BC 
				INNER JOIN
					DwhDimInstrumentEquityEtf DWH
				ON BC.Gid = DWH.CompanyGlobalID
				AND DWH.CurrentRowYN = 'Y'
				LEFT OUTER JOIN
					BestIssuer BI
				ON BC.IssuerGid = BI.Gid
			WHERE
				DWH.InstrumentGlobalID NOT IN ( SELECT InstrumentGlobalID FROM XtShare )
			),
		XtIssuer AS (
				SELECT
					DWH.InstrumentGlobalID,
					DWH.InstrumentID DwhInstrumentID,
					DWH.CompanyGlobalID AS CompanyGID,
					DWH.IssuerGlobalID AS IssuerGID
				FROM
						BestIssuer BI
					INNER JOIN
						DwhDimInstrumentEquityEtf DWH
					ON BI.Gid = DWH.IssuerGlobalID
					AND DWH.CurrentRowYN = 'Y'
				WHERE
					DWH.InstrumentGlobalID NOT IN ( SELECT InstrumentGlobalID FROM XtShare )
				AND
					DWH.InstrumentGlobalID NOT IN ( SELECT InstrumentGlobalID FROM XtCompany )
			),
		XtBased AS (
				SELECT
					InstrumentGlobalID,
					DwhInstrumentID,
					CompanyGID,
					IssuerGID
				FROM
					XtShare 
				UNION
				SELECT
					InstrumentGlobalID,
					DwhInstrumentID,
					CompanyGID,
					IssuerGID
				FROM
					XtCompany
				UNION
				SELECT
					InstrumentGlobalID,
					DwhInstrumentID,
					CompanyGID,
					IssuerGID
				FROM
					XtIssuer 
			)
		SELECT
			1 AS SRC,  
			InstrumentGlobalID AS SHARE_GID,  
			CompanyGID AS COMPANY_GID,  
			IssuerGID AS ISSUER_GID,
			DwhInstrumentID 
		INTO
			#KEYS
		FROM
			XtBased
		UNION
		/* IN DHW - NO EQUITY IN XT_ODS */
		SELECT
			2 AS SRC,
			DWH.InstrumentGlobalID AS SHARE_GID,  
			DWH.CompanyGlobalID,
			COALESCE(DWH.IssuerGlobalID, DWH.IssuerGlobalID) AS IssuerGID,
			DWH.InstrumentID DwhInstrumentID
		FROM
				DwhDimInstrumentEquityEtf DWH
			LEFT OUTER JOIN
				BestCompany BC 
			ON DWH.CompanyGlobalID = BC.Gid
			LEFT OUTER JOIN
				BestIssuer BI
			ON DWH.IssuerGlobalID = BI.Gid
		WHERE
			DWH.CurrentRowYN = 'Y'
		AND
			DWH.InstrumentGlobalID NOT IN (
						SELECT 
							InstrumentGlobalID
						FROM
							XtBased
				)
		AND
			(
				/* FREELOAT HAS CHANGED */
				DWH.ISIN IN (
						SELECT
							E.ISIN
						FROM
								dbo.DwhDimInstrumentEquityEtfExtra E
							INNER JOIN
								dbo.MdmInstrumentFreeFloat F
							ON E.ISIN = F.ISIN
						WHERE
								E.ISEQOverallFreeFloat != F.ISEQOverallFreeFloat
							OR 
								E.ISEQ20Freefloat != F.ISEQ20Freefloat
						)
			OR
				/* PROCESS SPECIAL PASSED IN ISIN -> WISDOM TREE */
				DWH.ISIN = @SPECIAL_ISIN 
			)	



	/* BEST VERSION OF NON-XT DETAILS */
	SELECT
		COMPANY_GID,
		MAX(InstrumentID) AS InstrumentID
	INTO
		#DWH_COMPANIES
	FROM
			#KEYS K
		INNER JOIN
			DwhDimInstrumentEquityEtf DWH

		ON K.COMPANY_GID = DWH.CompanyGlobalID 
	WHERE
		COMPANY_GID NOT IN ( SELECT GID FROM BestCompany )
	AND
		COMPANY_GID <> ''
	GROUP BY
		COMPANY_GID

	SELECT
		ISSUER_GID,
		MAX(InstrumentID) AS InstrumentID
	INTO
		#DWH_ISSUERS
	FROM
			#KEYS K
		INNER JOIN
			DwhDimInstrumentEquityEtf DWH
		ON K.ISSUER_GID = DWH.IssuerGlobalID
	WHERE
		ISSUER_GID NOT IN ( SELECT GID FROM BestIssuer )
	AND
		ISSUER_GID <> ''
	GROUP BY
		ISSUER_GID

	INSERT INTO   
			dbo.XtOdsInstrumentEquityEtfUpdate   
		SELECT  
			/* This field should never be null */   
			COALESCE( SHARE.GID, D1.InstrumentGlobalID ) AS InstrumentGlobalID,   
			COALESCE( SHARE.Name, D1.InstrumentName ) AS InstrumentName,   
			COALESCE( SHARE.Asset_Type, D1.InstrumentType ) AS InstrumentType,   
			COALESCE( SHARE.SecurityType, D1.SecurityType, '' ) AS SecurityType,   
			COALESCE( SHARE.ISIN, D1.ISIN ) AS ISIN,   
			/* DO IN PIPE / SOMEWHERE ELSE */   
			/*			InstrumentDomesticYN	*/  
			COALESCE( SHARE.SEDOL, D1.SEDOL ) AS SEDOL,   
			COALESCE( SHARE.ListingStatus, D1.InstrumentStatusName ) AS InstrumentStatusName,   
			COALESCE( SHARE.InstrumentStatusDate, D1.InstrumentStatusDate ) AS InstrumentStatusDate,   
			COALESCE( SHARE.ListingDate, D1.InstrumentListedDate ) AS InstrumentListedDate, 		  
			COALESCE( SHARE.TradingSysInstrumentName, D1.TradingSysInstrumentName ) AS TradingSysInstrumentName,   
			COALESCE( SHARE.CompanyGID, D1.CompanyGlobalID ) AS CompanyGlobalID,   
			SHARE.MarketType AS MarketName,   
			D1.MarketCode, 
			COALESCE( SHARE.WKN, D1.WKN ) AS	WKN,   
			COALESCE( SHARE.MNEM, D1.MNEM ) AS MNEM,  
			COALESCE( SHARE.SmfName, D1.InstrumentSedolMasterFileName ) AS InstrumentSedolMasterFileName,   
			COALESCE( ISSUER.SmfName, D3.IssuerSedolMasterFileName, D2.IssuerSedolMasterFileName, D1.IssuerSedolMasterFileName ) AS IssuerSedolMasterFileName,   
			IIF(SHARE.IteqIndexFlag IS NOT NULL, IIF(SHARE.IteqIndexFlag = 1,'Y', 'N'), D1.ITEQIndexYN ) AS ITEQIndexYN,   
			IIF(SHARE.ISEQ20IndexFlag IS NOT NULL, IIF(SHARE.ISEQ20IndexFlag = 1,'Y', 'N'), D1.ISEQ20IndexYN ) AS ISEQ20IndexYN,   
			IIF(SHARE.ESMIndexFlag IS NOT NULL, IIF(SHARE.ESMIndexFlag = 1,'Y', 'N'), D1.ESMIndexYN ) AS ESMIndexYN,   
			/* WILL COME FROM COROPORATE ACTIONS */  
			COALESCE(SHARE.ExDividendDate, D1.LastEXDivDate) AS LastEXDivDate,  
			IIF(SHARE.GID IS NOT NULL, IIF(SHARE.GeneralFinancialFlag = 0, 'Y', 'N' ), D1.GeneralIndexYN ) AS GeneralIndexYN,  
			IIF(SHARE.GID IS NOT NULL, IIF(SHARE.GeneralFinancialFlag = 1, 'Y', 'N' ), D1.FinancialIndexYN ) AS FinancialIndexYN,  
			IIF(SHARE.GID IS NOT NULL, IIF(SHARE.GeneralFinancialFlag IS NOT NULL, 'Y', 'N' ), D1.OverallIndexYN ) AS OverallIndexYN,  
			IIF(SHARE.SmallCap IS NOT NULL,IIF(SHARE.SmallCap = 1, 'Y', 'N' ), D1.SmallCapIndexYN ) AS SmallCapIndexYN,   
			COALESCE( SHARE.PrimaryMarket, D1.PrimaryMarket ) AS PrimaryMarket,   
			COALESCE( SHARE.DenominationCurrency, D1.CurrencyISOCode ) AS CurrencyISOCode,   
			COALESCE( SHARE.UnitOfQuotation, D1.UnitOfQuotation ) AS UnitOfQuotation,   
			COALESCE( SHARE.QuotationCurrency, D1.QuotationCurrencyISOCode ) AS QuotationCurrencyISOCode,   
			D1.ISEQ20Freefloat AS ISEQ20Freefloat,   
			D1.ISEQOverallFreeFloat AS ISEQOverallFreeFloat,   
			COALESCE( SHARE.CFIName, D1.CFIName ) AS CFIName,   
			COALESCE( SHARE.CFICode, D1.CFICode ) AS CFICode,  
			COALESCE( SHARE.TotalSharesInIssue, D1.TotalSharesInIssue ) AS TotalSharesInIssue,    
			COALESCE( COMPANY.ListingDate, D2.CompanyListedDate, D1.CompanyListedDate ) AS CompanyListedDate,   
			COALESCE( COMPANY.ApprovalDate, D2.CompanyApprovalDate, D1.CompanyApprovalDate ) AS CompanyApprovalDate,  
			COALESCE( COMPANY.ApprovalType, D2.CompanyApprovalType, D1.CompanyApprovalType ) AS CompanyApprovalType,   
			COALESCE( COMPANY.ListingStatus, D2.CompanyStatusName, D1.CompanyStatusName ) AS CompanyStatusName,   
			COALESCE( SHARE.Note, D1.Note ) AS Note,   
 			IIF(COMPANY.TDFlag IS NOT NULL, IIF(COMPANY.TDFlag = 1, 'Y','N') , COALESCE(D2.TransparencyDirectiveYN, D1.TransparencyDirectiveYN) ) AS TransparencyDirectiveYN,   
			IIF(COMPANY.MADFlag IS NOT NULL, IIF(COMPANY.MADFlag =1, 'Y','N'), COALESCE(D2.MarketAbuseDirectiveYN, D1.MarketAbuseDirectiveYN) ) AS MarketAbuseDirectiveYN,   
			IIF(COMPANY.PDFlag IS NOT NULL, IIF(COMPANY.PDFlag = 1, 'Y','N'), COALESCE(D2.ProspectusDirectiveYN, D1.ProspectusDirectiveYN) ) AS ProspectusDirectiveYN,   
			COALESCE( COMPANY.Sector, D2.PrimaryBusinessSector, D1.PrimaryBusinessSector  ) AS PrimaryBusinessSector,   
			COALESCE( COMPANY.SubFocus1, D2.SubBusinessSector1, D1.SubBusinessSector1 ) AS SubBusinessSector1,   
			COALESCE( COMPANY.SubFocus2, D2.SubBusinessSector2, D1.SubBusinessSector2 ) AS SubBusinessSector2,   
			COALESCE( COMPANY.SubFocus3, D2.SubBusinessSector3, D1.SubBusinessSector3 ) AS SubBusinessSector3,   
			COALESCE( COMPANY.SubFocus4, D2.SubBusinessSector4, D1.SubBusinessSector4 ) AS SubBusinessSector4,   
			COALESCE( COMPANY.SubFocus5, D2.SubBusinessSector5, D1.SubBusinessSector5 ) AS SubBusinessSector5,   
			COALESCE( COMPANY.IssuerGid, ISSUER.Gid, D2.IssuerGlobalID , D1.IssuerGlobalID ) AS IssuerGlobalID,   
			COALESCE( ISSUER.Name, D3.IssuerName, D2.IssuerName , D1.IssuerName ) AS IssuerName,   
			COALESCE( ISSUER.Domicile, D3.IssuerDomicile, D2.IssuerDomicile, D1.IssuerDomicile ) AS IssuerDomicile,   
			COALESCE( ISSUER.YearEnd, D3.FinancialYearEndDate, D2.FinancialYearEndDate, D1.FinancialYearEndDate ) AS FinancialYearEndDate,   
			COALESCE( ISSUER.DateofIncorporation, D3.IncorporationDate, D2.IncorporationDate, D1.IncorporationDate ) AS IncorporationDate,   
			COALESCE( ISSUER.LegalStructure, D3.LegalStructure, D2.LegalStructure, D1.LegalStructure ) AS LegalStructure,   
			COALESCE( ISSUER.AccountingStandard, D3.AccountingStandard, D2.AccountingStandard, D1.AccountingStandard ) AS AccountingStandard,   
			COALESCE( ISSUER.TD_home_member_country, D3.TransparencyDirectiveHomeMemberCountry, D2.TransparencyDirectiveHomeMemberCountry, D1.TransparencyDirectiveHomeMemberCountry ) AS TransparencyDirectiveHomeMemberCountry,   
			COALESCE( ISSUER.Pd_Home_Member_Country, D3.ProspectusDirectiveHomeMemberCountry, D2.ProspectusDirectiveHomeMemberCountry, D1.ProspectusDirectiveHomeMemberCountry ) AS ProspectusDirectiveHomeMemberCountry,   
			IIF( ISSUER.DomicileDomesticFlag IS NOT NULL, IIF(ISSUER.DomicileDomesticFlag = 1,'Y', 'N'), COALESCE(D3.IssuerDomicileDomesticYN, D2.IssuerDomicileDomesticYN, D1.IssuerDomicileDomesticYN ) ) AS IssuerDomicileDomesticYN,   
			COALESCE( CAST(ISSUER.FeeCode AS CHAR(4)), D3.FeeCodeName, D2.FeeCodeName, D1.FeeCodeName ) AS FeeCodeName,
			COALESCE( IIF(Share.ExSpecial=0,'N','Y'), D1.ExSpecial) AS ExSpecial,
			COALESCE( IIF(Share.ExCapitalisation=0,'N','Y'), D1.ExCapitalisation) AS ExCapitalisation,
			COALESCE( IIF(Share.ExRights=0,'N','Y'), D1.ExRights) AS ExRights,
			COALESCE( IIF(Share.ExEntitlement=0,'N','Y'), D1.ExEntitlement) AS ExEntitlement,
			COALESCE( IIF(Share.ExDividend=0,'N','Y'), D1.ExDividend) AS ExDividend,
			COALESCE( Share.SecurityQualifier, D1.SecurityQualifier) AS SecurityQualifier

	FROM  
			#Keys K  
		LEFT OUTER JOIN  
			[dbo].[BestShare] SHARE   
		ON   
			K.SHARE_GID = SHARE.GID  
		LEFT OUTER JOIN  
			[dbo].[BestCompany] COMPANY   
		ON   
			K.COMPANY_GID = COMPANY.GID   
		LEFT OUTER JOIN  
			[dbo].[BestIssuer] ISSUER   
		ON   
			K.ISSUER_GID = ISSUER.Gid   
		LEFT OUTER JOIN  
			dbo.DwhDimInstrumentEquityEtf D1   
		ON  
			K.DwhInstrumentID  = D1.InstrumentID  

		LEFT OUTER JOIN
			#DWH_COMPANIES J2
		ON K.COMPANY_GID = J2.COMPANY_GID

		LEFT OUTER JOIN
			DwhDimInstrumentEquityEtf D2
		ON J2.InstrumentID = D2.InstrumentID
		LEFT OUTER JOIN
			#DWH_ISSUERS J3
		ON K.ISSUER_GID = J3.ISSUER_GID
		LEFT OUTER JOIN
			DwhDimInstrumentEquityEtf D3
		ON J3.InstrumentID = D3.InstrumentID


	DROP TABLE #KEYS  
	DROP TABLE #DWH_COMPANIES
	DROP TABLE #DWH_ISSUERS
 
   
	/* MAKE EVERYTHING THAT IS NOT AN ETF AN EQUITY */ 
	/* COULD CAUSE ISSUES IF EquityStage IS POPULATED WITH NON-SHARE BASED INSTRUMENTS */ 
	UPDATE 
		dbo.XtOdsInstrumentEquityEtfUpdate   
	SET 
		InstrumentType = 'Equity' 
	WHERE 
		InstrumentType NOT IN ( 'Equity', 'ETF' ) 
 
  
END   
GO
