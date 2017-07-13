SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 23/2/2017   
-- Description:	Get XT details prepared for DWH / ETL pipeline   
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
		InstrumentStatusDate,    
		TradingSysInstrumentName,    
		CompanyGlobalID,    
		I.MarketCode,    
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
		UnitOfQuotation,    
		ISEQ20Freefloat,    
		ISEQOverallFreeFloat,    
		CFIName,    
		CFICode,    
		TotalSharesInIssue,    
		CompanyListedDate,    
		CompanyApprovalDate,    
		CompanyApprovalType,    
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
		IIF( LEFT(ISIN,2) = 'IE', 'Y', 'N' ) AS InstrumentDomesticYN, 
		ES.StatusID AS InstrumentStatusID, 
		CS.StatusID AS CompanyStatusID, 
		CC.CurrencyID AS CurrencyID, 
		QC.CurrencyID AS QuotationCurrencyID, 
		DM.MarketID,
		ExSpecial,
		ExCapitalisation,
		ExRights,
		ExEntitlement,
		ExDividend,
		SecurityQualifier
	FROM   
			dbo.XtOdsInstrumentEquityEtfUpdate I 
		INNER JOIN 
			dbo.DwhDimStatus ES 
		ON I.InstrumentStatusName = ES.StatusName 
		INNER JOIN 
			dbo.DwhDimStatus CS 
		ON I.CompanyStatusName = CS.StatusName 
		INNER JOIN 
			dbo.DwhDimCurrency CC  
		ON I.CurrencyISOCode = CC.CurrencyISOCode 
		INNER JOIN 
			dbo.DwhDimCurrency QC  
		ON I.QuotationCurrencyISOCode = QC.CurrencyISOCode 
		INNER JOIN 
			dbo.DwhDimMarket DM 
		ON I.MarketCode = DM.MarketCode 
 
END   
GO
