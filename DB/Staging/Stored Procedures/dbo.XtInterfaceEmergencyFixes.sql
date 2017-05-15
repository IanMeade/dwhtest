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
  
/*
	DELETE
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE
		ISIN IS NULL
*/

	DELETE
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE
		IssuerGlobalID IS NULL

  
	/* SET INSTRUMENT TYPE BASED ON SECURITY TYPE - MAKE EVERYTHING THAT IS NOT AN ETF AN EQUITY */
	/* COULD CAUSE ISSUES IF EquityStage IS POPULATED WITH NON-SHARE BASED INSTRUMENTS */
	UPDATE 
		dbo.XtOdsInstrumentEquityEtfUpdate  
	SET
		InstrumentType = 'Equity'
	WHERE
		SecurityType <> 'ETF'
	UPDATE 
		dbo.XtOdsInstrumentEquityEtfUpdate  
	SET
		InstrumentType = 'ETF'
	WHERE
		SecurityType = 'ETF'

	/* REPLACE NULLS WITH EMPTY STRINGS */
	UPDATE  
		dbo.XtOdsInstrumentEquityEtfUpdate  
	SET  
		SecurityType = ISNULL(SecurityType, ''),
		ISIN = ISNULL(ISIN, ''),
		SEDOL = ISNULL(SEDOL, ''),
		TradingSysInstrumentName = ISNULL( TradingSysInstrumentName, ''),
		CompanyApprovalType = ISNULL( CompanyApprovalType, ''),
		TransparencyDirectiveYN = ISNULL( TransparencyDirectiveYN, ''),
		MarketAbuseDirectiveYN = ISNULL( MarketAbuseDirectiveYN, ''),
		ProspectusDirectiveYN = ISNULL( ProspectusDirectiveYN, ''),
		IssuerDomicile = ISNULL( IssuerDomicile, ''),
		WKN = ISNULL( WKN, ''),
		MNEM = ISNULL( MNEM, ''),
		PrimaryBusinessSector = ISNULL(PrimaryBusinessSector, ''),
		SubBusinessSector1 = ISNULL(SubBusinessSector1, ''),
		SubBusinessSector2 = ISNULL(SubBusinessSector2, ''),
		SubBusinessSector3 = ISNULL(SubBusinessSector3, ''),
		SubBusinessSector4 = ISNULL(SubBusinessSector4, ''),
		SubBusinessSector5 = ISNULL(SubBusinessSector5, ''),
		PrimaryMarket = ISNULL(PrimaryMarket, ''),
		LegalStructure = ISNULL(LegalStructure, ''),
		AccountingStandard = ISNULL(AccountingStandard, ''),
		TransparencyDirectiveHomeMemberCountry = ISNULL(TransparencyDirectiveHomeMemberCountry, ''),
		ProspectusDirectiveHomeMemberCountry = ISNULL(ProspectusDirectiveHomeMemberCountry, ''),
		IssuerDomicileDomesticYN = ISNULL(IssuerDomicileDomesticYN, ''),
		FeeCodeName = ISNULL(FeeCodeName, ''),
		UnitOfQuotation = ISNULL(UnitOfQuotation, 0),
		IssuerSedolMasterFileName = ISNULL(IssuerSedolMasterFileName, ''),
		CFIName = ISNULL(CFIName, ''),
		CFICode = ISNULL(CFICode, ''),
		InstrumentSedolMasterFileName = ISNULL(InstrumentSedolMasterFileName, ''),
		Note = ISNULL(Note, '')

	/* EXPECT TO REMOVE IN EQ2 */
	UPDATE  
		dbo.XtOdsInstrumentEquityEtfUpdate  
	SET  
		TotalSharesInIssue = ISNULL(TotalSharesInIssue,0)

  
  
END  

GO
