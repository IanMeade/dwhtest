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

	/* NOTE: 10/7/2017 */
	/* CHANGE APPLIED TO DATE SLECTION */ 
	/* USING PRICE_TIMESTAMP AS A DATE INSTEAD OF PRICE_DATE AS PRICE DATE IS INVALID IN FILES */
	/* MAY LEAD TO GRADUAL PERFORMANCE DEGRADATION ISSUE IN PRODUCITON */
    
	SELECT    
		P.ISIN,    
		CAST(P.PRICE_TIMESTAMP AS DATE) AS PRICE_DATE,   
		P.PRICE_TIMESTAMP,    
		MAX(P.CLOSING_AUCT_BID_PRICE) AS CLOSING_AUCT_BID_PRICE,    
		MAX(P.CLOSING_AUCT_ASK_PRICE) AS CLOSING_AUCT_ASK_PRICE,    
		COUNT(DISTINCT CLOSING_AUCT_BID_PRICE) AS BidPriceVersions,    
		COUNT(DISTINCT CLOSING_AUCT_ASK_PRICE) AS OfferPriceVersions    
	FROM    
			dbo.FileList F    
		INNER JOIN    
			dbo.PriceFile P    
		ON F.DwhFileID = P.FileID    
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
		CAST(P.PRICE_TIMESTAMP AS DATE) = @PriceDate   
	AND    
		P.CLOSING_AUCT_BID_PRICE IS NOT NULL    
	AND    
		P.CLOSING_AUCT_ASK_PRICE IS NOT NULL    
	AND    
		F.DwhStatus NOT IN ( 'REJECT' )   
	AND
		F.ProcessFileYN = 'Y'
	AND   
		F.ContainsEndOfDayDetailsYN = 'Y'   
	GROUP BY    
		P.ISIN,    
		P.PRICE_DATE,    
		P.PRICE_TIMESTAMP  
    
    
)    
    
    
    
  

GO
