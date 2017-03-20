SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 20/2/2017 
-- Description:	Get XT Interface changes 
-- ============================================= 
CREATE PROCEDURE [dbo].[AssembleXtInterfaceEquityEtfUpdate] 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	TRUNCATE TABLE dbo.XtOdsInstrumentEquityEtfUpdate 
 
	/* ASSEMBLE FULL INSTRUMENT EQUITY/ETF DETAILS FOR XT UPDATES IN CURRENT SET OF XT CHANGES */ 
 

	;WITH
		EquitySide AS (
				/* Best copy of Equity side of things */
				SELECT
					'EQUITY' AS SRC,
					SHARE.GID AS SHARE_GID,
					COMPANY.GID AS COMPANY_GID,
					ISSUER.GID AS ISSUER_GID,
					DwhShare.InstrumentID AS DwhInstrumentID
				FROM
						[dbo].[BestShare] SHARE 
					LEFT OUTER JOIN 
						[dbo].[BestCompany] COMPANY 
					ON 
						SHARE.CompanyGID = COMPANY.GID 
					LEFT OUTER JOIN 
						[dbo].[BestIssuer] ISSUER 
					ON COMPANY.IssuerGid = ISSUER.Gid 
					LEFT OUTER JOIN 
						dbo.DwhDimInstrumentEquityEtf DwhShare 
					ON  
						SHARE.Gid = DwhShare.InstrumentGlobalID 
					AND 
						DwhShare.CurrentRowYN = 'Y' 
			),
		CompanySide as (
				SELECT
					'COMPANY' AS SRC,
					COMPANY.GID AS COMPANY_GID,
					ISSUER.GID AS ISSUER_GID,
					E.InstrumentID AS DwhInstrumentID	
				FROM
						[dbo].[BestCompany] COMPANY 
					INNER JOIN
						dbo.DwhDimInstrumentEquityEtf E
					ON COMPANY.Gid = E.CompanyGlobalID
					AND 
						E.CurrentRowYN = 'Y' 
					LEFT OUTER JOIN 
						[dbo].[BestIssuer] ISSUER 
					ON COMPANY.IssuerGid = ISSUER.Gid 
				WHERE
					E.InstrumentID NOT IN (
							SELECT
								DwhInstrumentID
							FROM
								EquitySide
						)
			),
		IssuerSide as (
				SELECT
					'ISSUER' AS SRC,
					ISSUER.GID AS ISSUER_GID,
					E.InstrumentID AS DwhInstrumentID	
				FROM
						dbo.BestIssuer ISSUER 
					LEFT OUTER JOIN 
						dbo.DwhDimInstrumentEquityEtf E
					ON ISSUER.Gid = E.IssuerGlobalID
					AND 
						E.CurrentRowYN = 'Y' 
				WHERE
					E.InstrumentID NOT IN (
							SELECT
								DwhInstrumentID
							FROM
								EquitySide
						)
			)
	SELECT
		SRC,
		SHARE_GID,
		COMPANY_GID,
		ISSUER_GID,
		DwhInstrumentID
	INTO 
		#KEYS
	FROM
		EquitySide
	UNION 
	SELECT
		SRC,
		NULL AS SHARE_GID,
		COMPANY_GID,
		ISSUER_GID,
		DwhInstrumentID
	FROM
		CompanySide
	UNION
	SELECT
		SRC,
		NULL AS SHARE_GID,
		NULL AS COMPANY_GID,
		ISSUER_GID,
		DwhInstrumentID
	FROM
		IssuerSide




	INSERT INTO 
			dbo.XtOdsInstrumentEquityEtfUpdate 
		SELECT
			/* This field should never be null */ 
			COALESCE( SHARE.GID, DwhShare.InstrumentGlobalID ) AS InstrumentGlobalID, 
			COALESCE( SHARE.Name, DwhShare.InstrumentName ) AS InstrumentName, 
			COALESCE( SHARE.Asset_Type, DwhShare.InstrumentType ) AS InstrumentType, 
			COALESCE( SHARE.SecurityType, DwhShare.SecurityType, '' ) AS SecurityType, 
			COALESCE( SHARE.ISIN, DwhShare.ISIN ) AS ISIN, 
			/* DO IN PIPE / SOMEWHERE ELSE */ 
			/*			InstrumentDomesticYN	*/
			COALESCE( SHARE.SEDOL, DwhShare.SEDOL ) AS SEDOL, 
			COALESCE( SHARE.ListingStatus, DwhShare.InstrumentStatusName ) AS InstrumentStatusName, 
			COALESCE( SHARE.InstrumentStatusDate, DwhShare.InstrumentStatusDate ) AS InstrumentStatusDate, 
			COALESCE( SHARE.ListingDate, DwhShare.InstrumentListedDate ) AS InstrumentListedDate, 		
			COALESCE( SHARE.TradingSysInstrumentName, DwhShare.TradingSysInstrumentName ) AS TradingSysInstrumentName, 
			COALESCE( SHARE.CompanyGID, DwhShare.CompanyGlobalID ) AS CompanyGlobalID, 
			COALESCE( SHARE.MarketType, DwhShare.MarketName ) AS MarketName, 
			COALESCE( SHARE.WKN, DwhShare.WKN ) AS	WKN, 
			COALESCE( SHARE.MNEM, DwhShare.MNEM ) AS MNEM,
			COALESCE( SHARE.SmfName, DwhShare.InstrumentSedolMasterFileName ) AS InstrumentSedolMasterFileName, 
			COALESCE( ISSUER.SmfName, DwhShare.IssuerSedolMasterFileName ) AS IssuerSedolMasterFileName, 
			IIF(SHARE.IteqIndexFlag IS NOT NULL, IIF(SHARE.IteqIndexFlag = 1,'Y', 'N'), DwhShare.ITEQIndexYN ) AS ITEQIndexYN, 
			IIF(SHARE.ISEQ20IndexFlag IS NOT NULL, IIF(SHARE.ISEQ20IndexFlag = 1,'Y', 'N'), DwhShare.ISEQ20IndexYN ) AS ISEQ20IndexYN, 
			IIF(SHARE.ESMIndexFlag IS NOT NULL, IIF(SHARE.ESMIndexFlag = 1,'Y', 'N'), DwhShare.ESMIndexYN ) AS ESMIndexYN, 
			/* WILL COME FROM COROPORATE ACTIONS */
			DwhShare.LastEXDivDate,
			IIF(SHARE.GID IS NOT NULL, IIF(SHARE.GeneralFinancialFlag = 0, 'Y', 'N' ), DwhShare.GeneralIndexYN ) AS GeneralIndexYN,
			IIF(SHARE.GID IS NOT NULL, IIF(SHARE.GeneralFinancialFlag = 1, 'Y', 'N' ), DwhShare.FinancialIndexYN ) AS FinancialIndexYN,
			IIF(SHARE.GID IS NOT NULL, IIF(SHARE.GeneralFinancialFlag IS NOT NULL, 'Y', 'N' ), DwhShare.OverallIndexYN ) AS OverallIndexYN,
			IIF(SHARE.SmallCap IS NOT NULL,IIF(SHARE.SmallCap = 1, 'Y', 'N' ), DwhShare.SmallCapIndexYN ) AS SmallCapIndexYN, 
			COALESCE( SHARE.PrimaryMarket, DwhShare.PrimaryMarket ) AS PrimaryMarket, 
			COALESCE( SHARE.IssuedDate, DwhShare.IssuedDate ) AS IssuedDate, 
			COALESCE( SHARE.DenominationCurrency, DwhShare.CurrencyISOCode ) AS CurrencyISOCode, 
			COALESCE( SHARE.UnitOfQuotation, DwhShare.UnitOfQuotation ) AS UnitOfQuotation, 
			COALESCE( SHARE.QuotationCurrency, DwhShare.QuotationCurrencyISOCode ) AS QuotationCurrencyISOCode, 
			COALESCE( SHARE.ISEQOverallFreeFloat, DwhShare.ISEQ20Freefloat ) AS ISEQ20Freefloat, 
			COALESCE( SHARE.ISEQOverallFreeFloat, DwhShare.ISEQOverallFreeFloat ) AS ISEQOverallFreeFloat, 
			COALESCE( SHARE.CFIName, DwhShare.CFIName ) AS CFIName, 
			COALESCE( SHARE.CFICode, DwhShare.CFICode ) AS CFICode,
			COALESCE( SHARE.TotalSharesInIssue, DwhShare.TotalSharesInIssue ) AS TotalSharesInIssue,  
			COALESCE( COMPANY.ListingDate, DwhShare.CompanyListedDate ) AS CompanyListedDate, 
			COALESCE( COMPANY.ApprovalDate, DwhShare.CompanyApprovalDate ) AS CompanyApprovalDate,
			COALESCE( COMPANY.ApprovalType, DwhShare.CompanyApprovalType ) AS CompanyApprovalType, 
			COALESCE( COMPANY.ListingStatus, DwhShare.CompanyStatusName ) AS CompanyStatusName, 
			COALESCE( SHARE.Note , DwhShare.Note ) AS Note, 
 			IIF(COMPANY.TDFlag IS NOT NULL, IIF(COMPANY.TDFlag = 1, 'Y','N') , DwhShare.TransparencyDirectiveYN ) AS TransparencyDirectiveYN, 
			IIF(COMPANY.MADFlag IS NOT NULL, IIF(COMPANY.MADFlag =1, 'Y','N'), DwhShare.MarketAbuseDirectiveYN ) AS MarketAbuseDirectiveYN, 
			IIF(COMPANY.PDFlag IS NOT NULL, IIF(COMPANY.PDFlag = 1, 'Y','N'), DwhShare.ProspectusDirectiveYN ) AS ProspectusDirectiveYN, 
			COALESCE( COMPANY.Sector, DwhShare.PrimaryBusinessSector ) AS PrimaryBusinessSector, 
			COALESCE( COMPANY.SubFocus1, DwhShare.SubBusinessSector1 ) AS SubBusinessSector1, 
			COALESCE( COMPANY.SubFocus2, DwhShare.SubBusinessSector2 ) AS SubBusinessSector2, 
			COALESCE( COMPANY.SubFocus3, DwhShare.SubBusinessSector3 ) AS SubBusinessSector3, 
			COALESCE( COMPANY.SubFocus4, DwhShare.SubBusinessSector4 ) AS SubBusinessSector4, 
			COALESCE( COMPANY.SubFocus5, DwhShare.SubBusinessSector5 ) AS SubBusinessSector5, 
			COALESCE( COMPANY.IssuerGid, DwhShare.IssuerGlobalID ) AS IssuerGlobalID, 
			COALESCE( ISSUER.Name, DwhShare.IssuerName ) AS IssuerName, 
			COALESCE( ISSUER.Domicile, DwhShare.IssuerDomicile ) AS IssuerDomicile, 
			COALESCE( ISSUER.YearEnd, DwhShare.FinancialYearEndDate ) AS FinancialYearEndDate, 
			COALESCE( ISSUER.DateofIncorporation, DwhShare.IncorporationDate ) AS IncorporationDate, 
			COALESCE( ISSUER.LegalStructure, DwhShare.LegalStructure ) AS LegalStructure, 
			COALESCE( ISSUER.AccountingStandard, DwhShare.AccountingStandard ) AS AccountingStandard, 
			COALESCE( ISSUER.TD_home_member_country, DwhShare.TransparencyDirectiveHomeMemberCountry ) AS TransparencyDirectiveHomeMemberCountry, 
			COALESCE( ISSUER.Pd_Home_Member_Country, DwhShare.ProspectusDirectiveHomeMemberCountry ) AS ProspectusDirectiveHomeMemberCountry, 
			IIF( ISSUER.DomicileDomesticFlag IS NOT NULL, IIF(ISSUER.DomicileDomesticFlag = 1,'Y', 'N'), DwhShare.IssuerDomicileDomesticYN) AS IssuerDomicileDomesticYN, 
			COALESCE( CAST(ISSUER.FeeCode AS CHAR(4)), DwhShare.FeeCodeName ) AS FeeCodeName 
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
			dbo.DwhDimInstrumentEquityEtf DwhShare 
		ON
			K.DwhInstrumentID  = DwhShare.InstrumentID
/*
	WHERE
		COALESCE( SHARE.GID, DwhShare.InstrumentGlobalID, DwhShare.InstrumentGlobalID, DwhShare.InstrumentGlobalID ) IS NOT NULL
*/
	DROP TABLE #KEYS

END 
GO
