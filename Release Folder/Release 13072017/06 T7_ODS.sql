/* 
Run this script on: 
 
        T7-DDT-07.T7_ODS    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.T7_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 13/07/2017 13:21:08 
 
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
PRINT N'Altering [dbo].[FileList]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[FileList] ADD 
[ProcessFileYN] [char] (1) COLLATE Latin1_General_CI_AS NULL
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
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[udfTxSaftOcp]'
GO
 
     
-- =============================================     
-- Author:		Ian Meade     
-- Create date: 13/2/2017     
-- Description:	OCP / Official CLosing Price from TxSAFT files     
-- =============================================     
ALTER FUNCTION [dbo].[udfTxSaftOcp]     
(	     
	@TradeDate DATE     
)     
RETURNS TABLE      
AS     
RETURN      
(     
	WITH 
		RequiredTrade AS ( 
				SELECT     
					T.A_TRADE_DATE, 
					T.A_ISIN,  
					MAX(F.FileLetter) AS FileLetter 
				FROM     
						dbo.FileList F     
					INNER JOIN     
						dbo.TxSaft T     
					ON F.DwhFileID = T.DwhFileID   
				WHERE 
					F.DwhStatus NOT IN ( 'REJECT' )    
				AND    
					T.A_TRADE_DATE = @TradeDate 
				AND 
					F.ProcessFileYN = 'Y'			 
				AND 
					F.ContainsEndOfDayDetailsYN = 'Y' 
				AND 
					/* ENSURE PRICE IS POPULATED */ 
					A_TRADE_TIME_OCP <> '1858-11-17 00:00:00.000' 
				AND 
					T.A_OFFICIAL_CLOSING_PRICE <> 0 
				GROUP BY 
					T.A_TRADE_DATE, 
					T.A_ISIN 
			) 
		SELECT 
			T.A_ISIN,     
			MAX(T.A_OFFICIAL_CLOSING_PRICE) AS A_OFFICIAL_CLOSING_PRICE,     
			MAX(T.A_TRADE_TIME_OCP) AS A_TRADE_TIME_OCP,     
			MAX(T.A_TRADE_TIME_OCP_LOCAL) AS A_TRADE_TIME_OCP_LOCAL,     
			COUNT(DISTINCT T.A_OFFICIAL_CLOSING_PRICE) AS PriceVersions,     
			COUNT(DISTINCT T.A_TRADE_TIME_OCP) AS TimeVersions   
		FROM 
				RequiredTrade R 
			INNER JOIN 
				dbo.FileList F     
			ON R.FileLetter = F.FileLetter 
			INNER JOIN     
				dbo.TxSaft T     
			ON F.DwhFileID = T.DwhFileID   
		WHERE 
				R.A_TRADE_DATE = T.A_TRADE_DATE 
			AND 
				R.A_ISIN = T.A_ISIN 
			AND 
				F.DwhStatus NOT IN ( 'REJECT' )    
			AND 
				F.ProcessFileYN = 'Y'			 
			AND    
				F.ContainsEndOfDayDetailsYN = 'Y' 
			AND 
				/* ENSURE PRICE IS POPULATED */ 
				A_TRADE_TIME_OCP <> '1858-11-17 00:00:00.000' 
			AND 
				T.A_OFFICIAL_CLOSING_PRICE <> 0 
		GROUP BY 
			R.FileLetter, 
			T.A_ISIN 
    
)     
   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[udfTxSaftOop]'
GO
     
-- =============================================     
-- Author:		Ian Meade     
-- Create date: 13/2/2017     
-- Description:	OOP / Official Opening Price from TxSAFT files     
-- =============================================     
ALTER FUNCTION [dbo].[udfTxSaftOop]     
(	     
	@TradeDate DATE     
)     
RETURNS TABLE      
AS     
RETURN      
(     
	SELECT     
		T.A_ISIN,     
		MAX(A_OFFICIAL_OPENING_PRICE) AS A_OFFICIAL_OPENING_PRICE,     
		COUNT(DISTINCT A_OFFICIAL_OPENING_PRICE) AS PriceVersions     
	FROM     
			dbo.FileList F     
		INNER JOIN     
		 	dbo.TxSaft T     
		ON F.DwhFileID = T.DwhFileID      
	WHERE     
		T.A_TRADE_DATE = @TradeDate     
	AND     
		F.FileTag = 'TxSaft'     
	AND     
		/* NOT A DELAYED TRADE */     
		T.A_DEFERRED_IND != 'Y'     
	AND     
		/* NOT CANCELED */     
		T.A_MOD_REASON_CODE != '003'     
	AND 
		F.DwhStatus NOT IN ( 'REJECT' )  
	AND 
		F.ProcessFileYN = 'Y'   
	GROUP BY     
		T.A_ISIN     
	HAVING     
		MAX(A_OFFICIAL_OPENING_PRICE) IS NOT NULL     
     
     
)     
     
   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[TxSaft_BestTrade]'
GO
 
