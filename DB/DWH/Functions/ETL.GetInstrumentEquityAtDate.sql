SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 20/6/2017
-- Description:	To support Equity / Etf snapshots
-- =============================================
CREATE FUNCTION [ETL].[GetInstrumentEquityAtDate]
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
		DWH.DimInstrumentEquity
	WHERE
		InstrumentID IN (
					SELECT
						MAX(InstrumentID) InstrumentID
					FROM
						DWH.DimInstrumentEquity
					WHERE
						StartDate <= @Date
					GROUP BY
						InstrumentGlobalID
				)

)
GO
