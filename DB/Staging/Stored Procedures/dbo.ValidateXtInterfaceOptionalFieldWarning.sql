SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 19/4/2017 
-- Description:	XT Interface validation - warning when optional fields are not populated - instruments are still allowed progress
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateXtInterfaceOptionalFieldWarning] 
AS 
BEGIN 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	/* Simple XT Interface warnings */ 
 
	/* Return warning - does not fix or remove nvalid entries */
 
	SELECT
		501 As Code, 
		'WARNING: XT Instrument found with no SEDOL. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message 
	FROM
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		ISNULL(	SEDOL, '' ) = ''
	UNION
	SELECT
		502 As Code, 
		'WARNING: XT Instrument found with no TradingSysInstrumentName. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message 
	FROM
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		ISNULL(	TradingSysInstrumentName, '' ) = ''
	UNION
	SELECT
		503 As Code, 
		'WARNING: XT Instrument found with no CompanyListedDate. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message 
	FROM
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		CompanyListedDate IS NULL
	UNION
	SELECT
		504 As Code, 
		'WARNING: XT Instrument found with no CompanyApprovalType. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message 
	FROM
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		ISNULL(	CompanyApprovalType, '' ) = ''
	UNION
	SELECT
		505 As Code, 
		'WARNING: XT Instrument found with no CompanyApprovalDate. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message 
	FROM
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		CompanyApprovalDate IS NULL
	UNION
	SELECT
		506 As Code, 
		'WARNING: XT Instrument found with no WKN. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message 
	FROM
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		ISNULL(	WKN, '' ) = ''
	UNION
	SELECT
		507 As Code, 
		'WARNING: XT Instrument found with no MNEM. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message 
	FROM
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		ISNULL(	MNEM, '' ) = ''
	UNION
	SELECT
		508 As Code, 
		'WARNING: XT Instrument found with no PrimaryBusinessSector. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message 
	FROM
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		ISNULL(	PrimaryBusinessSector, '' ) = ''
	UNION
	SELECT
		509 As Code, 
		'WARNING: XT Instrument found with no PrimaryMarket. Instrument has still been processed. GID: ' + ISNULL(InstrumentGlobalID,'') AS Message 
	FROM
		dbo.XtOdsInstrumentEquityEtfUpdate  
	WHERE 
		ISNULL(	PrimaryMarket, '' ) = ''
 
 
END 

GO
