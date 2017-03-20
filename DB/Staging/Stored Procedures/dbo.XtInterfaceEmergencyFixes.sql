SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================  
-- Author:		Ian Meade  
-- Create date: 23/2/2017  
-- Description:	Apply emergenvy fixes to XT details before pushing ito DWH  
-- =============================================  
CREATE PROCEDURE [dbo].[XtInterfaceEmergencyFixes]   
  
AS  
BEGIN  
	SET NOCOUNT ON;  
  
  
	UPDATE  
		dbo.XtOdsInstrumentEquityEtfUpdate  
	SET  
		SecurityType = ISNULL(SecurityType, 'UNKNOWN'),  
		InstrumentStatusDate = ISNULL( InstrumentStatusDate, '19900101'),  
		TradingSysInstrumentName = ISNULL(TradingSysInstrumentName, 'UNKNOWN'),  
		MarketName = ISNULL(MarketName, 'UNK'),  
		SEDOL = ISNULL(SEDOL,'UNKNOWN'),  
		WKN = ISNULL(WKN, 'UNK'),  
		MNEM = ISNULL(MNEM, 'UNKNOWN'),  
		FinancialIndexYN = ISNULL(FinancialIndexYN, 'X'),  
		PrimaryMarket = ISNULL(PrimaryMarket, 'UNKNOWN'),  
		IssuedDate ='19900101',  
		CurrencyISOCode = ISNULL(CurrencyISOCode, 'UNK'),  
		QuotationCurrencyISOCode = ISNULL(QuotationCurrencyISOCode, 'UNK'),  
		ISEQ20Freefloat = ISNULL(ISEQ20Freefloat, 0),  
		ISEQOverallFreeFloat = ISNULL(ISEQOverallFreeFloat, 0),  
		CFIName = ISNULL(CFIName, ''),  
		CFICode = ISNULL(CFICode, ''),  
		TotalSharesInIssue = ISNULL(TotalSharesInIssue, 0),  
		CompanyListedDate = ISNULL(CompanyListedDate, '19900101'),  
		CompanyApprovalDate = ISNULL(CompanyApprovalDate, '19900101'),  
		CompanyStatusName = ISNULL(CompanyStatusName, 'UNKNOWN'),  
		Note = ISNULL( Note, ''),  
		PrimaryBusinessSector = ISNULL(PrimaryBusinessSector,''),   
		SubBusinessSector1 = ISNULL(SubBusinessSector1, ''),  
		SubBusinessSector2 = ISNULL(SubBusinessSector2, ''),  
		SubBusinessSector3 = ISNULL(SubBusinessSector3, ''),  
		SubBusinessSector4 = ISNULL(SubBusinessSector4, ''),  
		SubBusinessSector5 = ISNULL(SubBusinessSector5, ''),  
		IssuerDomicile = ISNULL(IssuerDomicile , ''),  
		FinancialYearEndDate = ISNULL(FinancialYearEndDate, '19900101'),  
		IncorporationDate = ISNULL(IncorporationDate, '19900101'),   
		LegalStructure = ISNULL(LegalStructure, 'UNKNOWN'),  
		AccountingStandard = ISNULL(AccountingStandard, 'UNKNOWN'),  
		TransparencyDirectiveHomeMemberCountry = ISNULL(TransparencyDirectiveHomeMemberCountry, 'UNKNOWN'),  
		ProspectusDirectiveHomeMemberCountry = ISNULL(ProspectusDirectiveHomeMemberCountry, 'UNKNOWN'),  
		FeeCodeName = ISNULL(FeeCodeName, 'UNKNOWN' ),  
		IssuerName = ISNULL(IssuerName, 'UNKNOWN'),  
		IssuerDomicileDomesticYN = ISNULL(IssuerDomicileDomesticYN, 'X'), 
		InstrumentSedolMasterFileName = ISNULL( InstrumentSedolMasterFileName, ''), 
		IssuerSedolMasterFileName = ISNULL( IssuerSedolMasterFileName, '') ,
--		ISEQ20IndexYN = ISNULL( ISEQ20IndexYN, 'N'),
		ESMIndexYN = ISNULL( ESMIndexYN, 'N'),
		ISEQ20IndexYN = ISNULL( ISEQ20IndexYN, 'N')

  
  
END  

GO
