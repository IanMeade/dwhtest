SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 7/4/2017 
-- Description:	XT Interface validation - verfiy InstrumentType cannot change
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateXtInterfaceInstrumentType] 
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
			456 As Code, 
			'XT InstrumentType change found. Existing instruments cannot change type. GID: [' + ISNULL(XT.InstrumentGlobalID,'') + '] already in DWH as [' + RTRIM(DWH.InstrumentType) + '] is in XT_ODS as [' + RTRIM(XT.InstrumentType) + ']' AS Message 
		FROM
				XtOdsInstrumentEquityEtfUpdate XT
			INNER JOIN
				DwhDimInstrumentEquityEtf DWH
			ON XT.InstrumentGlobalID = DWH.InstrumentGlobalID
		WHERE
			XT.InstrumentType <> DWH.InstrumentType

 
	DELETE 
		XT
	FROM
			XtOdsInstrumentEquityEtfUpdate XT
		INNER JOIN
			DwhDimInstrumentEquityEtf DWH
		ON XT.InstrumentGlobalID = DWH.InstrumentGlobalID
	WHERE
		XT.InstrumentType <> DWH.InstrumentType

   
	/* RETURN ALL ERROR MESSAGES */ 
	SELECT  
		Code, 
		Message 
	FROM 
		@Messages 
 
 
 
END 

GO
