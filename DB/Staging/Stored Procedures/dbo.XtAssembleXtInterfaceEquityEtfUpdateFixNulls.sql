SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 4/8/2017
-- Description:	Make nullable fields valid empty values - empty string / 0

-- =============================================
CREATE PROCEDURE [dbo].[XtAssembleXtInterfaceEquityEtfUpdateFixNulls]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
	UPDATE
		[dbo].[XtOdsShare]
	SET
		Asset_Type= ISNULL(Asset_Type,''),
		Name= ISNULL(Name,''),
		DelistedDefunct= ISNULL(DelistedDefunct,0),
		--ListingDate= ISNULL(ListingDate,''),
		ListingStatus= ISNULL(ListingStatus,''),
		--InstrumentStatusDate= ISNULL(InstrumentStatusDate,''),
		--InstrumentStatusCreatedDatetime= ISNULL(InstrumentStatusCreatedDatetime,''),
		Sector= ISNULL(Sector,''),
		Subfocus1= ISNULL(Subfocus1,''),
		Subfocus2= ISNULL(Subfocus2,''),
		Subfocus3= ISNULL(Subfocus3,''),
		Subfocus4= ISNULL(Subfocus4,''),
		Subfocus5= ISNULL(Subfocus5,''),
		ApprovalType= ISNULL(ApprovalType,''),
		--ApprovalDate= ISNULL(ApprovalDate,''),
		TdFlag= ISNULL(TdFlag,0),
		MadFlag= ISNULL(MadFlag,0),
		PdFlag= ISNULL(PdFlag,0),
		--Gid= ISNULL(Gid,''),
		--IssuerGid= ISNULL(IssuerGid,''),
		Isin= ISNULL(Isin,''),
		Sedol= ISNULL(Sedol,''),
		MarketType= ISNULL(MarketType,''),
		SecurityType= ISNULL(SecurityType,''),
		DenominationCurrency= ISNULL(DenominationCurrency,''),
		ISEQOverallFreeFloat= ISNULL(ISEQOverallFreeFloat,0),
		ISEQ20IndexFlag= ISNULL(ISEQ20IndexFlag,0),
		ESMIndexFlag= ISNULL(ESMIndexFlag,0),
		IteqIndexFlag= ISNULL(IteqIndexFlag,0),
		GeneralFinancialFlag= ISNULL(GeneralFinancialFlag,0),
		SmallCap= ISNULL(SmallCap,0),
		Note= ISNULL(Note,''),
		PrimaryMarket= ISNULL(PrimaryMarket,''),
		QuotationCurrency= ISNULL(QuotationCurrency,''),
		UnitOfQuotation= ISNULL(UnitOfQuotation,0),
		Wkn= ISNULL(Wkn,''),
		Mnem= ISNULL(Mnem,''),
		CfiName= ISNULL(CfiName,''),
		CfiCode= ISNULL(CfiCode,''),
		SmfName= ISNULL(SmfName,''),
		TotalSharesInIssue= ISNULL(TotalSharesInIssue,''),
		--InstrumentActualListedDate= ISNULL(InstrumentActualListedDate,''),
		TradingSysInstrumentName= ISNULL(TradingSysInstrumentName,''),
		CompanyGid= ISNULL(CompanyGid,''),
		ExDividend= ISNULL(ExDividend,0),
		ExCapitalisation= ISNULL(ExCapitalisation,0),
		ExRights= ISNULL(ExRights,0),
		ExSpecial= ISNULL(ExSpecial,0),
		ExEntitlement= ISNULL(ExEntitlement,0),
		SecurityQualifier= ISNULL(SecurityQualifier,'')
		--ExDividendDate= ISNULL(ExDividendDate,''),
		--ExtractSequenceId= ISNULL(ExtractSequenceId,''),
		--ExtractDate= ISNULL(ExtractDate,''),
		--MessageId= ISNULL(MessageId,'')


	UPDATE
		[dbo].[XtOdsCompany]
	SET
		Asset_Type= ISNULL(Asset_Type,''),
		Name= ISNULL(Name,''),
		DelistedDefunct= ISNULL(DelistedDefunct,0),
		--ListingDate= ISNULL(ListingDate,''),
		ListingStatus= ISNULL(ListingStatus,''),
		--InstrumentStatusDate= ISNULL(InstrumentStatusDate,''),
		--InstrumentStatusCreatedDatetime= ISNULL(InstrumentStatusCreatedDatetime,''),
		Sector= ISNULL(Sector,''),
		Subfocus1= ISNULL(Subfocus1,''),
		Subfocus2= ISNULL(Subfocus2,''),
		Subfocus3= ISNULL(Subfocus3,''),
		Subfocus4= ISNULL(Subfocus4,''),
		Subfocus5= ISNULL(Subfocus5,''),
		ApprovalType= ISNULL(ApprovalType,''),
		--ApprovalDate= ISNULL(ApprovalDate,''),
		TdFlag= ISNULL(TdFlag,0),
		MadFlag= ISNULL(MadFlag,0),
		PdFlag= ISNULL(PdFlag,0),
		--Gid= ISNULL(Gid,''),
		--IssuerGid= ISNULL(IssuerGid,''),
		Isin= ISNULL(Isin,''),
		Sedol= ISNULL(Sedol,''),
		MarketType= ISNULL(MarketType,''),
		SecurityType= ISNULL(SecurityType,''),
		DenominationCurrency= ISNULL(DenominationCurrency,''),
		ISEQOverallFreeFloat= ISNULL(ISEQOverallFreeFloat,0),
		ISEQ20IndexFlag= ISNULL(ISEQ20IndexFlag,0),
		ESMIndexFlag= ISNULL(ESMIndexFlag,0),
		IteqIndexFlag= ISNULL(IteqIndexFlag,0),
		GeneralFinancialFlag= ISNULL(GeneralFinancialFlag,0),
		SmallCap= ISNULL(SmallCap,0),
		Note= ISNULL(Note,''),
		PrimaryMarket= ISNULL(PrimaryMarket,''),
		QuotationCurrency= ISNULL(QuotationCurrency,''),
		UnitOfQuotation= ISNULL(UnitOfQuotation,0),
		Wkn= ISNULL(Wkn,''),
		Mnem= ISNULL(Mnem,''),
		CfiName= ISNULL(CfiName,''),
		CfiCode= ISNULL(CfiCode,''),
		SmfName= ISNULL(SmfName,''),
		TotalSharesInIssue= ISNULL(TotalSharesInIssue,''),
		--InstrumentActualListedDate= ISNULL(InstrumentActualListedDate,''),
		TradingSysInstrumentName= ISNULL(TradingSysInstrumentName,''),
		CompanyGid= ISNULL(CompanyGid,'')
		--ExDividendDate= ISNULL(ExDividendDate,''),
		--ExtractSequenceId= ISNULL(ExtractSequenceId,''),
		--ExtractDate= ISNULL(ExtractDate,''),
		--MessageId= ISNULL(MessageId,'')

	UPDATE
		dbo.XtOdsIssuer
	SET
		--ID= ISNULL(ID,''),
		Name= ISNULL(Name,''),
		--DateOfIncorporation= ISNULL(DateOfIncorporation,''),
		DebtorCode= ISNULL(DebtorCode,''),
		DebtorCodeEquity= ISNULL(DebtorCodeEquity,''),
		Domicile= ISNULL(Domicile,''),
		DomicileDomesticFlag= ISNULL(DomicileDomesticFlag,0),
		FeeCode= ISNULL(FeeCode,''),
		SmfName= ISNULL(SmfName,''),
		Td_Home_Member_Country= ISNULL(Td_Home_Member_Country,''),
		VatNumber= ISNULL(VatNumber,''),
		AccountingStandard= ISNULL(AccountingStandard,''),
		LegalStructure= ISNULL(LegalStructure,''),
		--YearEnd= ISNULL(YearEnd,''),
		Pd_Home_Member_Country= ISNULL(Pd_Home_Member_Country,''),
		Lei_Code= ISNULL(Lei_Code,''),
		EUFlag= ISNULL(EUFlag,0),
		IsoCode= ISNULL(IsoCode,'')
		--Gid= ISNULL(Gid,''),
		--ExtractSequenceId= ISNULL(ExtractSequenceId,''),
		--ExtractDate= ISNULL(ExtractDate,''),
		--MessageId= ISNULL(MessageId,''),

END
GO
