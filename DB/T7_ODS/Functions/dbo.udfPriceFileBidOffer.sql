SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Ian Meade
-- Create date: 16/2/2017
-- Description:	Bid / Offer prices from PriceFile
-- =============================================
CREATE FUNCTION [dbo].[udfPriceFileBidOffer]
(	
	@PriceDate DATE
)
RETURNS TABLE 
AS
RETURN 
(

	SELECT
		P.ISIN,
		P.PRICE_DATE,
		P.PRICE_TIMESTAMP_NO,
		MAX(P.BEST_BID_PRICE) AS BEST_BID_PRICE,
		MAX(P.BEST_ASK_PRICE) AS BEST_ASK_PRICE,
		COUNT(DISTINCT BEST_BID_PRICE) AS BidPriceVersions,
		COUNT(DISTINCT BEST_ASK_PRICE) AS OfferPriceVersions
	FROM
			dbo.PriceFile P
		INNER JOIN
		(
			SELECT
				ISIN,
				PRICE_DATE,
				MAX(PRICE_TIMESTAMP_NO) AS PRICE_TIMESTAMP_NO
			FROM
				dbo.PriceFile
			GROUP BY
				ISIN,
				PRICE_DATE
		) AS X
		ON 
			P.ISIN = X.ISIN
		AND
			P.PRICE_TIMESTAMP_NO = X.PRICE_TIMESTAMP_NO
		AND
			P.PRICE_DATE = X.PRICE_DATE
	WHERE
		P.PRICE_DATE = @PriceDate
	GROUP BY
		P.ISIN,
		P.PRICE_DATE,
		P.PRICE_TIMESTAMP_NO


)


GO
