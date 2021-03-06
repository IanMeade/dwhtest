/* 
Run this script on: 
 
        T7-DDT-07.T7_ODS    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.T7_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 11/07/2017 15:17:57 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [T7_ODS]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [IX_PriceFile] from [dbo].[PriceFile]'
GO
DROP INDEX [IX_PriceFile] ON [dbo].[PriceFile]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[udfPriceFileBidOffer]'
GO
 
    
    
-- =============================================    
-- Author:		Ian Meade    
-- Create date: 16/2/2017    
-- Description:	Bid / Offer prices from PriceFile    
-- =============================================    
ALTER FUNCTION [dbo].[udfPriceFileBidOffer]    
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
	GROUP BY    
		P.ISIN,    
		P.PRICE_DATE,    
		P.PRICE_TIMESTAMP    
    
    
)    
    
    
   
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[udfPriceFileBidOfferClosingAuction]'
GO
 
     
     
     
-- =============================================     
-- Author:		Ian Meade     
-- Create date: 16/2/2017     
-- Description:	Closing auction bid / Offer prices from PriceFile     
-- =============================================     
ALTER FUNCTION [dbo].[udfPriceFileBidOfferClosingAuction]     
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
		F.ContainsEndOfDayDetailsYN = 'Y'    
	GROUP BY     
		P.ISIN,     
		P.PRICE_DATE,     
		P.PRICE_TIMESTAMP   
     
     
)     
     
     
     
   
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_PriceFile] on [dbo].[PriceFile]'
GO
CREATE NONCLUSTERED INDEX [IX_PriceFile] ON [dbo].[PriceFile] ([PRICE_TIMESTAMP], [ISIN], [PRICE_DATE])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT 
SET @Success = 1 
SET NOEXEC OFF 
IF (@Success = 1) PRINT 'The database update succeeded' 
ELSE BEGIN 
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION 
	PRINT 'The database update failed' 
END
GO
