/* Run against old DHW to upgrade to new format */
/* Ian Meade 19/6/2017 */


/* 
Run this script on: 
 
        T7-DDT-06.DWH    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.DWH 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 19/06/2017 18:11:07 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [DWH]
GO
SET XACT_ABORT ON
GO

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [DWH].[FactCorporateAction]'
GO
ALTER TABLE [DWH].[FactCorporateAction] DROP CONSTRAINT [PK_FactCorporateAction]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [DWH].[FactDividend]'
GO
ALTER TABLE [DWH].[FactDividend] DROP CONSTRAINT [PK_FactDividend]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [DWH].[FactEquityIndex]'
GO
ALTER TABLE [DWH].[FactEquityIndex] DROP CONSTRAINT [PK_FactEquityIndex]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [DWH].[FactEquityPriceSnapshot]'
GO
ALTER TABLE [DWH].[FactEquityPriceSnapshot] DROP CONSTRAINT [PK_FactEquityPriceSnapshot]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [DWH].[FactEquitySnapshot]'
GO
ALTER TABLE [DWH].[FactEquitySnapshot] DROP CONSTRAINT [PK_FactEquitySnapshot]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [IX_FactEquityIndex] from [DWH].[FactEquityIndex]'
GO
DROP INDEX [IX_FactEquityIndex] ON [DWH].[FactEquityIndex]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [DWH].[FactEquitySnapshot]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [DWH].[FactEquitySnapshot] REBUILD PARTITION = ALL
WITH (DATA_COMPRESSION = PAGE) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FactEquitySnapshot_Clustered] on [DWH].[FactEquitySnapshot]'
GO
CREATE UNIQUE CLUSTERED INDEX [IX_FactEquitySnapshot_Clustered] ON [DWH].[FactEquitySnapshot] ([DateID], [InstrumentID], [EquitySnapshotID]) WITH (DATA_COMPRESSION = PAGE)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactEquitySnapshot] on [DWH].[FactEquitySnapshot]'
GO
ALTER TABLE [DWH].[FactEquitySnapshot] ADD CONSTRAINT [PK_FactEquitySnapshot] PRIMARY KEY NONCLUSTERED  ([EquitySnapshotID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Refreshing [ETL].[EquityIndexMarketCapHelper]'
GO
EXEC sp_refreshview N'[ETL].[EquityIndexMarketCapHelper]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [DWH].[FactEquityPriceSnapshot]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [DWH].[FactEquityPriceSnapshot] REBUILD PARTITION = ALL
WITH (DATA_COMPRESSION = PAGE) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactEquityPriceSnapshot] on [DWH].[FactEquityPriceSnapshot]'
GO
ALTER TABLE [DWH].[FactEquityPriceSnapshot] ADD CONSTRAINT [PK_FactEquityPriceSnapshot] PRIMARY KEY CLUSTERED  ([SampleDateID], [SampleTime], [InstrumentID]) WITH (DATA_COMPRESSION = PAGE)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[UpdateDimInstrument]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 24/5/2017   
-- Description:	Update DimInstrument and variants....   
-- =============================================   
ALTER PROCEDURE [ETL].[UpdateDimInstrument]   
AS   
BEGIN   
	-- SET NOCOUNT ON added to prevent extra result sets from   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
 
	DECLARE @BatchID INT 
	SELECT   
		@BatchID = DWH.GetBatchid() 
   
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
			/* SHOULDN'T NEED NEW BUT STORED PROCEDURE CAN BE CALLED TWICE */ 
			XT.UpdateType IN ( 'NEW', 'SCD-2' ) 
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
			/* SHOULDN'T NEED NEW BUT STORED PROCEDURE CAN BE CALLED TWICE */ 
			XT.UpdateType IN ( 'NEW', 'SCD-2' ) 
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
			/* SHOULDN'T NEED NEW BUT STORED PROCEDURE CAN BE CALLED TWICE */ 
			XT.UpdateType IN ( 'NEW', 'SCD-2' ) 
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
				@BatchID    
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
				@BatchID    
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
				@BatchID    
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
			InstrumentSedolMasterFileName = I_upd.InstrumentSedolMasterFileName, 
			BatchID = @BatchID 
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
			Note = I_upd.Note, 
			BatchID = @BatchID 
		FROM   
				ETL.XtUpdateType XT   
			INNER JOIN   
				DWH.DimInstrumentEquity I   
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
			Note = I_upd.Note, 
			BatchID = @BatchID  
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
		/* Pass error to ETL and roll back all changes */  
		DECLARE @ErrorMessage NVARCHAR(4000);    
		DECLARE @ErrorSeverity INT;    
		DECLARE @ErrorState INT;    
  
		SELECT     
			@ErrorMessage = ERROR_MESSAGE(),    
			@ErrorSeverity = ERROR_SEVERITY(),    
			@ErrorState = ERROR_STATE();    
  
  
		ROLLBACK   
		  
  
		-- Use RAISERROR inside the CATCH block to return error    
		-- information about the original error that caused    
		-- execution to jump to the CATCH block.    
		RAISERROR (@ErrorMessage, -- Message text.    
				   @ErrorSeverity, -- Severity.    
				   @ErrorState -- State.    
				   );    
  
   
	END CATCH   
