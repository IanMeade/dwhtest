SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 21/2/2017 
-- Description:	Get a list of updates tp apply to instrument dimension 
-- ============================================= 
CREATE PROCEDURE [dbo].[GetXtInterfaceUpdatesToApply] 
AS 
BEGIN 
	SET NOCOUNT ON; 
 
	TRUNCATE TABLE dbo.XtInterfaceUpdateTypes 
 
	INSERT INTO dbo.XtInterfaceUpdateTypes 
		SELECT 
			DISTINCT  
			InstrumentGlobalID, 
			'NEW' AS UpdateType 
		FROM 
			[dbo].[XtOdsInstrumentEquityEtfUpdate] F 
		WHERE 
			InstrumentGlobalID NOT IN ( 
					SELECT 
						InstrumentGlobalID 
					FROM 
						dbo.DwhDimInstrumentEquityEtf 
				) 
 
	INSERT INTO dbo.XtInterfaceUpdateTypes 
		SELECT 
			DISTINCT  
			F.InstrumentGlobalID, 
			'SCD-1' AS UpdateType 
		FROM 
				dbo.XtOdsInstrumentEquityEtfUpdate F 
			INNER JOIN 
				dbo.DwhDimInstrumentEquityEtf T 
			ON  
				F.InstrumentGlobalID = T.InstrumentGlobalID 
			AND  
				T.CurrentRowYN = 'Y' 
		WHERE 
			( 
				CAST(F.CompanyListedDate AS DATE) != T.CompanyListedDate 
			OR 
				F.CompanyApprovalType != T.CompanyApprovalType 
			OR 
				F.CompanyApprovalDate != T.CompanyApprovalDate 
			OR	 
				F.IncorporationDate != T.IncorporationDate 
			OR 
				F.IssuedDate != T.IssuedDate 
			OR 
				F.CFIName != T.CFIName 
			OR 
				F.CFICode != T.CFICode 
			OR 
				F.Note != T.Note 
			OR
				F.InstrumentStatusName != T.InstrumentStatusName
			) 
 
	INSERT INTO dbo.XtInterfaceUpdateTypes 
		SELECT 
			DISTINCT  
			F.InstrumentGlobalID, 
			'SCD-2' AS UpdateType 
		FROM 
				dbo.XtOdsInstrumentEquityEtfUpdate F 
			INNER JOIN 
				dbo.DwhDimInstrumentEquityEtf T 
			ON  
				F.InstrumentGlobalID = T.InstrumentGlobalID 
			AND  
				T.CurrentRowYN = 'Y' 
		WHERE 
			( 
				F.InstrumentName != T.InstrumentName 
			OR  
				F.ISIN != T.ISIN 
			OR  
				F.SEDOL != T.SEDOL 
			OR  
				CAST(F.InstrumentStatusDate AS DATE) != T.InstrumentStatusDate 
--				F.InstrumentStatusDate != T.InstrumentStatusDate 
		--	OR F.InstrumentListedDate != T.InstrumentListedDate 
			OR 
				F.TradingSysInstrumentName != T.TradingSysInstrumentName 
			OR  
				F.IssuerName != T.IssuerName 
			OR  
				F.IssuerGlobalID != T.IssuerGlobalID 
			OR  
				F.CompanyGlobalID != T.CompanyGlobalID 
			OR  
				F.TransparencyDirectiveYN != T.TransparencyDirectiveYN 
			OR  
				F.MarketAbuseDirectiveYN != T.MarketAbuseDirectiveYN 
			OR  
				F.ProspectusDirectiveYN != T.ProspectusDirectiveYN 
			OR 
				F.IssuerDomicile != T.IssuerDomicile 
			OR  
				F.WKN != T.WKN 
			OR  
				F.MNEM != T.MNEM 
			OR  
				F.PrimaryBusinessSector != T.PrimaryBusinessSector 
			OR  
				F.SubBusinessSector1 != T.SubBusinessSector1 
			OR  
				F.SubBusinessSector2 != T.SubBusinessSector2 
			OR  
				F.SubBusinessSector3 != T.SubBusinessSector3 
			OR  
				F.SubBusinessSector4 != T.SubBusinessSector4 
			OR  
				F.SubBusinessSector5 != T.SubBusinessSector5 
			OR  
				F.OverallIndexYN != T.OverallIndexYN 
			OR  
				F.GeneralIndexYN != T.GeneralIndexYN 
			OR  
				F.FinancialIndexYN != T.FinancialIndexYN 
			OR  
				F.SmallCapIndexYN != T.SmallCapIndexYN 
			OR  
				F.ITEQIndexYN != T.ITEQIndexYN 
			OR  
				F.ISEQ20IndexYN != T.ISEQ20IndexYN 
			OR 
				F.ESMIndexYN != T.ESMIndexYN 
			OR  
				F.PrimaryMarket != T.PrimaryMarket 
			OR  
				F.FinancialYearEndDate != T.FinancialYearEndDate 
			OR  
				F.LegalStructure != T.LegalStructure 
			OR  
				F.AccountingStandard != T.AccountingStandard 
			OR  
				F.TransparencyDirectiveHomeMemberCountry != T.TransparencyDirectiveHomeMemberCountry 
			OR  
				F.ProspectusDirectiveHomeMemberCountry != T.ProspectusDirectiveHomeMemberCountry 
			OR  
				F.IssuerDomicileDomesticYN != T.IssuerDomicileDomesticYN 
			OR  
				F.FeeCodeName != T.FeeCodeName 
			OR  
				F.UnitOfQuotation != T.UnitOfQuotation 
			OR  
				F.ISEQ20Freefloat != T.ISEQ20Freefloat 
			OR  
				F.ISEQOverallFreeFloat != T.ISEQOverallFreeFloat 
			OR  
				F.IssuerSedolMasterFileName != T.IssuerSedolMasterFileName 
			--OR F.InstrumentDomesticYN != T.InstrumentDomesticYN 
			OR  
				F.InstrumentSedolMasterFileName != T.InstrumentSedolMasterFileName 
			OR  
				F.TotalSharesInIssue != T.TotalSharesInIssue 
			OR
				F.CompanyStatusName != T.CompanyStatusName
		) 
 
 
END 
GO
