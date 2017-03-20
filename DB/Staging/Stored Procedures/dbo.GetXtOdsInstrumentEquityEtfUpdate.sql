SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 23/2/2017 
-- Description:	Get XT details preparted for DWH / ETL pipelins 
-- ============================================= 
CREATE PROCEDURE [dbo].[GetXtOdsInstrumentEquityEtfUpdate] AS 
BEGIN 
	SET NOCOUNT ON; 
 
	SELECT 
		InstrumentGlobalID,  
		InstrumentName,  
		InstrumentType,  
		SecurityType,  
		LEFT(ISIN,12) AS ISIN,  
		LEFT(SEDOL,7) AS SEDOL, 
		UPPER(InstrumentStatusName) AS InstrumentStatusName,
		InstrumentStatusName,  
		InstrumentStatusDate,  
		TradingSysInstrumentName,  
		CompanyGlobalID,  
		MarketName,  
		LEFT(WKN,6) AS WKN, 
		LEFT(MNEM,4) AS MNEM,  
		GeneralIndexYN,  
		InstrumentListedDate,  
		LEFT(InstrumentSedolMasterFileName, 40) AS InstrumentSedolMasterFileName,  
		ISEQ20IndexYN,  
		LEFT(IssuerSedolMasterFileName, 40) AS IssuerSedolMasterFileName,
		ITEQIndexYN,  
		LastEXDivDate,  
		OverallIndexYN,  
		FinancialIndexYN,  
		SmallCapIndexYN,  
		PrimaryMarket,  
		IssuedDate,  
		CurrencyISOCode,  
		UnitOfQuotation,  
		QuotationCurrencyISOCode,  
		ISEQ20Freefloat,  
		ISEQOverallFreeFloat,  
		CFIName,  
		CFICode,  
		TotalSharesInIssue,  
		CompanyListedDate,  
		CompanyApprovalDate,  
		CompanyApprovalType,  
		UPPER(CompanyStatusName) AS CompanyStatusName,  
		Note,  
		TransparencyDirectiveYN,  
		MarketAbuseDirectiveYN,  
		ProspectusDirectiveYN,  
		PrimaryBusinessSector,  
		SubBusinessSector1,  
		SubBusinessSector2,  
		SubBusinessSector3,  
		SubBusinessSector4,  
		SubBusinessSector5,  
		IssuerGlobalID,  
		IssuerName,  
		IssuerDomicile,  
		FinancialYearEndDate,  
		IncorporationDate,  
		LegalStructure,  
		AccountingStandard,  
		TransparencyDirectiveHomeMemberCountry,  
		ProspectusDirectiveHomeMemberCountry,  
		IssuerDomicileDomesticYN,  
		FeeCodeName,
		ESMIndexYN,
		IIF( LEFT(ISIN,2) = 'IE', 'Y', 'N' ) AS InstrumentDomesticYN
	FROM 
		dbo.XtOdsInstrumentEquityEtfUpdate 
	/* REPLACED BY VALIDATION ROUTINE
	WHERE
		ISIN IS NOT NULL
	AND
 		CompanyApprovalType IS NOT NULL
	*/

END 
GO
