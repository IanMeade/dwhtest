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
   /* NOTE: 10/7/2017 */
   /* CHANGE APPLIED TO DATE SLECTION */ 
   /* USING PRICE_TIMESTAMP AS A DATE INSTEAD OF PRICE_DATE AS PRICE DATE IS INVALID IN FILES */
   /* MAY LEAD TO GRADUAL PERFORMANCE DEGRADATION ISSUE IN PRODUCITON */

	SELECT   
		P.ISIN,   
		CAST(P.PRICE_TIMESTAMP AS DATE) AS PRICE_DATE,   
		P.PRICE_TIMESTAMP,   
		MAX(P.BEST_BID_PRICE) AS BEST_BID_PRICE,   
		MAX(P.BEST_ASK_PRICE) AS BEST_ASK_PRICE,   
		COUNT(DISTINCT BEST_BID_PRICE) AS BidPriceVersions,   
		COUNT(DISTINCT BEST_ASK_PRICE) AS OfferPriceVersions   
	FROM   
			dbo.PriceFile P   
		INNER JOIN
			dbo.FileList FL
		ON P.FileID = FL.DwhFileID
		INNER JOIN   
		(   
			SELECT   
				ISIN,   
				CAST(PRICE_TIMESTAMP AS DATE) AS PRICE_DATE,   
				MAX(PRICE_TIMESTAMP) AS PRICE_TIMESTAMP   
			FROM   
				dbo.PriceFile   
			GROUP BY   
				ISIN,   
				CAST(PRICE_TIMESTAMP AS DATE)
		) AS X   
		ON    
			P.ISIN = X.ISIN   
		AND   
			P.PRICE_TIMESTAMP = X.PRICE_TIMESTAMP   
	WHERE   
		FL.DwhStatus NOT IN ( 'REJECT' )   
	AND
		FL.ProcessFileYN = 'Y'
	AND   
		CAST(P.PRICE_TIMESTAMP AS DATE) = @PriceDate   
	GROUP BY   
		P.ISIN,   
		P.PRICE_DATE,   
		P.PRICE_TIMESTAMP   
   
   
)   
   
   
  


GO
