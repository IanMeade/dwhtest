SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 14/3/2017
-- Description:	Validates T7 price details
-- =============================================
CREATE PROCEDURE [ETL].[ValidatePriceFileBidOffer] 
AS
BEGIN
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		77 AS Code,
		'ISIN in Price file not found in Instrument Dimension [' + ISIN + ']' AS Message
	FROM
		(
			SELECT
				ISIN
			FROM
				[ETL].[BidOfferPrice]
			UNION
			SELECT
				ISIN
			FROM
				[ETL].[ClosingPrice]
			UNION
			SELECT
				A_ISIN
			FROM
				[ETL].[OCP]
			UNION
			SELECT
				A_ISIN
			FROM
				[ETL].[OOP]
		) Price
	WHERE
		ISIN NOT IN (
				SELECT
					ISIN
				FROM
					DWH.DimInstrumentEquity
				WHERE
					CurrentRowYN = 'Y'
				UNION
				SELECT
					ISIN
				FROM
					DWH.DimInstrumentEtf
				WHERE
					CurrentRowYN = 'Y'				
			)

END
GO