ALTER VIEW [dbo].[TxSaft_BestTrade] AS    
	/*     
		MOST RECENT COPY OF A TRADE    
		TRADES ARE SENT SEVERAL TIMES DURING THE DAY    
		THIS VIEW GETS THE MOST RECENT VERSION OF A TRADE IN THE TABLE    
	*/     
	SELECT    
		A_TRADE_DATE,    
		A_TRADE_LINK_NO,    
		A_ISIN,  
		A_TRADE_TYPE,  
		A_BUY_SELL_FLAG,    
		MAX(A_MOD_REASON_CODE) AS A_MOD_REASON_CODE,   
		COUNT(*) AS CNT,    
		MAX(TxSfaftID) AS TxSfaftID    
	FROM    
			dbo.TxSaft T 
		INNER JOIN 
			dbo.FileList FL 
		ON T.DwhFileID = FL.DwhFileID 
	WHERE 
			FL.DwhStatus NOT IN ( 'COMPLETE', 'REJECT' )    
		AND 
			FL.ProcessFileYN = 'Y' 
	GROUP BY    
		A_TRADE_DATE,    
		A_TRADE_LINK_NO,    
		A_ISIN,  
		A_TRADE_TYPE,  
		A_BUY_SELL_FLAG 
    
  
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[TxSaft_Open]'
GO
 
 
 
 
  
  
  
    
ALTER VIEW [dbo].[TxSaft_Open] AS    
	/*     
		TRADES IN THE ODS THAT ETL SHOULD TRY TO PUT INTO DHW - MIGHT DUPLCIATES THAT WILL BE REMOVED BY ETL PIPELINE    
		TRADES INCLUDE:    
			TRADES IN FILES NOT MARKED COMPLETE OR REJECT    
	*/     
	SELECT    
		/* DATE AND TIME FIELDS */    
		CAST(CONVERT(CHAR,A_TRADE_TIMESTAMP_LOCAL,112) AS INT) AS TradeDateID,    
		CAST(REPLACE(LEFT(CONVERT(CHAR,A_TRADE_TIMESTAMP_LOCAL,114),5),':','') AS SMALLINT) AS TradeTimeID,    
		CONVERT(TIME,A_TRADE_TIMESTAMP_LOCAL) AS TradeTimestamp,    
		CONVERT(TIME,A_TRADE_TIMESTAMP) AS UTCTradeTimeStamp,    
		ISNULL(CAST(CONVERT(CHAR,A_IND_PUBLICATION_TIME_LOCAL,112) AS INT),-1) AS PublishDateID,    
		ISNULL(CAST(REPLACE(LEFT(CONVERT(CHAR,A_IND_PUBLICATION_TIME_LOCAL,114),5),':','') AS SMALLINT),-1) AS PublishTimeID,    
		CAST(A_TRADE_TIMESTAMP_LOCAL AS DATETIME) TradeDateTime,   
		A_TRADE_TIMESTAMP AS UTCTradeDateTime,   
		CAST(A_IND_PUBLICATION_TIME_LOCAL AS DATETIME) AS PublishDateTime,   
		A_IND_PUBLICATION_TIME AS UTCPublishDateTime,   
		/* GENERAL LOOKUPS */    
		A_BUY_SELL_FLAG,    
		A_AUCTION_TRADE_FLAG,    
		A_ACCOUNT_TYPE,    
		A_ORDER_TYPE,     
		A_ORDER_RESTRICTION,     
		A_OTC_TRADE_FLAG_1,     
		A_OTC_TRADE_FLAG_2,     
		A_OTC_TRADE_FLAG_3,     
		A_ISIN,     
		A_MEMBER_ID,      
		A_TRADER_ID,     
		A_PRICE_CURRENCY,     
		A_MOD_REASON_CODE,    
	    
		/* STRAIGHT THROUGH */    
		A_TRADE_TYPE,  
		A_TRADE_LINK_NO AS TradingSysTransNo,    
		A_MATCH_PRICE_X AS TradePrice,    
		A_BEST_BID_PRICE AS BidPrice,    
		A_BEST_ASK_PRICE AS OfferPrice,    
		A_TRADE_SIZE_X AS TradeVolume,    
		A_ORDER_MARKET_VALUE AS TradeTurnover,    
		O.DwhFileID,    
		/* MINOR CHANGES */    
	--	IIF(A_DEFERRED_IND = 'Y' , 'Y', 'N' ) AS DelayedTradeYN    
		A_DEFERRED_IND AS DelayedTradeYN,  
		IIF(A_TRADE_TYPE='','OB','ND') AS TradeTypeCategory  
	FROM    
			dbo.TxSaft O    
		INNER JOIN    
			dbo.FileList F    
		ON O.DwhFileID = F.DwhFileID       
	WHERE    
		F.DwhStatus NOT IN ( 'COMPLETE', 'REJECT' )    
	AND 
		F.ProcessFileYN = 'Y' 
	AND    
		/* BEST COPY OF TRADE */    
		/* NOTE / REMINDER - VIEWS ON TOP OF VIEWS ARE SOMEWHAT DANGEROUS */    
		EXISTS (    
					SELECT    
						*    
					FROM    
							dbo.TxSaft_BestTrade BT    
					WHERE    
						O.TxSfaftID = BT.TxSfaftID    
			)    
			    
    
    
   
   
   
   
   
  
  
  
 
 
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[WorkToDo]'
GO
 
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 12/6/2017 
-- Description:	Work to do - used by master package precedence rules 
-- ============================================= 
ALTER FUNCTION [dbo].[WorkToDo] 
( 
) 
RETURNS BIT 
AS 
BEGIN 
	DECLARE @ResultVar BIT 
 
	SELECT 
		@ResultVar = IIF(X.CNT=0,0,1) 
	FROM 
		( 
				SELECT	 
					COUNT(*) AS CNT 
				FROM 
					FileList 
				WHERE 
					FileTag = 'TxSaft' 
				AND 
					DwhStatus NOT IN ( 'COMPLETE', 'REJECT' ) 
				AND 
					ProcessFileYN = 'Y' 
		) AS X 
 
	RETURN @ResultVar 
 
END 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_TxSaft_2] on [dbo].[TxSaft]'
GO
CREATE NONCLUSTERED INDEX [IX_TxSaft_2] ON [dbo].[TxSaft] ([A_TRADE_DATE], [A_ISIN])
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
