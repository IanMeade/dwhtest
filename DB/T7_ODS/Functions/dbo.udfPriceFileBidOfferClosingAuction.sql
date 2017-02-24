SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		Ian Meade
-- Create date: 16/2/2017
-- Description:	Closing auction bid / Offer prices from PriceFile
-- =============================================
CREATE FUNCTION [dbo].[udfPriceFileBidOfferClosingAuction]
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
		MAX(P.CLOSING_AUCT_BID_PRICE) AS CLOSING_AUCT_BID_PRICE,
		MAX(P.CLOSING_AUCT_ASK_PRICE) AS CLOSING_AUCT_ASK_PRICE,
		COUNT(DISTINCT CLOSING_AUCT_BID_PRICE) AS BidPriceVersions,
		COUNT(DISTINCT CLOSING_AUCT_ASK_PRICE) AS OfferPriceVersions
	FROM
			dbo.[File] F
		INNER JOIN
			dbo.PriceFile P
		ON F.DwhFileID = P.FileID
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
	AND
		P.CLOSING_AUCT_BID_PRICE IS NOT NULL
	AND
		P.CLOSING_AUCT_ASK_PRICE IS NOT NULL
	AND
		F.FileLetter IN ( 'I', 'J', 'JK', 'K' )
	GROUP BY
		P.ISIN,
		P.PRICE_DATE,
		P.PRICE_TIMESTAMP_NO


)



GO