END   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Refreshing [ETL].[EquityOfficalPrices]'
GO
EXEC sp_refreshview N'[ETL].[EquityOfficalPrices]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Refreshing [ETL].[EquityTradeLastTrade]'
GO
EXEC sp_refreshview N'[ETL].[EquityTradeLastTrade]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [DWH].[FactEquityIndex]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [DWH].[FactEquityIndex] REBUILD PARTITION = ALL
WITH (DATA_COMPRESSION = PAGE) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FactEquityIndex_ClusterIndex] on [DWH].[FactEquityIndex]'
GO
CREATE UNIQUE CLUSTERED INDEX [IX_FactEquityIndex_ClusterIndex] ON [DWH].[FactEquityIndex] ([IndexDateID], [IndexTimeID], [EquityIndexID]) WITH (DATA_COMPRESSION = PAGE)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactEquityIndex] on [DWH].[FactEquityIndex]'
GO
ALTER TABLE [DWH].[FactEquityIndex] ADD CONSTRAINT [PK_FactEquityIndex] PRIMARY KEY NONCLUSTERED  ([EquityIndexID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[UpdateFactEquitySnapshot]'
GO
      
ALTER PROCEDURE [ETL].[UpdateFactEquitySnapshot] AS       
/* UPDATE SNAPSHOT WITH LATEST TS SET OF CHANGES */    
/* DEFINED TO BE ONE DATE IN MERGE TABLE EACH TIME PRODCURE IS CALLED */    
    
BEGIN      
	SET NOCOUNT ON     
   
	/* MAKE NULLABLE FIELD 0 */   
	UPDATE   
		ETL.FactEquitySnapshotMerge    
	SET   
		Turnover = ISNULL(Turnover, 0),    
		TurnoverND = ISNULL(TurnoverND, 0),    
		TurnoverEur = ISNULL(TurnoverEur, 0),     
		TurnoverNDEur = ISNULL(TurnoverNDEur, 0),     
		TurnoverOB = ISNULL(TurnoverOB, 0),     
		TurnoverOBEur = ISNULL(TurnoverOBEur, 0),     
		Volume = ISNULL(Volume, 0),     
		VolumeND = ISNULL(VolumeND, 0),     
		VolumeOB = ISNULL(VolumeOB, 0),     
		Deals = ISNULL(Deals, 0),     
		DealsOB = ISNULL(DealsOB, 0),     
		DealsND = ISNULL(DealsND, 0)   
	    
	/* GET THE DATE AGGREGATION IS RUN FOR - DEFINED TO BE ONE DAY IN EACH PROCEDURE CALL */    
	DECLARE @DateID AS INT    
	SELECT    
		@DateID = MAX(DateID)    
	FROM    
		ETL.FactEquitySnapshotMerge    
	    
	IF @DateID = CAST(CONVERT(CHAR,GETDATE(),112) AS int)    
	BEGIN    
		/* UPDATING TODAYS SNAPSHOT */    
		/* Update existing and insert any new puppies */      
      
		UPDATE      
			DWH      
		SET      
			InstrumentID = E.InstrumentID,      
			InstrumentStatusID = E.InstrumentStatusID,      
			--DateID = E.DateID,      
			LastExDivDateID = E.LastExDivDateID,      
			OCPDateID = E.OCPDateID,      
			OCPTimeID = E.OCPTimeID,      
			OCPTime = E.OCPTime,      
			UtcOCPTime = E.UtcOCPTime,      
			OcpDateTime = E.OcpDateTime,   
			LTPDateID = E.LTPDateID,      
			LTPTimeID = E.LTPTimeID,      
			LTPTime = E.LTPTime,      
			UtcLTPTime = E.UtcLTPTime,   
			LtpDateTime = E.LtpDateTime,   
			MarketID = E.MarketID,      
			TotalSharesInIssue = E.TotalSharesInIssue,      
			IssuedSharesToday = E.IssuedSharesToday,      
			ExDivYN = E.ExDivYN,      
			OpenPrice = E.OpenPrice,      
			LowPrice = E.LowPrice,      
			HighPrice = E.HighPrice,      
			BidPrice = E.BidPrice,      
			OfferPrice = E.OfferPrice,      
			ClosingAuctionBidPrice = E.ClosingAuctionBidPrice,      
			ClosingAuctionOfferPrice = E.ClosingAuctionOfferPrice,      
			OCP = E.OCP,      
			LTP = E.LTP,      
			MarketCap = E.MarketCap,      
			MarketCapEur = E.MarketCapEur,      
			Turnover = E.Turnover,      
			TurnoverND = E.TurnoverND,      
			TurnoverEur = E.TurnoverEur,      
			TurnoverNDEur = E.TurnoverNDEur,      
			TurnoverOB = E.TurnoverOB,      
			TurnoverOBEur = E.TurnoverOBEur,      
			Volume = E.Volume,      
			VolumeND = E.VolumeND,      
			VolumeOB = E.VolumeOB,      
			Deals = E.Deals,      
			DealsOB = E.DealsOB,      
			DealsND = E.DealsND,      
			ISEQ20Shares = E.ISEQ20Shares,      
			ISEQ20Price = E.ISEQ20Price,      
			ISEQ20Weighting = E.ISEQ20Weighting,      
			ISEQ20MarketCap = E.ISEQ20MarketCap,      
			ISEQ20FreeFloat = E.ISEQ20FreeFloat,      
			ISEQOverallWeighting = E.ISEQOverallWeighting,      
			ISEQOverallMarketCap = E.TotalSharesInIssue * E.ISEQOverallFreefloat * E.ISEQOverallPrice,     
			ISEQOverallBeta30 = E.ISEQOverallBeta30,      
			ISEQOverallBeta250 = E.ISEQOverallBeta250,      
			ISEQOverallFreefloat = E.ISEQOverallFreefloat,      
			ISEQOverallPrice = E.ISEQOverallPrice,      
			ISEQOverallShares = E.ISEQOverallShares,      
			OverallIndexYN = E.OverallIndexYN,      
			GeneralIndexYN = E.GeneralIndexYN,      
			FinancialIndexYN = E.FinancialIndexYN,      
			SmallCapIndexYN = E.SmallCapIndexYN,      
			ITEQIndexYN = E.ITEQIndexYN,      
			ISEQ20IndexYN = E.ISEQ20IndexYN,      
			ESMIndexYN = E.ESMIndexYN,      
			ExCapYN = E.ExCapYN,      
			ExEntitlementYN = E.ExEntitlementYN,      
			ExRightsYN = E.ExRightsYN,      
			ExSpecialYN = E.ExSpecialYN,      
			PrimaryMarket = E.PrimaryMarket,      
			LseTurnover = E.LseTurnover,     
			LseVolume = E.LseVolume,     
			ETFFMShares = E.ETFFMShares,     
			BatchID = E.BatchID      
		FROM      
				DWH.FactEquitySnapshot DWH      
			INNER JOIN      
				DWH.DimInstrumentEquity I      
			ON DWH.InstrumentID = I.InstrumentID      
			INNER JOIN		      
				ETL.FactEquitySnapshotMerge E      
			ON       
				I.InstrumentGlobalID = E.InstrumentGlobalID    
			AND      
				DWH.DateID = E.DateID      
	END    
	ELSE    
	BEGIN    
		/* UPDATING AN OLDER SNAPSHOT */    
		/* Only update soem fields */      
      
		UPDATE      
			DWH      
		SET      
			--InstrumentID = E.CurrentInstrumentID,      
			--InstrumentStatusID = E.InstrumentStatusID,      
			--DateID = E.DateID,      
			--LastExDivDateID = E.LastExDivDateID,      
			OCPDateID = E.OCPDateID,      
			OCPTimeID = E.OCPTimeID,      
			OCPTime = E.OCPTime,      
			UtcOCPTime = E.UtcOCPTime,      
			OcpDateTime = E.OcpDateTime,   
			LTPDateID = E.LTPDateID,      
			LTPTimeID = E.LTPTimeID,      
			LTPTime = E.LTPTime,      
			UtcLTPTime = E.UtcLTPTime,      
			LtpDateTime = E.LtpDateTime,   
			MarketID = E.MarketID,      
			--TotalSharesInIssue = E.TotalSharesInIssue,      
			--IssuedSharesToday = E.IssuedSharesToday,      
			--ExDivYN = E.ExDivYN,      
			OpenPrice = E.OpenPrice,      
			LowPrice = E.LowPrice,      
			HighPrice = E.HighPrice,      
			BidPrice = E.BidPrice,      
			OfferPrice = E.OfferPrice,      
			ClosingAuctionBidPrice = E.ClosingAuctionBidPrice,      
			ClosingAuctionOfferPrice = E.ClosingAuctionOfferPrice,      
			OCP = E.OCP,      
			LTP = E.LTP,      
			--MarketCap = E.MarketCap,      
			--MarketCapEur = E.MarketCapEur,      
			Turnover = E.Turnover,      
			TurnoverND = E.TurnoverND,      
			TurnoverEur = E.TurnoverEur,      
			TurnoverNDEur = E.TurnoverNDEur,      
			TurnoverOB = E.TurnoverOB,      
			TurnoverOBEur = E.TurnoverOBEur,      
			Volume = E.Volume,      
			VolumeND = E.VolumeND,      
			VolumeOB = E.VolumeOB,      
			Deals = E.Deals,      
			DealsOB = E.DealsOB,      
			DealsND = E.DealsND,      
			/* Probably not...    
			ISEQ20Shares = E.ISEQ20Shares,      
			ISEQ20Price = E.ISEQ20Price,      
			ISEQ20Weighting = E.ISEQ20Weighting,      
			ISEQ20MarketCap = E.ISEQ20MarketCap,      
			ISEQ20FreeFloat = E.ISEQ20FreeFloat,      
			ISEQOverallWeighting = E.ISEQOverallWeighting,      
			ISEQOverallMarketCap = E.TotalSharesInIssue * E.ISEQOverallFreefloat * E.ISEQOverallPrice,     
			ISEQOverallBeta30 = E.ISEQOverallBeta30,      
			ISEQOverallBeta250 = E.ISEQOverallBeta250,      
			ISEQOverallFreefloat = E.ISEQOverallFreefloat,      
			ISEQOverallPrice = E.ISEQOverallPrice,      
			ISEQOverallShares = E.ISEQOverallShares,      
			*/    
			/* From XT ....    
			OverallIndexYN = E.OverallIndexYN,      
			GeneralIndexYN = E.GeneralIndexYN,      
			FinancialIndexYN = E.FinancialIndexYN,      
			SmallCapIndexYN = E.SmallCapIndexYN,      
			ITEQIndexYN = E.ITEQIndexYN,      
			ISEQ20IndexYN = E.ISEQ20IndexYN,      
			ESMIndexYN = E.ESMIndexYN,      
			ExCapYN = E.ExCapYN,      
			ExEntitlementYN = E.ExEntitlementYN,      
			ExRightsYN = E.ExRightsYN,      
			ExSpecialYN = E.ExSpecialYN,      
			PrimaryMarket = E.PrimaryMarket,      
			*/    
			LseTurnover = E.LseTurnover,     
			LseVolume = E.LseVolume,     
			ETFFMShares = E.ETFFMShares,     
   
			BatchID = E.BatchID      
		FROM      
				DWH.FactEquitySnapshot DWH      
			INNER JOIN      
				DWH.DimInstrumentEquity I      
			ON DWH.InstrumentID = I.InstrumentID      
			INNER JOIN		      
				ETL.FactEquitySnapshotMerge E      
			ON       
				I.InstrumentGlobalID = E.InstrumentGlobalID    
			AND      
				DWH.DateID = E.DateID      
	    
	    
	END    
	      
      
	INSERT INTO      
			DWH.FactEquitySnapshot      
		(      
			InstrumentID,      
			InstrumentStatusID,      
			DateID,      
			LastExDivDateID,      
			OCPDateID,      
			OCPTimeID,      
			OCPTime,      
			UtcOCPTime,      
			OcpDateTime,   
			LTPDateID,      
			LTPTimeID,      
			LTPTime,      
			UtcLTPTime,      
			LtpDateTime,   
			MarketID,      
			TotalSharesInIssue,      
			IssuedSharesToday,      
			ExDivYN,      
			OpenPrice,      
			LowPrice,      
			HighPrice,      
			BidPrice,      
			OfferPrice,      
			ClosingAuctionBidPrice,      
			ClosingAuctionOfferPrice,      
			OCP,      
			LTP,      
			MarketCap,      
			MarketCapEur,      
			Turnover,      
			TurnoverND,      
			TurnoverEur,      
			TurnoverNDEur,      
			TurnoverOB,      
			TurnoverOBEur,      
			Volume,      
			VolumeND,      
			VolumeOB,      
			Deals,      
			DealsOB,      
			DealsND,      
			ISEQ20Shares,      
			ISEQ20Price,      
			ISEQ20Weighting,      
			ISEQ20MarketCap,      
			ISEQ20FreeFloat,      
			ISEQOverallWeighting,      
			ISEQOverallMarketCap,      
			ISEQOverallBeta30,      
			ISEQOverallBeta250,      
			ISEQOverallFreefloat,      
			ISEQOverallPrice,      
			ISEQOverallShares,      
			OverallIndexYN,      
			GeneralIndexYN,      
			FinancialIndexYN,      
			SmallCapIndexYN,      
			ITEQIndexYN,      
			ISEQ20IndexYN,      
			ESMIndexYN,      
			ExCapYN,      
			ExEntitlementYN,      
			ExRightsYN,      
			ExSpecialYN,      
			PrimaryMarket,      
			LseTurnover,     
			LseVolume,     
			ETFFMShares,     
			BatchID      
		)      
		SELECT      
			InstrumentID,      
			InstrumentStatusID,      
			DateID,      
			LastExDivDateID,      
			OCPDateID,      
			OCPTimeID,      
			OCPTime,      
			UtcOCPTime,      
			OcpDateTime,   
			LTPDateID,      
			LTPTimeID,      
			LTPTime,      
			UtcLTPTime,     
			OcpDateTime,    
			MarketID,      
			TotalSharesInIssue,      
			IssuedSharesToday,      
			ExDivYN,      
			OpenPrice,      
			LowPrice,      
			HighPrice,      
			BidPrice,      
			OfferPrice,      
			ClosingAuctionBidPrice,      
			ClosingAuctionOfferPrice,      
			OCP,      
			LTP,      
			MarketCap,      
			MarketCapEur,      
			ISNULL(Turnover, 0),    
			ISNULL(TurnoverND, 0),    
			ISNULL(TurnoverEur, 0),    
			ISNULL(TurnoverNDEur, 0),    
			ISNULL(TurnoverOB, 0),    
			ISNULL(TurnoverOBEur, 0),     
			ISNULL(Volume, 0),    
			ISNULL(VolumeND, 0),    
			ISNULL(VolumeOB, 0),    
			ISNULL(Deals, 0),    
			ISNULL(DealsOB, 0),    
			ISNULL(DealsND, 0),    
			ISEQ20Shares,      
			ISEQ20Price,      
			ISEQ20Weighting,      
			ISEQ20MarketCap,      
			ISEQ20FreeFloat,      
			ISEQOverallWeighting,      
			TotalSharesInIssue * ISEQOverallFreefloat * ISEQOverallPrice,     
			ISEQOverallBeta30,      
			ISEQOverallBeta250,      
			ISEQOverallFreefloat,      
			ISEQOverallPrice,      
			ISEQOverallShares,      
			OverallIndexYN,      
			GeneralIndexYN,      
			FinancialIndexYN,      
			SmallCapIndexYN,      
			ITEQIndexYN,      
			ISEQ20IndexYN,      
			ESMIndexYN,      
			ExCapYN,      
			ExEntitlementYN,      
			ExRightsYN,      
			ExSpecialYN,      
			PrimaryMarket,      
			LseTurnover,     
			LseVolume,     
			ETFFMShares,     
			BatchID      
		FROM      
			ETL.FactEquitySnapshotMerge E      
		WHERE      
			NOT EXISTS (      
					SELECT      
						*      
					FROM	      
							DWH.FactEquitySnapshot DWH      
						INNER JOIN      
							DWH.DimInstrumentEquity I      
						ON DWH.InstrumentID = I.InstrumentID      
					WHERE      
							I.InstrumentGlobalID = E.InstrumentGlobalID    
						AND      
							DWH.DateID = E.DateID      
				)			      
      
	/* UODATE IssuedSharesToday */ 
 
	UPDATE    
		DWH    
	SET    
		IssuedSharesToday = DWH.TotalSharesInIssue - PREV.TotalSharesInIssue    
	FROM    
			DWH.FactEquitySnapshot DWH     
		INNER JOIN     
			DWH.DimInstrumentEquity I     
		ON DWH.InstrumentID = I.InstrumentID     
		CROSS APPLY (    
					SELECT    
						TOP 1    
						DWH_Inside.TotalSharesInIssue    
					FROM    
							DWH.FactEquitySnapshot DWH_Inside 
						INNER JOIN     
							DWH.DimInstrumentEquity I_Inside    
						ON DWH_Inside.InstrumentID = I_Inside.InstrumentID     
					WHERE    
							I.InstrumentGlobalID = I_Inside.InstrumentGlobalID 
						AND 
							DWH_Inside.TotalSharesInIssue IS NOT NULL    
						AND    
							DWH.DateID > DWH_Inside.DateID    
					ORDER BY    
						DWH_Inside.DateID DESC    
				) AS PREV    
			    
END      
    
    
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[UpdateFactEtfSnapshot]'
GO
    
     
ALTER PROCEDURE [ETL].[UpdateFactEtfSnapshot]    
	@WISDOM_ISIN VARCHAR(12)   
AS      
     
BEGIN     
	SET NOCOUNT ON    
   
	/* MAKE NULLABLE FIELD 0 */   
	UPDATE   
		ETL.FactEtfSnapshotMerge    
	SET   
		Turnover = ISNULL(Turnover, 0),    
		TurnoverND = ISNULL(TurnoverND, 0),    
		TurnoverEur = ISNULL(TurnoverEur, 0),     
		TurnoverNDEur = ISNULL(TurnoverNDEur, 0),     
		TurnoverOB = ISNULL(TurnoverOB, 0),     
		TurnoverOBEur = ISNULL(TurnoverOBEur, 0),     
		Volume = ISNULL(Volume, 0),     
		VolumeND = ISNULL(VolumeND, 0),     
		VolumeOB = ISNULL(VolumeOB, 0),     
		Deals = ISNULL(Deals, 0),     
		DealsOB = ISNULL(DealsOB, 0),     
		DealsND = ISNULL(DealsND, 0)   
     
 	/* GET THE DATE AGGREGATION IS RUN FOR - DEFINED TO BE ONE DAY IN EACH PROCEDURE CALL */    
	DECLARE @DateID AS INT    
	SELECT    
		@DateID = MAX(DateID)    
	FROM    
		ETL.FactEquitySnapshotMerge    
	    
	IF @DateID = CAST(CONVERT(CHAR,GETDATE(),112) AS int)    
	BEGIN    
		/* UPDATING TODAYS SNAPSHOT */    
		/* Update existing and insert any new puppies */      
    
		UPDATE     
			DWH     
		SET     
			InstrumentID = E.InstrumentID,     
			InstrumentStatusID = E.InstrumentStatusID,     
			DateID = E.AggregationDateID,     
	--		LastExDivDateID = E.LastExDivDateID,     
			OCPDateID = E.OCPDateID,     
			OCPTimeID = E.OCPTimeID,     
			OCPTime = E.OCPTime,     
			UtcOCPTime = E.UtcOCPTime,     
			OcpDateTime = E.OcpDateTime,   
			LTPDateID = E.LTPDateID,     
			LTPTimeID = E.LTPTimeID,     
			LTPTime = E.LTPTime,     
			UtcLTPTime = E.UtcLTPTime,     
			LtpDateTime = E.LtpDateTime,   
			/*    
			MarketID = E.MarketID,     
			*/    
	--		TotalSharesInIssue = E.TotalSharesInIssue,     
			--IssuedSharesToday = E.IssuedSharesToday,     
			--ExDivYN = E.ExDivYN,     
			OpenPrice = E.OpenPrice,     
			LowPrice = E.LowPrice,     
			HighPrice = E.HighPrice,     
			BidPrice = E.BidPrice,     
			OfferPrice = E.OfferPrice,     
			ClosingAuctionBidPrice = E.ClosingAuctionBidPrice,     
			ClosingAuctionOfferPrice = E.ClosingAuctionOfferPrice,     
			OCP = E.OpenPrice,     
			LTP = E.LastPrice,     
			MarketCap = E.MarketCap,     
			MarketCapEur = E.MarketCapEur,     
			Turnover = E.Turnover,     
			TurnoverND = E.TurnoverND,     
			TurnoverEur = E.TurnoverEur,     
			TurnoverNDEur = E.TurnoverNDEur,     
			TurnoverOB = E.TurnoverOB,     
			TurnoverOBEur = E.TurnoverOBEur,     
			Volume = E.Volume,     
			VolumeND = E.VolumeND,     
			VolumeOB = E.VolumeOB,     
			Deals = E.Deals,     
			DealsOB = E.DealsOB,     
			DealsND = E.DealsND,     
			/* NOT NEEDED FOR ETF */    
			/*    
			ISEQ20Shares = E.ISEQ20Shares,     
			ISEQ20Price = E.ISEQ20Price,     
			ISEQ20Weighting = E.ISEQ20Weighting,     
			ISEQ20MarketCap = E.ISEQ20MarketCap,     
			ISEQ20FreeFloat = E.ISEQ20FreeFloat,     
			ISEQOverallWeighting = E.ISEQOverallWeighting,     
			ISEQOverallMarketCap = E.ISEQOverallMarketCap,     
			ISEQOverallBeta30 = E.ISEQOverallBeta30,     
			ISEQOverallBeta250 = E.ISEQOverallBeta250,     
			ISEQOverallFreefloat = E.ISEQOverallFreefloat,     
			ISEQOverallPrice = E.ISEQOverallPrice,     
			ISEQOverallShares = E.ISEQOverallShares,     
			*/    
			OverallIndexYN = E.OverallIndexYN,     
			GeneralIndexYN = E.GeneralIndexYN,     
			FinancialIndexYN = E.FinancialIndexYN,     
			SmallCapIndexYN = E.SmallCapIndexYN,     
			ITEQIndexYN = E.ITEQIndexYN,     
			ISEQ20IndexYN = E.ISEQ20IndexYN,     
			ESMIndexYN = E.ESMIndexYN,     
			--ExCapYN = E.ExCapYN,     
			--ExEntitlementYN = E.ExEntitlementYN,     
			--ExRightsYN = E.ExRightsYN,     
			--ExSpecialYN = E.ExSpecialYN,     
			PrimaryMarket = E.PrimaryMarket,     
			BatchID = E.BatchID     
		FROM     
				DWH.FactEtfSnapshot DWH     
			INNER JOIN     
				DWH.DimInstrumentEtf I     
			ON DWH.InstrumentID = I.InstrumentID     
			INNER JOIN		     
				ETL.FactEtfSnapshotMerge E     
			ON      
				I.InstrumentGlobalID = E.InstrumentGlobalID    
			AND     
				DWH.DateID = E.AggregationDateID    
	END    
	ELSE    
	BEGIN    
		UPDATE     
			DWH     
		SET     
			InstrumentID = E.InstrumentID,     
			InstrumentStatusID = E.InstrumentStatusID,     
			DateID = E.AggregationDateID,     
	--		LastExDivDateID = E.LastExDivDateID,     
			OCPDateID = E.OCPDateID,     
			OCPTimeID = E.OCPTimeID,     
			OCPTime = E.OCPTime,     
			OcpDateTime = E.OcpDateTime,   
			UtcOCPTime = E.UtcOCPTime,     
			LTPDateID = E.LTPDateID,     
			LTPTimeID = E.LTPTimeID,     
			LTPTime = E.LTPTime,     
			UtcLTPTime = E.UtcLTPTime,     
			LtpDateTime = E.LtpDateTime,   
			/*    
			MarketID = E.MarketID,     
			*/    
	--		TotalSharesInIssue = E.TotalSharesInIssue,     
			--IssuedSharesToday = E.IssuedSharesToday,     
			--ExDivYN = E.ExDivYN,     
			OpenPrice = E.OpenPrice,     
			LowPrice = E.LowPrice,     
			HighPrice = E.HighPrice,     
			BidPrice = E.BidPrice,     
			OfferPrice = E.OfferPrice,     
			ClosingAuctionBidPrice = E.ClosingAuctionBidPrice,     
			ClosingAuctionOfferPrice = E.ClosingAuctionOfferPrice,     
			OCP = E.OpenPrice,     
			LTP = E.LastPrice,     
			MarketCap = E.MarketCap,     
			MarketCapEur = E.MarketCapEur,     
			Turnover = E.Turnover,     
			TurnoverND = E.TurnoverND,     
			TurnoverEur = E.TurnoverEur,     
			TurnoverNDEur = E.TurnoverNDEur,     
			TurnoverOB = E.TurnoverOB,     
			TurnoverOBEur = E.TurnoverOBEur,     
			Volume = E.Volume,     
			VolumeND = E.VolumeND,     
			VolumeOB = E.VolumeOB,     
			Deals = E.Deals,     
			DealsOB = E.DealsOB,     
			DealsND = E.DealsND,     
			/* NOT NEEDED FOR ETF */    
			/*    
			ISEQ20Shares = E.ISEQ20Shares,     
			ISEQ20Price = E.ISEQ20Price,     
			ISEQ20Weighting = E.ISEQ20Weighting,     
			ISEQ20MarketCap = E.ISEQ20MarketCap,     
			ISEQ20FreeFloat = E.ISEQ20FreeFloat,     
			ISEQOverallWeighting = E.ISEQOverallWeighting,     
			ISEQOverallMarketCap = E.ISEQOverallMarketCap,     
			ISEQOverallBeta30 = E.ISEQOverallBeta30,     
			ISEQOverallBeta250 = E.ISEQOverallBeta250,     
			ISEQOverallFreefloat = E.ISEQOverallFreefloat,     
			ISEQOverallPrice = E.ISEQOverallPrice,     
			ISEQOverallShares = E.ISEQOverallShares,     
			*/    
	/*    
    
			OverallIndexYN = E.OverallIndexYN,     
			GeneralIndexYN = E.GeneralIndexYN,     
			FinancialIndexYN = E.FinancialIndexYN,     
			SmallCapIndexYN = E.SmallCapIndexYN,     
			ITEQIndexYN = E.ITEQIndexYN,     
			ISEQ20IndexYN = E.ISEQ20IndexYN,     
			ESMIndexYN = E.ESMIndexYN,     
	*/    
			--ExCapYN = E.ExCapYN,     
			--ExEntitlementYN = E.ExEntitlementYN,     
			--ExRightsYN = E.ExRightsYN,     
			--ExSpecialYN = E.ExSpecialYN,     
			/*    
			PrimaryMarket = E.PrimaryMarket,     
			*/    
			BatchID = E.BatchID     
		FROM     
				DWH.FactEtfSnapshot DWH     
			INNER JOIN     
				DWH.DimInstrumentEtf I     
			ON DWH.InstrumentID = I.InstrumentID     
			INNER JOIN		     
				ETL.FactEtfSnapshotMerge E     
			ON      
				I.InstrumentGlobalID = E.InstrumentGlobalID    
			AND     
				DWH.DateID = E.AggregationDateID    
	    
	END     
     
    
	INSERT INTO     
			DWH.FactEtfSnapshot     
		(     
			InstrumentID,     
			InstrumentStatusID,     
			DateID,     
--			LastExDivDateID,     
			OCPDateID,     
			OCPTimeID,     
			OCPTime,     
			UtcOCPTime,     
			OcpDateTime,   
			LTPDateID,     
			LTPTimeID,     
			LTPTime,     
			UtcLTPTime,     
			LtpDateTime,   
			MarketID,     
--			TotalSharesInIssue,     
--			IssuedSharesToday,     
--			ExDivYN,     
			OpenPrice,     
			LowPrice,     
			HighPrice,     
			BidPrice,     
			OfferPrice,     
			ClosingAuctionBidPrice,     
			ClosingAuctionOfferPrice,     
			OCP,     
			LTP,     
			MarketCap,     
			MarketCapEur,     
			Turnover,     
			TurnoverND,     
			TurnoverEur,     
			TurnoverNDEur,     
			TurnoverOB,     
			TurnoverOBEur,     
			Volume,     
			VolumeND,     
			VolumeOB,     
			Deals,     
			DealsOB,     
			DealsND,     
    
/*    
			ISEQ20Shares,     
			ISEQ20Price,     
			ISEQ20Weighting,     
			ISEQ20MarketCap,     
			ISEQ20FreeFloat,     
*/    
/*    
			ISEQOverallWeighting,     
			ISEQOverallMarketCap,     
			ISEQOverallBeta30,     
			ISEQOverallBeta250,     
			ISEQOverallFreefloat,     
			ISEQOverallPrice,     
			ISEQOverallShares,     
*/    
			OverallIndexYN,     
			GeneralIndexYN,     
			FinancialIndexYN,     
			SmallCapIndexYN,     
			ITEQIndexYN,     
			ISEQ20IndexYN,     
			ESMIndexYN,     
--			ExCapYN,     
--			ExEntitlementYN,     
--			ExRightsYN,     
--			ExSpecialYN,     
			PrimaryMarket,     
			BatchID     
		)     
		SELECT     
			InstrumentID,     
			InstrumentStatusID,     
			AggregationDateID,     
--			LastExDivDateID,     
			OCPDateID,     
			OCPTimeID,     
			OCPTime,     
			UtcOCPTime,     
			OcpDateTime,   
			LTPDateID,     
			LTPTimeID,     
			LTPTime,     
			UtcLTPTime,     
			LtpDateTime,   
			MarketID,     
--			TotalSharesInIssue,     
--			IssuedSharesToday,     
--			ExDivYN,     
			OpenPrice,     
			LowPrice,     
			HighPrice,     
			BidPrice,     
			OfferPrice,     
			ClosingAuctionBidPrice,     
			ClosingAuctionOfferPrice,     
			OpenPrice,    
			LastPrice,    
			MarketCap,     
			MarketCapEur,     
			ISNULL(Turnover, 0),    
			ISNULL(TurnoverND, 0),    
			ISNULL(TurnoverEur, 0),     
			ISNULL(TurnoverNDEur, 0),     
			ISNULL(TurnoverOB, 0),     
			ISNULL(TurnoverOBEur, 0),     
			ISNULL(Volume, 0),     
			ISNULL(VolumeND, 0),     
			ISNULL(VolumeOB, 0),     
			ISNULL(Deals, 0),     
			ISNULL(DealsOB, 0),     
			ISNULL(DealsND, 0),     
    
/*    
			ISEQ20Shares,     
			ISEQ20Price,     
			ISEQ20Weighting,     
			ISEQ20MarketCap,     
			ISEQ20FreeFloat,     
*/    
/*    
			ISEQOverallWeighting,     
			ISEQOverallMarketCap,     
			ISEQOverallBeta30,     
			ISEQOverallBeta250,     
			ISEQOverallFreefloat,     
			ISEQOverallPrice,     
			ISEQOverallShares,     
*/    
			OverallIndexYN,     
			GeneralIndexYN,     
			FinancialIndexYN,     
			SmallCapIndexYN,     
			ITEQIndexYN,     
			ISEQ20IndexYN,     
			ESMIndexYN,     
--			ExCapYN,     
--			ExEntitlementYN,     
--			ExRightsYN,     
--			ExSpecialYN,     
			PrimaryMarket,     
			BatchID     
		FROM     
			ETL.FactEtfSnapshotMerge E     
		WHERE     
			NOT EXISTS (     
					SELECT     
						*     
					FROM	     
							DWH.FactEtfSnapshot DWH     
						INNER JOIN     
							DWH.DimInstrumentEtf I     
						ON DWH.InstrumentID = I.InstrumentID     
					WHERE     
							I.InstrumentGlobalID = E.InstrumentGlobalID    
						AND     
							DWH.DateID = E.AggregationDateID    
				)			     
    
     
     
	/* SPECIAL UPDATE FOR WISDOM TREE */    
    
	/* Table used to capture the IDs of changed row - used ot update ETFSharesInIssue */    
	DECLARE @WisdomTreeUpdates TABLE ( EtfSnapshotID INT )    
    
	/* MAIN UPDATE OF ETF VALUES */    
	/* - ASSUMES DATA HAS BEEN CORRECTLY STAGED */    
	/* - INCLKUDES OUTPUT CLAUSE TO ALLOW UPDATE OF SHARES ISSUES TODAY */    
	    
	UPDATE    
		DWH    
	SET    
		NAVCalcDateID = DWH.DateID,    
		NAV = ODS.NAV_per_unit,    
		ETFSharesInIssue = ODS.Units_In_Issue    
	OUTPUT    
		inserted.EtfSnapshotID INTO @WisdomTreeUpdates    
	FROM    
			ETL.FactEtfSnapshotMerge E     
		INNER JOIN    
			DWH.FactEtfSnapshot DWH     
		on E.AggregationDateID = DWH.DateID    
		INNER JOIN     
			DWH.DimInstrumentEtf I     
		ON DWH.InstrumentID = I.InstrumentID     
		INNER JOIN    
			ETL.StateStreet_ISEQ20_NAV ODS    
		ON E.AggregationDateID = ODS.ValuationDateID    
	WHERE    
		I.ISIN = @WISDOM_ISIN    
		    
	/* WISDOM TREE UPDATE */ 
	UPDATE    
		DWH    
	SET    
		IssuedSharesToday = DWH.ETFSharesInIssue - PREV.ETFSharesInIssue    
	FROM    
			@WisdomTreeUpdates U    
		INNER JOIN    
			DWH.FactEtfSnapshot DWH     
		ON U.EtfSnapshotID = DWH.EtfSnapshotID    
		INNER JOIN     
			DWH.DimInstrumentEtf I     
		ON DWH.InstrumentID = I.InstrumentID     
		CROSS APPLY (    
					SELECT    
						TOP 1    
						ETFSharesInIssue    
					FROM    
							DWH.FactEtfSnapshot DWH_Inside 
						INNER JOIN     
							DWH.DimInstrumentEtf I2     
						ON DWH_Inside.InstrumentID = I2.InstrumentID     
					WHERE    
							I2.ISIN = @WISDOM_ISIN    
						AND    
							DWH_Inside.ETFSharesInIssue IS NOT NULL    
						AND    
							DWH.DateID > DWH_Inside.DateID    
					ORDER BY    
						DWH_Inside.DateID DESC    
				) AS PREV    
	WHERE    
		I.ISIN = @WISDOM_ISIN    
 
	/* GENERIC UPATE / ALL NON WISDOM TREE UPDATES */ 
	/* SAME AS ABVOIE BUT DIFFERNET FILTER - KEEPNG SEPERATE INCASE THESE NEED TO CHANGE */ 
	UPDATE    
		DWH    
	SET    
		IssuedSharesToday = DWH.ETFSharesInIssue - PREV.ETFSharesInIssue    
	FROM    
			DWH.FactEtfSnapshot DWH     
		INNER JOIN     
			DWH.DimInstrumentEtf I     
		ON DWH.InstrumentID = I.InstrumentID     
		CROSS APPLY (    
					SELECT    
						TOP 1    
						ETFSharesInIssue    
					FROM    
							DWH.FactEtfSnapshot DWH_Inside 
						INNER JOIN     
							DWH.DimInstrumentEtf I_Inside     
						ON DWH_Inside.InstrumentID = I_Inside.InstrumentID     
					WHERE    
							I.InstrumentGlobalID = I_Inside.InstrumentGlobalID 
						AND    
							DWH_Inside.ETFSharesInIssue IS NOT NULL    
						AND    
							DWH.DateID > DWH_Inside.DateID    
					ORDER BY    
						DWH_Inside.DateID DESC    
				) AS PREV    
	WHERE    
		I.ISIN = @WISDOM_ISIN    
			    
    
END     
    
    
    
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[AggrgeateFactEquityIndex]'
GO
-- =============================================    
-- Author:		Ian Meade    
-- Create date: 25/4/2017    
-- Description:	Aggregate the Equity Indexes - for upodate to FactEquityIndexSnapshot    
--				Note: cannot call storted proecedure dirrectly from SSIS due to meta-data issue - populating tbale for next step    
-- =============================================    
ALTER PROCEDURE [ETL].[AggrgeateFactEquityIndex]    
	@IndexDateID INT, 
	@ExpectedTime DATETIME 
AS    
BEGIN    
	SET NOCOUNT ON;    
    
	DECLARE @TimeID INT  
 
	SELECT 
		@TimeID = CAST(LEFT(REPLACE( CONVERT(CHAR, GETDATE(), 114), ':', ''),4) AS INT) 
 
 
   /* FIND LAST INDX SAMPLE FOR REQUIRED DATE */ 
 
	SELECT 
		MAX(EquityIndexID) AS EquityIndexID 
	INTO    
		#Samples    
	FROM 
		DWH.FactEquityIndex 
	WHERE 
		IndexDateID = @IndexDateID 
	AND 
		IndexTimeID = ( 
					SELECT				 
						MAX(IndexTimeID) 
					FROM 
						DWH.FactEquityIndex 
					WHERE 
						IndexDateID = @IndexDateID 
					AND 
						IndexTimeID < @TimeID 
				); 
 
	 /* Get Open values in #FIRST tmep table */   
	 /* Get Last & Return in #LAST tnep table */   
	 /* Gets gih and low in #AGG temp table */   
     
	WITH RowBased AS (    
			SELECT    
				I.IndexDateID,    
				OverallOpen,    
				FinancialOpen,    
				GeneralOpen,    
				SmallCapOpen,    
				ITEQOpen,    
				ISEQ20Open,    
				ISEQ20INAVOpen,    
				ESMopen,    
				ISEQ20InverseOpen,    
				ISEQ20LeveragedOpen,    
				ISEQ20CappedOpen    
			FROM    
					DWH.FactEquityIndex I    
				INNER JOIN    
					#Samples S    
				ON    
					I.EquityIndexID = S.EquityIndexID   
			)    
		SELECT    
			IndexDateID,    
			'IEOP' AS IndexCode,    
			OverallOpen AS OpenValue    
		INTO     
			#FIRST    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEUP' AS IndexCode,    
			FinancialOpen AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEQP' AS IndexCode,    
			GeneralOpen AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEYP' AS IndexCode,    
			SmallCapOpen AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEEP' AS IndexCode,    
			ISEQ20Open AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOA' AS IndexCode,    
			ESMopen AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOD' AS IndexCode,    
			ISEQ20InverseOpen AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOC' AS IndexCode,    
			ISEQ20LeveragedOpen AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IE0E' AS IndexCode,    
			ISEQ20CappedOpen AS OpenValue    
		FROM    
			RowBased;    
    
	WITH RowBased AS (    
			SELECT    
				I.IndexDateID,    
				OverallLast,    
				FinancialLast,    
				GeneralLast,    
				SmallCapLast,    
				ITEQLast,    
				ISEQ20Last,    
				ISEQ20INAVLast,    
				ESMLast,    
				ISEQ20InverseLast,    
				ISEQ20LeveragedLast,    
				ISEQ20CappedLast,    
				OverallReturn,    
				FinancialReturn,    
				GeneralReturn,    
				SmallCapReturn,    
				ITEQReturn,    
				ISEQ20Return,    
				NULL AS ISEQ20INAVReturn,    
				ESMReturn,    
				ISEQ20InverseReturn,    
				ISEQ20CappedReturn    
			FROM    
					DWH.FactEquityIndex I    
				INNER JOIN    
					#Samples S    
				ON I.EquityIndexID = S.EquityIndexID    
			)    
		SELECT    
			IndexDateID,    
			'IEOP' AS IndexCode,    
			OverallLast AS LastValue,    
			OverallReturn AS ReturnValue    
		INTO #LAST    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEUP' AS IndexCode,    
			FinancialLast AS LastValue,    
			FinancialReturn AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEQP' AS IndexCode,    
			GeneralLast AS LastValue,    
			GeneralReturn AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEYP' AS IndexCode,    
			SmallCapLast AS LastValue,    
			SmallCapReturn AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEEP' AS IndexCode,    
			ISEQ20Last AS LastValue,    
			ISEQ20Return AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOA' AS IndexCode,    
			ESMLast AS LastValue,    
			ESMReturn AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOD' AS IndexCode,    
			ISEQ20InverseLast AS LastValue,    
			ISEQ20InverseReturn AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOC' AS IndexCode,    
			ISEQ20LeveragedLast AS LastValue,    
			NULL AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOE' AS IndexCode,    
			ISEQ20CappedLast AS LastValue,    
			ISEQ20CappedReturn AS ReturnValue    
		FROM    
			RowBased;    
    
    
	/* HIGHEST AND HighEST */    
	WITH RowBased AS (    
			SELECT    
				IndexDateID,    
				(OverallLast) OverallDailyLow,    
				(FinancialLast) FinancialDailyLow,    
				(GeneralLast) GeneralDailyLow,    
				(SmallCapLast) SamllCapDailyLow,    
				(ITEQLast) ITEQDailyLow,    
				(ISEQ20Last) ISEQ20DailyLow,    
				(ISEQ20INAVLast) ISEQ20INAVDailyLow,    
				(ESMLast) ESMDailyLow,    
				(ISEQ20InverseLast) ISEQ20InverseDailyLow,    
				(ISEQ20LeveragedLast) ISEQ20LeveragedDailyLow,    
				(ISEQ20CappedLast) ISEQ20CappedDailyLow,    
    
				(OverallLast) OverallDailyHigh,    
				(FinancialLast) FinancialDailyHigh,    
				(GeneralLast) GeneralDailyHigh,    
				(SmallCapLast) SamllCapDailyHigh,    
				(ITEQLast) ITEQDailyHigh,    
				(ISEQ20Last) ISEQ20DailyHigh,    
				(ISEQ20INAVLast) ISEQ20INAVDailyHigh,    
				(ESMLast) ESMDailyHigh,    
				(ISEQ20InverseLast) ISEQ20InverseDailyHigh,    
				(ISEQ20LeveragedLast) ISEQ20LeveragedDailyHigh,    
				(ISEQ20CappedLast) ISEQ20CappedDailyHigh    
			FROM    
					DWH.FactEquityIndex I    
				INNER JOIN    
					#Samples S    
				ON I.EquityIndexID = S.EquityIndexID  
		)    
		SELECT    
			IndexDateID,    
			'IEOP' AS IndexCode,    
			OverallDailyLow AS DailyLowValue,    
			OverallDailyHigh AS DailyHighValue    
		INTO #AGG    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEUP' AS IndexCode,    
			FinancialDailyLow AS DailyLowValue,    
			FinancialDailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEQP' AS IndexCode,    
			GeneralDailyLow AS DailyLowValue,    
			GeneralDailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEYP' AS IndexCode,    
			SamllCapDailyLow AS DailyLowValue,    
			SamllCapDailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEEP' AS IndexCode,    
			ISEQ20DailyLow AS DailyLowValue,    
			ISEQ20DailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOA' AS IndexCode,    
			ESMDailyLow AS DailyLowValue,    
			ESMDailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOD' AS IndexCode,    
			ISEQ20InverseDailyLow AS DailyLowValue,    
			ISEQ20InverseDailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOC' AS IndexCode,    
			ISEQ20LeveragedDailyLow AS DailyLowValue,    
			ISEQ20LeveragedDailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOE' AS IndexCode,    
			ISEQ20CappedDailyLow AS DailyLowValue,    
			ISEQ20CappedDailyHigh AS DailyHighValue    
		FROM    
			RowBased;    
    
	TRUNCATE TABLE ETL.FactEquityIndexPrep    
    
	INSERT INTO    
			ETL.FactEquityIndexPrep    
		(    
			IndexDateID,    
			IndexCode,    
			OpenValue,    
			LastValue,    
			ReturnValue,    
			DailyLowValue,    
			DailyHighValue    
		)    
		SELECT    
			F.IndexDateID,    
			F.IndexCode,    
			F.OpenValue,    
			L.LastValue,    
			L.ReturnValue,    
			A.DailyLowValue,    
			A.DailyHighValue    
		FROM    
				#FIRST F    
			INNER JOIN    
				#LAST L    
			ON F.IndexDateID = L.IndexDateID    
			AND F.IndexCode = L.IndexCode    
			INNER JOIN    
				#AGG A    
			ON F.IndexDateID = A.IndexDateID    
			AND F.IndexCode = A.IndexCode    
			    
	DROP TABLE #Samples    
	DROP TABLE #FIRST    
	DROP TABLE #LAST    
	DROP TABLE #AGG    
    
END    
    
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [ETL].[UpdateFactEquityIndexSnapshot]'
GO
-- =============================================     
-- Author:		Ian Meade     
-- Create date: 25/4/2017     
-- Description:	Update FactEquityIndexSnapshot with details in merge table     
-- =============================================     
ALTER PROCEDURE [ETL].[UpdateFactEquityIndexSnapshot]     
	@BatchID INT 
AS     
BEGIN     
	SET NOCOUNT ON;     
 
 
	MERGE     
			DWH.FactEquityIndexSnapshot AS DWH     
		USING (     
				SELECT     
					IndexDateID,      
					IndexTypeID,      
					OpenValue,      
					LastValue AS CloseValue,      
					ReturnValue,      
					DailyLowValue,      
					DailyHighValue,      
					InterestRate,      
					MarketCap     
				FROM     
					ETL.FactEquityIndexSnapshotMerge     
			) AS ETL (      
					IndexDateID,      
					IndexTypeID,      
					OpenValue,      
					CloseValue,      
					ReturnValue,      
					DailyLowValue,      
					DailyHighValue,      
					InterestRate,      
					MarketCap      
				)     
			ON (     
				DWH.DateID = ETL.IndexDateID     
			AND     
				DWH.IndexTypeID = ETL.IndexTypeID     
			)     
		WHEN MATCHED      
			THEN UPDATE SET     
				DWH.OpenValue = ETL.OpenValue,      
				DWH.CloseValue = ETL.CloseValue,      
				DWH.ReturnIndex = ETL.ReturnValue,      
				DWH.DailyLow = ETL.DailyLowValue,      
				DWH.DailyHigh = ETL.DailyHighValue,      
				DWH.InterestRate = ETL.InterestRate,      
				DWH.MarketCap = ETL.MarketCap     
		WHEN NOT MATCHED     
			THEN INSERT      
				(     
					DateID,      
					IndexTypeID,      
					OpenValue,      
					CloseValue,      
					ReturnIndex,      
					MarketCap,      
					DailyHigh,      
					DailyLow,      
					InterestRate,      
					BatchID     
				)     
				VALUES     
				(      
					IndexDateID,      
					IndexTypeID,      
					OpenValue,      
					CloseValue,      
					ReturnValue,      
					MarketCap,      
					DailyLowValue,      
					DailyHighValue,      
					InterestRate,      
					@BatchID      
				);     
     
END     
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Rebuilding [DWH].[FactCorporateAction]'
GO
CREATE TABLE [DWH].[RG_Recovery_1_FactCorporateAction] 
( 
[CorporateActionId] [smallint] NOT NULL IDENTITY(1, 1), 
[CorporateActionGID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[CorporateActionTypeID] [smallint] NOT NULL, 
[InstrumentID] [int] NOT NULL, 
[EffectiveDateID] [int] NOT NULL, 
[RecordDateID] [int] NOT NULL, 
[ExDateID] [int] NOT NULL, 
[LatestDateForApplicationNilPaidID] [int] NOT NULL, 
[LatestDateForFinalApplicationID] [int] NOT NULL, 
[CorporateActionStatusDateID] [int] NOT NULL, 
[LatestSplittingDateNote] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[Conditional] [char] (2) COLLATE Latin1_General_CI_AS NULL, 
[ReverseTakeover] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[NumberOfNewShares] [decimal] (23, 10) NULL, 
[ExPrice] [decimal] (23, 10) NULL, 
[Price] [decimal] (23, 10) NULL, 
[Details] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL, 
[AdditionalDescription] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL, 
[DSSPublishDate] [date] NULL, 
[DSSCreatedBy] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[DSSCreatedDate] [datetime] NULL, 
[BatchID] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
SET IDENTITY_INSERT [DWH].[RG_Recovery_1_FactCorporateAction] ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
INSERT INTO [DWH].[RG_Recovery_1_FactCorporateAction]([CorporateActionId], [CorporateActionTypeID], [InstrumentID], [EffectiveDateID], [RecordDateID], [ExDateID], [LatestDateForApplicationNilPaidID], [LatestDateForFinalApplicationID], [CorporateActionStatusDateID], [LatestSplittingDateNote], [Conditional], [ReverseTakeover], [NumberOfNewShares], [ExPrice], [Price], [Details], [AdditionalDescription], [DSSCreatedBy], [BatchID]) SELECT [CorporateActionId], [CorporateActionTypeID], [InstrumentID], [EffectiveDateID], [RecordDateID], [ExDateID], [LatestDateForApplicationNilPaidID], [LatestDateForFinalApplicationID], [CorporateActionStatusDateID], [LatestSplittingDateNote], [Conditional], [ReverseTakeover], [NumberOfNewShares], [ExPrice], [Price], [Details], [AdditionalDescription], [CoporateActionGID], [BatchID] FROM [DWH].[FactCorporateAction]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
SET IDENTITY_INSERT [DWH].[RG_Recovery_1_FactCorporateAction] OFF
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @idVal BIGINT 
SELECT @idVal = IDENT_CURRENT(N'[DWH].[FactCorporateAction]') 
IF @idVal IS NOT NULL 
    DBCC CHECKIDENT(N'[DWH].[RG_Recovery_1_FactCorporateAction]', RESEED, @idVal)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TABLE [DWH].[FactCorporateAction]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_rename N'[DWH].[RG_Recovery_1_FactCorporateAction]', N'FactCorporateAction', N'OBJECT'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactCorporateAction] on [DWH].[FactCorporateAction]'
GO
ALTER TABLE [DWH].[FactCorporateAction] ADD CONSTRAINT [PK_FactCorporateAction] PRIMARY KEY CLUSTERED  ([CorporateActionId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Rebuilding [DWH].[FactDividend]'
GO
CREATE TABLE [DWH].[RG_Recovery_2_FactDividend] 
( 
[DividendID] [smallint] NOT NULL IDENTITY(1, 1), 
[CoporateActionGID] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[CorporateActionTypeID] [smallint] NOT NULL, 
[InstrumentID] [int] NOT NULL, 
[NextMeetingDateID] [int] NOT NULL, 
[ExDateID] [int] NOT NULL, 
[PaymentDateID] [int] NOT NULL, 
[RecordDateID] [int] NOT NULL, 
[CurrencyID] [smallint] NOT NULL, 
[CorporateActionStatusDateID] [int] NOT NULL, 
[Coupon] [decimal] (23, 10) NULL, 
[DividendPerShare] [decimal] (23, 10) NULL, 
[DividendRatePercent] [decimal] (23, 10) NULL, 
[FXRate] [decimal] (23, 10) NULL, 
[GrossDivEuro] [decimal] (23, 10) NULL, 
[GrossDividend] [decimal] (23, 10) NULL, 
[TaxAmount] [decimal] (23, 10) NULL, 
[TaxDescription] [varchar] (100) COLLATE Latin1_General_CI_AS NULL, 
[TaxRatePercent] [decimal] (23, 10) NULL, 
[AdditionalDescription] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL, 
[Details] [varchar] (3000) COLLATE Latin1_General_CI_AS NULL, 
[DSSPublishDate] [date] NULL, 
[DSSCreatedBy] [varchar] (30) COLLATE Latin1_General_CI_AS NULL, 
[DSSCreatedDate] [datetime] NULL, 
[DSSNote] [varchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[BatchID] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
SET IDENTITY_INSERT [DWH].[RG_Recovery_2_FactDividend] ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
INSERT INTO [DWH].[RG_Recovery_2_FactDividend]([DividendID], [CoporateActionGID], [CorporateActionTypeID], [InstrumentID], [NextMeetingDateID], [ExDateID], [PaymentDateID], [RecordDateID], [CurrencyID], [Coupon], [DividendPerShare], [DividendRatePercent], [FXRate], [GrossDivEuro], [GrossDividend], [TaxAmount], [TaxDescription], [TaxRatePercent], [AdditionalDescription], [Details], [BatchID]) SELECT [DividendID], [CoporateActionGID], [CorporateActionTypeID], [InstrumentID], [NextMeetingDateID], [ExDateID], [PaymentDateID], [RecordDateID], [CurrencyID], [Coupon], [DividendPerShare], [DividendRatePercent], [FXRate], [GrossDivEuro], [GrossDividend], [TaxAmount], [TaxDescription], [TaxRatePercent], [AdditionalDescription], [Note], [BatchID] FROM [DWH].[FactDividend]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
SET IDENTITY_INSERT [DWH].[RG_Recovery_2_FactDividend] OFF
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @idVal BIGINT 
SELECT @idVal = IDENT_CURRENT(N'[DWH].[FactDividend]') 
IF @idVal IS NOT NULL 
    DBCC CHECKIDENT(N'[DWH].[RG_Recovery_2_FactDividend]', RESEED, @idVal)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TABLE [DWH].[FactDividend]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_rename N'[DWH].[RG_Recovery_2_FactDividend]', N'FactDividend', N'OBJECT'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FactDividend] on [DWH].[FactDividend]'
GO
ALTER TABLE [DWH].[FactDividend] ADD CONSTRAINT [PK_FactDividend] PRIMARY KEY CLUSTERED  ([DividendID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO



IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT 
SET @Success = 1 
SET NOEXEC OFF 
IF (@Success = 1) PRINT 'The database update succeeded' 
ELSE BEGIN 
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION 
	PRINT 'The database update failed' 
END
GO
