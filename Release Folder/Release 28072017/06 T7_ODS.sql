/* 
Run this script on: 
 
        T7-DDT-07.T7_ODS    -  This database will be modified 
 
to synchronize it with: 
 
        ..T7_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 28/07/2017 11:40:30 
 
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
PRINT N'Dropping constraints from [dbo].[RawTcC810]'
GO
ALTER TABLE [dbo].[RawTcC810] DROP CONSTRAINT [PK_RawTcC810]
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
  
  
   /* IM 21/7/2107   
	  QUICK FIX TO USE DIFFERNET PRICE FIELDS   
	  EXPECTED TO BE USED FOR ABOUT ONE WEEK   
	*/  
  
	/* TEMPORARY CODE - START */  
  
	SELECT     
		P.ISIN,     
		CAST(P.PRICE_TIMESTAMP AS DATE) AS PRICE_DATE,     
		P.PRICE_TIMESTAMP,     
		MAX(IIF(FL.FileLetter < 'I', P.BEST_BID_PRICE, CLOSING_AUCT_BID_PRICE )) AS BEST_BID_PRICE,     
		MAX(IIF(FL.FileLetter < 'I', P.BEST_ASK_PRICE, CLOSING_AUCT_ASK_PRICE )) AS BEST_ASK_PRICE,     
		1 AS BidPriceVersions,     
		1 AS OfferPriceVersions     
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
					dbo.PriceFile P  
				INNER JOIN  
					dbo.FileList FL  
				ON P.FileID = FL.DwhFileID					  
			WHERE  
				/* ENSURE PRICE IS VALID */  
					IIF(FL.FileLetter < 'I', P.BEST_BID_PRICE, CLOSING_AUCT_BID_PRICE ) <> 0   
				OR  
					IIF(FL.FileLetter < 'I', P.BEST_ASK_PRICE, CLOSING_AUCT_ASK_PRICE) <> 0   
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
  
	/* TEMPORARY CODE - END */  
  
  
	/* IM 21/7/2017   
		ORIGINAL GO LIVE CODE - START  
	*/  
	/*  
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
	*/  
	/* IM 21/7/2017   
		ORIGINAL GO LIVE CODE - END  
	*/  
     
     
)     
     
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
		A_MATCH_PRICE_X * A_TRADE_SIZE_X AS TradeTurnover,    
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
PRINT N'Creating [dbo].[RawTc810_NEW]'
GO
CREATE TABLE [dbo].[RawTc810_NEW] 
( 
[RawTc810_NEW_ID] [int] NOT NULL IDENTITY(1, 1), 
[FileID] [int] NOT NULL, 
[exchNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[envText] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[rptCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[rptNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[rptFlexKey] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[membId] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[membLglNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[rptPrntEffDat] [datetime] NULL, 
[rptPrntEffTim] [datetime] NULL, 
[rptPrntRunDat] [datetime] NULL, 
[participant] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[partLngName] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[membClgIdCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[membCcpClgIdCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[settlAcct] [int] NULL, 
[settlLocat] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[settlCurr] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[sumMembTotBuyOrdr] [bigint] NULL, 
[sumMembTotSellOrdr] [bigint] NULL, 
[businessUnit] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[busUntLngName] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[businessUnitId] [int] NULL, 
[sumPartTotBuyOrdr] [bigint] NULL, 
[sumPartTotSellOrdr] [bigint] NULL, 
[user] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[product] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[instrumentType] [tinyint] NULL, 
[instrumentId] [bigint] NULL, 
[instrumentMnemonic] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[isinCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[wknNo] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[instNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[time18] [datetime] NULL, 
[tradeType] [tinyint] NULL, 
[matchEvent] [int] NULL, 
[matchStep] [int] NULL, 
[matchDeal] [int] NULL, 
[parentDeal] [tinyint] NULL, 
[dealItem] [int] NULL, 
[tradeNumber] [int] NULL, 
[exchangeOrderId] [numeric] (20, 0) NULL, 
[versionNo] [tinyint] NULL, 
[acctTypGrp] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[buyCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[ordrPrtFilCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[execQty] [bigint] NULL, 
[execPrc] [numeric] (28, 10) NULL, 
[ordrTyp] [tinyint] NULL, 
[limOrdrPrc] [numeric] (28, 10) NULL, 
[timeValidity] [tinyint] NULL, 
[tradingRestriction] [tinyint] NULL, 
[settlAmnt] [numeric] (28, 10) NULL, 
[settlDat] [datetime] NULL, 
[ctrPtyId] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[userOrdrNum] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[text] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[kindOfDepo] [tinyint] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_RawTc810_NEW] on [dbo].[RawTc810_NEW]'
GO
ALTER TABLE [dbo].[RawTc810_NEW] ADD CONSTRAINT [PK_RawTc810_NEW] PRIMARY KEY CLUSTERED  ([FileID], [RawTc810_NEW_ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_RawTcC810] on [dbo].[RawTcC810]'
GO
ALTER TABLE [dbo].[RawTcC810] ADD CONSTRAINT [PK_RawTcC810] PRIMARY KEY CLUSTERED  ([FileID], [RawTc810Id]) WITH (DATA_COMPRESSION = PAGE)
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
