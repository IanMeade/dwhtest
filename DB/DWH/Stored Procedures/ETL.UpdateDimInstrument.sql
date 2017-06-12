SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 24/5/2017
-- Description:	Update DimInstrument and variants....
-- =============================================
CREATE PROCEDURE [ETL].[UpdateDimInstrument]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY 

		BEGIN TRANSACTION

		/* EXPIRE OLD SCD-2s */
		UPDATE
			I
		SET
			CurrentRowYN = 'N',
			EndDate = GETDATE()
		FROM
			ETL.XtUpdateType XT
		INNER JOIN
			DWH.DimInstrument I
		ON XT.InstrumentGlobalID = I.InstrumentGlobalID
		WHERE
			XT.UpdateType = 'SCD-2'
		AND
			I.CurrentRowYN = 'Y'

		UPDATE
			I
		SET
			CurrentRowYN = 'N',
			EndDate = GETDATE()
		FROM
			ETL.XtUpdateType XT
		INNER JOIN
			DWH.DimInstrumentEquity I
		ON XT.InstrumentGlobalID = I.InstrumentGlobalID
		WHERE
			XT.UpdateType = 'SCD-2'
		AND
			I.CurrentRowYN = 'Y'

		UPDATE
			I
		SET
			CurrentRowYN = 'N',
			EndDate = GETDATE()
		FROM
			ETL.XtUpdateType XT
		INNER JOIN
			DWH.DimInstrumentEtf I
		ON XT.InstrumentGlobalID = I.InstrumentGlobalID
		WHERE
			XT.UpdateType = 'SCD-2'
		AND
			I.CurrentRowYN = 'Y'


		/* INSERT NEW INSTRUMENTS / UPDATE TYPE 2s */

		INSERT INTO
				DWH.DimInstrument
			(
				InstrumentGlobalID, 
				InstrumentName, 
				InstrumentType, 
				SecurityType, 
				ISIN, 
				SEDOL, 
				InstrumentStatusID, 
				InstrumentStatusDate, 
				InstrumentListedDate, 
				IssuerName, 
				IssuerGlobalID, 
				MarketID, 
				IssuerDomicile, 
				FinancialYearEndDate, 
				IncorporationDate, 
				LegalStructure, 
				AccountingStandard, 
				TransparencyDirectiveHomeMemberCountry, 
				ProspectusDirectiveHomeMemberCountry, 
				IssuerDomicileDomesticYN, 
				FeeCodeName, 
				WKN, 
				MNEM, 
				IssuedDate, 
				IssuerSedolMasterFileName, 
				CompanyGlobalID, 
				CompanyApprovalDate, 
				CompanyApprovalType, 
				InstrumentDomesticYN, 
				InstrumentSedolMasterFileName, 
				StartDate, 
				CurrentRowYN, 
				BatchID
			)
			SELECT
				InstrumentGlobalID, 
				InstrumentName, 
				InstrumentType, 
				SecurityType, 
				ISIN, 
				SEDOL, 
				InstrumentStatusID, 
				InstrumentStatusDate, 
				InstrumentListedDate, 
				IssuerName, 
				IssuerGlobalID, 
				MarketID, 
				IssuerDomicile, 
				FinancialYearEndDate, 
				IncorporationDate, 
				LegalStructure, 
				AccountingStandard, 
				TransparencyDirectiveHomeMemberCountry, 
				ProspectusDirectiveHomeMemberCountry, 
				IssuerDomicileDomesticYN, 
				FeeCodeName, 
				WKN, 
				MNEM, 
				IssuedDate, 
				IssuerSedolMasterFileName, 
				CompanyGlobalID, 
				CompanyApprovalDate, 
				CompanyApprovalType, 
				InstrumentDomesticYN, 
				InstrumentSedolMasterFileName, 
				GETDATE(),
				'Y', 
				-1
			FROM
				ETL.XtDimInstrument I
			WHERE
				InstrumentGlobalID IN (
							SELECT
								InstrumentGlobalID 
							FROM
								ETL.XtUpdateType
							WHERE
								UpdateType IN ( 'NEW', 'SCD-2' )
					)



		INSERT INTO
				DWH.DimInstrumentEquity
			(
				InstrumentID, 
				InstrumentGlobalID, 
				InstrumentName, 
				InstrumentType, 
				SecurityType, 
				ISIN, 
				SEDOL, 
				InstrumentStatusID, 
				InstrumentStatusDate, 
				InstrumentListedDate, 
				TradingSysInstrumentName, 
				IssuerName, 
				IssuerGlobalID, 
				CompanyGlobalID, 
				CompanyListedDate, 
				CompanyApprovalType, 
				CompanyApprovalDate, 
				TransparencyDirectiveYN, 
				MarketAbuseDirectiveYN, 
				ProspectusDirectiveYN, 
				MarketID, 
				IssuerDomicile, 
				WKN, 
				MNEM, 
				PrimaryBusinessSector, 
				SubBusinessSector1, 
				SubBusinessSector2, 
				SubBusinessSector3, 
				SubBusinessSector4, 
				SubBusinessSector5, 
				OverallIndexYN, 
				GeneralIndexYN, 
				FinancialIndexYN, 
				SmallCapIndexYN, 
				ITEQIndexYN, 
				ISEQ20IndexYN, 
				ESMIndexYN, 
				PrimaryMarket, 
				FinancialYearEndDate, 
				IncorporationDate, 
				LegalStructure, 
				AccountingStandard, 
				TransparencyDirectiveHomeMemberCountry, 
				ProspectusDirectiveHomeMemberCountry, 
				IssuerDomicileDomesticYN, 
				FeeCodeName, 
				IssuedDate, 
				CurrencyID, 
				UnitOfQuotation, 
				QuotationCurrencyID, 
				ISEQ20Freefloat, 
				ISEQOverallFreeFloat, 
				IssuerSedolMasterFileName, 
				InstrumentDomesticYN, 
				CFIName, 
				CFICode, 
				InstrumentSedolMasterFileName, 
				TotalSharesInIssue, 
				LastEXDivDate, 
				CompanyStatusID, 
				Note, 
				StartDate, 
				CurrentRowYN, 
				BatchID
			)
			SELECT
				InstrumentID = (
							SELECT	
								I2.InstrumentID 		
							FROM
								DWH.DimInstrument I2
							WHERE
								I.InstrumentGlobalID = I2.InstrumentGlobalID
							AND
								I2.CurrentRowYN = 'Y'
						),
				InstrumentGlobalID, 
				InstrumentName, 
				InstrumentType, 
				SecurityType, 
				ISIN, 
				SEDOL, 
				InstrumentStatusID, 
				InstrumentStatusDate, 
				InstrumentListedDate, 
				TradingSysInstrumentName, 
				IssuerName, 
				IssuerGlobalID, 
				CompanyGlobalID, 
				CompanyListedDate, 
				CompanyApprovalType, 
				CompanyApprovalDate, 
				TransparencyDirectiveYN, 
				MarketAbuseDirectiveYN, 
				ProspectusDirectiveYN, 
				MarketID, 
				IssuerDomicile, 
				WKN, 
				MNEM, 
				PrimaryBusinessSector, 
				SubBusinessSector1, 
				SubBusinessSector2, 
				SubBusinessSector3, 
				SubBusinessSector4, 
				SubBusinessSector5, 
				OverallIndexYN, 
				GeneralIndexYN, 
				FinancialIndexYN, 
				SmallCapIndexYN, 
				ITEQIndexYN, 
				ISEQ20IndexYN, 
				ESMIndexYN, 
				PrimaryMarket, 
				FinancialYearEndDate, 
				IncorporationDate, 
				LegalStructure, 
				AccountingStandard, 
				TransparencyDirectiveHomeMemberCountry, 
				ProspectusDirectiveHomeMemberCountry, 
				IssuerDomicileDomesticYN, 
				FeeCodeName, 
				IssuedDate, 
				CurrencyID, 
				UnitOfQuotation, 
				QuotationCurrencyID, 
				ISEQ20Freefloat, 
				ISEQOverallFreeFloat, 
				IssuerSedolMasterFileName, 
				InstrumentDomesticYN, 
				CFIName, 
				CFICode, 
				InstrumentSedolMasterFileName, 
				TotalSharesInIssue, 
				LastEXDivDate, 
				CompanyStatusID, 
				Note, 
				GETDATE(),
				'Y', 
				-1
			FROM
				ETL.XtDimInstrument I
			WHERE
				InstrumentType <> 'ETF'
			AND
				InstrumentGlobalID IN (
							SELECT
								InstrumentGlobalID 
							FROM
								ETL.XtUpdateType
							WHERE
								UpdateType IN ( 'NEW', 'SCD-2' )
					)


		INSERT INTO
				DWH.DimInstrumentEtf	
			(
				InstrumentID, 
				InstrumentGlobalID, 
				InstrumentName, 
				InstrumentType, 
				SecurityType, 
				ISIN, 
				SEDOL, 
				InstrumentStatusID, 
				InstrumentStatusDate, 
				InstrumentListedDate, 
				TradingSysInstrumentName, 
				IssuerName, 
				IssuerGlobalID, 
				CompanyGlobalID, 
				CompanyListedDate, 
				CompanyApprovalType, 
				CompanyApprovalDate, 
				TransparencyDirectiveYN, 
				MarketAbuseDirectiveYN, 
				ProspectusDirectiveYN, 
				MarketID, 
				IssuerDomicile, 
				WKN, 
				MNEM, 
				PrimaryBusinessSector, 
				SubBusinessSector1, 
				SubBusinessSector2, 
				SubBusinessSector3, 
				SubBusinessSector4, 
				SubBusinessSector5, 
				OverallIndexYN, 
				GeneralIndexYN, 
				FinancialIndexYN, 
				SmallCapIndexYN, 
				ITEQIndexYN, 
				ISEQ20IndexYN, 
				ESMIndexYN, 
				PrimaryMarket, 
				FinancialYearEndDate, 
				IncorporationDate, 
				LegalStructure, 
				AccountingStandard, 
				TransparencyDirectiveHomeMemberCountry, 
				ProspectusDirectiveHomeMemberCountry, 
				IssuerDomicileDomesticYN, 
				FeeCodeName, 
				IssuedDate, 
				CurrencyID, 
				UnitOfQuotation, 
				QuotationCurrencyID, 
				ISEQ20Freefloat, 
				ISEQOverallFreeFloat, 
				IssuerSedolMasterFileName, 
				InstrumentDomesticYN, 
				CFIName, 
				CFICode, 
				InstrumentSedolMasterFileName, 
				TotalSharesInIssue, 
				LastEXDivDate, 
				CompanyStatusID, 
				Note, 
				StartDate, 
				CurrentRowYN, 
				BatchID
			)
			SELECT
				InstrumentID = (
							SELECT	
								I2.InstrumentID 		
							FROM
								DWH.DimInstrument I2
							WHERE
								I.InstrumentGlobalID = I2.InstrumentGlobalID
							AND
								I2.CurrentRowYN = 'Y'
						),
				InstrumentGlobalID, 
				InstrumentName, 
				InstrumentType, 
				SecurityType, 
				ISIN, 
				SEDOL, 
				InstrumentStatusID, 
				InstrumentStatusDate, 
				InstrumentListedDate, 
				TradingSysInstrumentName, 
				IssuerName, 
				IssuerGlobalID, 
				CompanyGlobalID, 
				CompanyListedDate, 
				CompanyApprovalType, 
				CompanyApprovalDate, 
				TransparencyDirectiveYN, 
				MarketAbuseDirectiveYN, 
				ProspectusDirectiveYN, 
				MarketID, 
				IssuerDomicile, 
				WKN, 
				MNEM, 
				PrimaryBusinessSector, 
				SubBusinessSector1, 
				SubBusinessSector2, 
				SubBusinessSector3, 
				SubBusinessSector4, 
				SubBusinessSector5, 
				OverallIndexYN, 
				GeneralIndexYN, 
				FinancialIndexYN, 
				SmallCapIndexYN, 
				ITEQIndexYN, 
				ISEQ20IndexYN, 
				ESMIndexYN, 
				PrimaryMarket, 
				FinancialYearEndDate, 
				IncorporationDate, 
				LegalStructure, 
				AccountingStandard, 
				TransparencyDirectiveHomeMemberCountry, 
				ProspectusDirectiveHomeMemberCountry, 
				IssuerDomicileDomesticYN, 
				FeeCodeName, 
				IssuedDate, 
				CurrencyID, 
				UnitOfQuotation, 
				QuotationCurrencyID, 
				ISEQ20Freefloat, 
				ISEQOverallFreeFloat, 
				IssuerSedolMasterFileName, 
				InstrumentDomesticYN, 
				CFIName, 
				CFICode, 
				InstrumentSedolMasterFileName, 
				TotalSharesInIssue, 
				LastEXDivDate, 
				CompanyStatusID, 
				Note, 
				GETDATE(),
				'Y', 
				-1
			FROM
				ETL.XtDimInstrument I
			WHERE
				InstrumentType = 'ETF'
			AND
				InstrumentGlobalID IN (
							SELECT
								InstrumentGlobalID 
							FROM
								ETL.XtUpdateType
							WHERE
								UpdateType IN ( 'NEW', 'SCD-2' )
					)


		/* SCD TYPE 1s */

		UPDATE
			I
		SET
			SecurityType = I_upd.SecurityType,
			InstrumentStatusID = I_upd.InstrumentStatusID,
			InstrumentStatusDate = I_upd.InstrumentStatusDate,
			InstrumentListedDate = I_upd.InstrumentListedDate,
			CompanyApprovalType = I_upd.CompanyApprovalType,
			CompanyApprovalDate = I_upd.CompanyApprovalDate,
			IssuerDomicile = I_upd.IssuerDomicile,
			WKN = I_upd.WKN,
			MNEM = I_upd.MNEM,
			FinancialYearEndDate = I_upd.FinancialYearEndDate,
			IncorporationDate = I_upd.IncorporationDate,
			LegalStructure = I_upd.LegalStructure,
			AccountingStandard = I_upd.AccountingStandard,
			TransparencyDirectiveHomeMemberCountry = I_upd.TransparencyDirectiveHomeMemberCountry,
			ProspectusDirectiveHomeMemberCountry = I_upd.ProspectusDirectiveHomeMemberCountry,
			IssuerDomicileDomesticYN = I_upd.IssuerDomicileDomesticYN,
			FeeCodeName = I_upd.FeeCodeName,
			IssuerSedolMasterFileName = I_upd.IssuerSedolMasterFileName,
			InstrumentDomesticYN = I_upd.InstrumentDomesticYN,
			InstrumentSedolMasterFileName = I_upd.InstrumentSedolMasterFileName
		FROM
				ETL.XtUpdateType XT
			INNER JOIN
				DWH.DimInstrument I
			ON XT.InstrumentGlobalID = I.InstrumentGlobalID
			INNER JOIN
				ETL.XtDimInstrument I_upd
			ON I.InstrumentGlobalID = I_upd.InstrumentGlobalID
		WHERE
			XT.UpdateType = 'SCD-1'


		UPDATE
			DWH.DimInstrumentEquity
		SET
			SecurityType = I_upd.SecurityType,
			InstrumentStatusID = I_upd.InstrumentStatusID,
			InstrumentStatusDate = I_upd.InstrumentStatusDate,
			InstrumentListedDate = I_upd.InstrumentListedDate,
			CompanyListedDate = I_upd.CompanyListedDate,
			CompanyApprovalType = I_upd.CompanyApprovalType,
			CompanyApprovalDate = I_upd.CompanyApprovalDate,
			IssuerDomicile = I_upd.IssuerDomicile,
			WKN = I_upd.WKN,
			MNEM = I_upd.MNEM,
			PrimaryBusinessSector = I_upd.PrimaryBusinessSector,
			SubBusinessSector1 = I_upd.SubBusinessSector1,
			SubBusinessSector2 = I_upd.SubBusinessSector2,
			SubBusinessSector3 = I_upd.SubBusinessSector3,
			SubBusinessSector4 = I_upd.SubBusinessSector4,
			SubBusinessSector5 = I_upd.SubBusinessSector5,
			FinancialYearEndDate = I_upd.FinancialYearEndDate,
			IncorporationDate = I_upd.IncorporationDate,
			LegalStructure = I_upd.LegalStructure,
			AccountingStandard = I_upd.AccountingStandard,
			TransparencyDirectiveHomeMemberCountry = I_upd.TransparencyDirectiveHomeMemberCountry,
			ProspectusDirectiveHomeMemberCountry = I_upd.ProspectusDirectiveHomeMemberCountry,
			IssuerDomicileDomesticYN = I_upd.IssuerDomicileDomesticYN,
			FeeCodeName = I_upd.FeeCodeName,
			IssuedDate = I_upd.IssuedDate,
			CurrencyID = I_upd.CurrencyID,
			UnitOfQuotation = I_upd.UnitOfQuotation,
			QuotationCurrencyID = I_upd.QuotationCurrencyID,
			IssuerSedolMasterFileName = I_upd.IssuerSedolMasterFileName,
			InstrumentDomesticYN = I_upd.InstrumentDomesticYN,
			CFIName = I_upd.CFIName,
			CFICode = I_upd.CFICode,
			InstrumentSedolMasterFileName = I_upd.InstrumentSedolMasterFileName,
			LastEXDivDate = I_upd.LastEXDivDate,
			CompanyStatusID = I_upd.CompanyStatusID,
			Note = I_upd.Note
		FROM
				ETL.XtUpdateType XT
			INNER JOIN
				DWH.DimInstrumentEtf I
			ON XT.InstrumentGlobalID = I.InstrumentGlobalID
			INNER JOIN
				ETL.XtDimInstrument I_upd
			ON I.InstrumentGlobalID = I_upd.InstrumentGlobalID
		WHERE
			XT.UpdateType = 'SCD-1'


		UPDATE
			DWH.DimInstrumentEtf
		SET
			SecurityType = I_upd.SecurityType,
			InstrumentStatusID = I_upd.InstrumentStatusID,
			InstrumentStatusDate = I_upd.InstrumentStatusDate,
			InstrumentListedDate = I_upd.InstrumentListedDate,
			CompanyListedDate = I_upd.CompanyListedDate,
			CompanyApprovalType = I_upd.CompanyApprovalType,
			CompanyApprovalDate = I_upd.CompanyApprovalDate,
			IssuerDomicile = I_upd.IssuerDomicile,
			WKN = I_upd.WKN,
			MNEM = I_upd.MNEM,
			PrimaryBusinessSector = I_upd.PrimaryBusinessSector,
			SubBusinessSector1 = I_upd.SubBusinessSector1,
			SubBusinessSector2 = I_upd.SubBusinessSector2,
			SubBusinessSector3 = I_upd.SubBusinessSector3,
			SubBusinessSector4 = I_upd.SubBusinessSector4,
			SubBusinessSector5 = I_upd.SubBusinessSector5,
			FinancialYearEndDate = I_upd.FinancialYearEndDate,
			IncorporationDate = I_upd.IncorporationDate,
			LegalStructure = I_upd.LegalStructure,
			AccountingStandard = I_upd.AccountingStandard,
			TransparencyDirectiveHomeMemberCountry = I_upd.TransparencyDirectiveHomeMemberCountry,
			ProspectusDirectiveHomeMemberCountry = I_upd.ProspectusDirectiveHomeMemberCountry,
			IssuerDomicileDomesticYN = I_upd.IssuerDomicileDomesticYN,
			FeeCodeName = I_upd.FeeCodeName,
			IssuedDate = I_upd.IssuedDate,
			CurrencyID = I_upd.CurrencyID,
			UnitOfQuotation = I_upd.UnitOfQuotation,
			QuotationCurrencyID = I_upd.QuotationCurrencyID,
			IssuerSedolMasterFileName = I_upd.IssuerSedolMasterFileName,
			InstrumentDomesticYN = I_upd.InstrumentDomesticYN,
			CFIName = I_upd.CFIName,
			CFICode = I_upd.CFICode,
			InstrumentSedolMasterFileName = I_upd.InstrumentSedolMasterFileName,
			LastEXDivDate = I_upd.LastEXDivDate,
			CompanyStatusID = I_upd.CompanyStatusID,
			Note = I_upd.Note
		FROM
				ETL.XtUpdateType XT
			INNER JOIN
				DWH.DimInstrumentEtf I
			ON XT.InstrumentGlobalID = I.InstrumentGlobalID
			INNER JOIN
				ETL.XtDimInstrument I_upd
			ON I.InstrumentGlobalID = I_upd.InstrumentGlobalID
		WHERE
			XT.UpdateType = 'SCD-1'



		COMMIT
	END TRY

	BEGIN CATCH
		PRINT 'NOT LOOKING GOOD!!!'

		ROLLBACK

	END CATCH
END
GO
