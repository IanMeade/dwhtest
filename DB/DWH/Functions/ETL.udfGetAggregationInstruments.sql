SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Ian Meade
-- Create date: 8/5/2017
-- Description:	Get a list of Equity/ETf instrument to aggregate for pased in date
-- =============================================
CREATE FUNCTION [ETL].[udfGetAggregationInstruments]
(	
	@DateID AS INT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
		I.StartDate,
		I.EndDate,
		D.Day AS AggregationDate,
		@DateID AS AggregationDateID,
		I.InstrumentID,
		I.ISIN,
		I.InstrumentGlobalID,
		I.InstrumentType,
		COALESCE(EQ.CurrencyID, ETF.CurrencyID) AS CurrencyID,
		IIF(EQ.InstrumentID IS NOT NULL, 'EQUITY','ETF') AS SourceTable
	FROM
			DWH.DimInstrument I
		INNER JOIN
			DWH.DimStatus S
		ON I.InstrumentStatusID = S.StatusID
		LEFT OUTER JOIN
			DWH.DimInstrumentEquity EQ
		ON I.InstrumentID = EQ.InstrumentID
		LEFT OUTER JOIN
			DWH.DimInstrumentEtf ETF
		ON I.InstrumentID = ETF.InstrumentID
		INNER JOIN
			DWH.DimDate D
		ON D.DateID = @DateID
	WHERE
			I.InstrumentID IN (
					/* Most recent instrument on choosen date */
					SELECT
						MAX(InstrumentID) AS InstrumentID
					FROM
						DWH.DimInstrument
					WHERE
						InstrumentType IN ( 'EQUITY', 'ETF' )	
					AND
						D.Day BETWEEN CAST(StartDate AS DATE) AND ISNULL(EndDate, '2099/01/01' )
					GROUP BY
						InstrumentGlobalID
				)
		AND
			S.StatusName IN ( 'Listed', 'Suspended', 'ConditionalDealings' )


)


GO
