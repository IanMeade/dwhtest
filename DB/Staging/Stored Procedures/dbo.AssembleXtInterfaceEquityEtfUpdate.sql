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

	/* ASSEMBLE FULL INSTRUMENT EQUITY/EFT DETAILS FOR XT UPDATES IN CURRENT SCOPE */

	INSERT INTO
			dbo.XtOdsInstrumentEquityEtfUpdate

		SELECT
			/* This field should never be null */
			SHARE.GID	AS	InstrumentGlobalID,
			COALESCE( SHARE.Name, DwhShare.InstrumentName ) AS InstrumentName,
			COALESCE( SHARE.Asset_Type, DwhShare.InstrumentType ) AS InstrumentType,
			COALESCE( SHARE.SecurityType, DwhShare.SecurityType ) AS SecurityType,
			COALESCE( SHARE.ISIN, DwhShare.ISIN ) AS ISIN,
			COALESCE( SHARE.SEDOL, DwhShare.SEDOL ) AS SEDOL,
			COALESCE( SHARE.ListingStatus, DwhShare.InstrumentStatusName ) AS InstrumentStatusName,
			COALESCE( SHARE.ListingDate, DwhShare.InstrumentStatusDate ) AS InstrumentStatusDate,
			COALESCE( SHARE.TradingSysInstrumentName, DwhShare.TradingSysInstrumentName ) AS TradingSysInstrumentName,
			COALESCE( SHARE.CompanyGID, DwhShare.CompanyGlobalID ) AS CompanyGlobalID,
			COALESCE( SHARE.MarketType, DwhShare.MarketName ) AS MarketName,
			COALESCE( SHARE.WKN, DwhShare.WKN ) AS	WKN,
			COALESCE( SHARE.MNEM, DwhShare.MNEM ) AS MNEM,
	
			'X' AS	GeneralIndexYN,
			CAST('19900101' AS DATE ) AS InstrumentListedDate,
			'X' AS InstrumentSedolMasterFileName,
			'X' AS ISEQ20IndexYN,
			'X' AS IssuerSedolMasterFileName,
			'X' AS ITEQIndexYN,
			'19900101' AS LastEXDivDateID,
			'X' AS OverallIndexYN,
			'X' AS SecurityQualifier,

			COALESCE( SHARE.GeneralFinancialFlag, DwhShare.FinancialIndexYN ) AS FinancialIndexYN,
			COALESCE( SHARE.SmallCap, DwhShare.SmallCapIndexYN ) AS SmallCapIndexYN,

			COALESCE( SHARE.PrimaryMarket, DwhShare.PrimaryMarket ) AS PrimaryMarket,
			COALESCE( SHARE.IssuedDate, DwhShare.IssuedDate ) AS IssuedDate,
			COALESCE( SHARE.DenominationCurrency, DwhShare.CurrencyISOCode ) AS CurrencyISOCode,
			COALESCE( SHARE.UnitOfQuotation, DwhShare.UnitOfQuotation ) AS UnitOfQuotation,
			COALESCE( SHARE.QuotationCurrency, DwhShare.QuotationCurrencyISOCode ) AS QuotationCurrencyISOCode,

			COALESCE( SHARE.FreeFloatAdj, DwhShare.ISEQ20Freefloat ) AS ISEQ20Freefloat,
			COALESCE( CAST(SHARE.IssuedShares AS FLOAT), DwhShare.ISEQOverallFreeFloat ) AS ISEQOverallFreeFloat,
			COALESCE( SHARE.CFIName, DwhShare.CFIName ) AS CFIName,
			COALESCE( SHARE.CFICode, DwhShare.CFICode ) AS CFICode,

			COALESCE( SHARE.TotalSharesInIssue, DwhShare.TotalSharesInIssue ) AS TotalSharesInIssue,

			COALESCE( COMPANY.ListingDate, DwhCompany.CompanyListedDate ) AS CompanyListedDate,
			COALESCE( COMPANY.ApprovalDate, DwhCompany.CompanyApprovalDate ) AS CompanyApprovalDate,
			'NOT MAPPED' AS CompanyApprovalType,
			COALESCE( COMPANY.ListingStatus, DwhShare.CompanyStatusName ) AS CompanyStatusName,
			COALESCE( COMPANY.Note , DwhShare.Note ) AS Note,


			COALESCE( COMPANY.TDFlag, DwhCompany.TransparencyDirectiveYN ) AS TransparencyDirectiveYN,
			COALESCE( COMPANY.MADFlag, DwhCompany.MarketAbuseDirectiveYN ) AS MarketAbuseDirectiveYN,
			COALESCE( COMPANY.PDFlag, DwhCompany.ProspectusDirectiveYN ) AS ProspectusDirectiveYN,
			COALESCE( COMPANY.Sector, DwhCompany. PrimaryBusinessSector) AS PrimaryBusinessSector,
			COALESCE( COMPANY.SubFocus1, DwhCompany.SubBusinessSector1 ) AS SubBusinessSector1,
			COALESCE( COMPANY.SubFocus2, DwhCompany.SubBusinessSector2 ) AS SubBusinessSector2,
			COALESCE( COMPANY.SubFocus3, DwhCompany.SubBusinessSector3 ) AS SubBusinessSector3,
			COALESCE( COMPANY.SubFocus4, DwhCompany.SubBusinessSector4 ) AS SubBusinessSector4,
			COALESCE( COMPANY.SubFocus5, DwhCompany.SubBusinessSector5 ) AS SubBusinessSector5,

			COALESCE( COMPANY.IssuerGid, DwhIssuer.IssuerGlobalID ) AS IssuerGlobalID,
			COALESCE( ISSUER.Name, DwhIssuer.IssuerName ) AS IssuerName,
			COALESCE( ISSUER.Domicile, DwhIssuer.IssuerDomicile ) AS IssuerDomicile,
			COALESCE( ISSUER.YearEnd, DwhIssuer.FinancialYearEndDate ) AS FinancialYearEndDate,
			COALESCE( ISSUER.DateofIncorporation, DwhIssuer.IncorporationDate ) AS IncorporationDate,
			COALESCE( ISSUER.LegalStructure, DwhIssuer.LegalStructure ) AS LegalStructure,
			COALESCE( ISSUER.AccountingStandard, DwhIssuer.AccountingStandard ) AS AccountingStandard,
			COALESCE( ISSUER.TD_home_member_country, DwhIssuer.TransparencyDirectiveHomeMemberCountry ) AS TransparencyDirectiveHomeMemberCountry,
			COALESCE( ISSUER.Pd_Home_Member_Country, DwhIssuer.ProspectusDirectiveHomeMemberCountry ) AS ProspectusDirectiveHomeMemberCountry,
			COALESCE( ISSUER.DomicileDomesticFlag, DwhIssuer.IssuerDomicileDomesticYN ) AS IssuerDomicileDomesticYN,
			COALESCE( CAST(ISSUER.FeeCode AS CHAR(4)), DwhIssuer.FeeCodeName ) AS FeeCodeName

		/*
		INTO
			XtOdsInstrumentEquityEtfUpdate
		*/

		FROM
			/* CURRENT DETAILS FROM XT INTERFACE */
				[dbo].[BestShare] SHARE
			FULL OUTER JOIN
				[dbo].[BestCompany] COMPANY
			ON
				SHARE.CompanyGID = COMPANY.GID
			FULL OUTER JOIN
				[dbo].[BestIssuer] ISSUER
			ON COMPANY.IssuerGid = ISSUER.Gid

			/* NEXT CHOICES FROM DWH FOR COMPANY / ISSUER */
			/* NEEDED FOR UPDATES TO EXISITNG SHARES WHERE THE COMPANY OR ISSUER HAS NOT CHNAGED */
			LEFT OUTER JOIN
				dbo.DwhDimInstrumentEquityEtf DwhShare
			ON 
				SHARE.Gid = DwhShare.InstrumentGlobalID
			AND
				DwhShare.CurrentRowYN = 'Y'

			OUTER APPLY
			(
				SELECT
					TOP 1
					IC.CompanyListedDate,
					IC.CompanyApprovalDate,
					IC.TransparencyDirectiveYN,
					IC.MarketAbuseDirectiveYN,
					IC.ProspectusDirectiveYN,
					IC.PrimaryBusinessSector,
					IC.SubBusinessSector1,
					IC.SubBusinessSector2,
					IC.SubBusinessSector3,
					IC.SubBusinessSector4,
					IC.SubBusinessSector5
				FROM
					dbo.DwhDimInstrumentEquityEtf IC
				WHERE
					ISNULL( SHARE.CompanyGid, DwhShare.CompanyGlobalID ) = IC.CompanyGlobalID
				ORDER BY
					IC.InstrumentID DESC
			) AS DwhCompany

			OUTER APPLY
			(
				SELECT
					TOP 1
					IC.IssuerGlobalID,
					IC.IssuerName,
					IC.IssuerDomicile,
					IC.FinancialYearEndDate,
					IC.IncorporationDate,
					IC.LegalStructure,
					IC.AccountingStandard,
					IC.TransparencyDirectiveHomeMemberCountry,
					IC.ProspectusDirectiveHomeMemberCountry,
					IC.IssuerDomicileDomesticYN,
					IC.FeeCodeName	
				FROM
					dbo.DwhDimInstrumentEquityEtf IC
				WHERE
					ISNULL( SHARE.IssuerGid, DwhShare.IssuerGlobalID ) = IC.IssuerGlobalID
				ORDER BY
					IC.InstrumentID DESC
			) AS Dwhissuer

	WHERE
		SHARE.Asset_Type IS NOT NULL


END
GO
