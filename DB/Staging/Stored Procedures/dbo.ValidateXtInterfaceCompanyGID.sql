SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 7/4/2017 
-- Description:	XT Interface validation - verfiy InstrumentType cannot change
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateXtInterfaceCompanyGID] 
AS 
BEGIN 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	/* Result tables - empty table means no invalid rows found */ 
	DECLARE @Messages TABLE ( Code INT, Message VARCHAR(1000) ) 
 
	/* Instruments with no ISIN */ 
	INSERT INTO  
			@Messages  
		( 
			Code,  
			Message  
		) 
		SELECT 
			467 As Code, 
			'XT company change found. Existing instruments cannot change company. Instrument GID: [' + ISNULL(XT.InstrumentGlobalID,'') + '] assigned to Company GID in DWH [' + RTRIM(DWH.CompanyGlobalID) + '] is assigned to Company GID [' + RTRIM(XT.CompanyGlobalID) + ']' AS Message 
		FROM
				XtOdsInstrumentEquityEtfUpdate XT
			INNER JOIN
				DwhDimInstrumentEquityEtf DWH
			ON XT.InstrumentGlobalID = DWH.InstrumentGlobalID
		WHERE
			XT.CompanyGlobalID <> DWH.CompanyGlobalID


	DELETE 
		XT
	FROM
			XtOdsInstrumentEquityEtfUpdate XT
		INNER JOIN
			DwhDimInstrumentEquityEtf DWH
		ON XT.InstrumentGlobalID = DWH.InstrumentGlobalID
	WHERE
		XT.CompanyGlobalID <> DWH.CompanyGlobalID

   
	/* RETURN ALL ERROR MESSAGES */ 
	SELECT  
		Code, 
		Message 
	FROM 
		@Messages 
 
 
 
END 

GO
