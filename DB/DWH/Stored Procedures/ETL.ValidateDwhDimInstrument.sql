SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================  
-- Author:		Ian Meade  
-- Create date: 25/5/2017  
-- Description:	Validates DimInstrument 
-- =============================================  
CREATE PROCEDURE [ETL].[ValidateDwhDimInstrument]   
AS  
BEGIN  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  

	SELECT
		-1 AS Code,
		'There are inconsistencies in the Instrument Dimension. The numer of rows in the DimInstrument table does not match the total in the DimInstrumentEquity and DimInstrumentEtf tables' AS Message
	WHERE
			(	SELECT COUNT(*) FROM DWH.DimInstrument	) 
		<>
			(( SELECT COUNT(*) FROM DWH.DimInstrumentEquity ) + ( SELECT COUNT(*) FROM DWH.DimInstrumentEtf ))
	UNION 
	SELECT
		-2,
		'DimInstrument with missing DimInstrumentEquity or DimInstrumentEtf entry. Review InstrumentID [' + STR(InstrumentID) + ']'
	FROM
		DWH.DimInstrument
	WHERE
			InstrumentID NOT IN ( SELECT InstrumentID FROM DWH.DimInstrumentEquity )
		AND
			InstrumentID NOT IN ( SELECT InstrumentID FROM DWH.DimInstrumentEtf )
	UNION
	SELECT
		-3,
		'DimInstrument without Current row. Review InstrumentGlobalID [' + STR(InstrumentID) + ']'
	FROM
		DWH.DimInstrument
	WHERE
		InstrumentGlobalID NOT IN ( SELECT InstrumentGlobalID FROM DWH.DimInstrument WHERE CurrentRowYN = 'Y' )
	

  
END  

GO
