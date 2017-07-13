SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Ian Meade
-- Create date: 20/6/2017
-- Description:	To support Equity / Etf snapshots
-- =============================================
CREATE FUNCTION [ETL].[GetInstrumentEtfAtDate]
(	
	@Date DATE
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
		*
	FROM
		DWH.DimInstrumentEtf
	WHERE
		InstrumentID IN (
					SELECT
						MAX(InstrumentID) InstrumentID
					FROM
						DWH.DimInstrumentEtf
					WHERE
						CAST(StartDate AS DATE) <= @Date
					GROUP BY
						InstrumentGlobalID
				)

)

GO
