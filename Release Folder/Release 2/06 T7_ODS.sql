USE T7_ODS
GO

/* 
Run this script on a database with the schema represented by: 
 
        ProcessControl    -  This database will be modified. The scripts folder will not be modified. 
 
to synchronize it with a database with the schema represented by: 
 
        T7-DDT-01.T7_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 16/03/2017 15:05:30 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[File]'
GO
CREATE TABLE [dbo].[File] 
( 
[DwhFileID] [int] NOT NULL, 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[EtlVersion] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[Populated] [datetime2] NOT NULL CONSTRAINT [DF_File_Populated] DEFAULT (getdate()), 
[DwhStatus] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[FileLetter] [char] (2) COLLATE Latin1_General_CI_AS NULL, 
[FileTag] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[ContainsEndOfDayDetailsYN] [char] (1) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_File] on [dbo].[File]'
GO
ALTER TABLE [dbo].[File] ADD CONSTRAINT [PK_File] PRIMARY KEY CLUSTERED  ([DwhFileID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[PriceFile]'
GO
CREATE TABLE [dbo].[PriceFile] 
( 
[PriceFileID] [bigint] NOT NULL IDENTITY(1, 1), 
[FileID] [int] NOT NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[CURRENCY] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[PRICE_TIMESTAMP] [datetime2] NOT NULL, 
[PRICE_TIMESTAMP_NO] [int] NULL, 
[MOD_TIMESTAMP] [datetime2] NULL, 
[PRICE_DATE] [date] NULL, 
[MARKET_PRICE_TYPE] [varchar] (1) COLLATE Latin1_General_CI_AS NULL, 
[BEST_BID_PRICE] [numeric] (19, 6) NULL, 
[BEST_ASK_PRICE] [numeric] (19, 6) NULL, 
[CLOSING_AUCT_BID_PRICE] [numeric] (19, 6) NULL, 
[CLOSING_AUCT_ASK_PRICE] [numeric] (19, 6) NULL, 
[INSERT_DATE] [date] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_PriceFile] on [dbo].[PriceFile]'
GO
ALTER TABLE [dbo].[PriceFile] ADD CONSTRAINT [PK_PriceFile] PRIMARY KEY CLUSTERED  ([PriceFileID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_PriceFile] on [dbo].[PriceFile]'
GO
CREATE NONCLUSTERED INDEX [IX_PriceFile] ON [dbo].[PriceFile] ([ISIN], [PRICE_DATE], [PRICE_TIMESTAMP_NO])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[udfPriceFileBidOffer]'
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
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[udfPriceFileBidOfferClosingAuction]'
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
		F.ContainsEndOfDayDetailsYN = 'Y' 
	GROUP BY  
		P.ISIN,  
		P.PRICE_DATE,  
		P.PRICE_TIMESTAMP_NO  
  
  
)  
  
  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TxSaft]'
GO
CREATE TABLE [dbo].[TxSaft] 
( 
[TxSfaftID] [bigint] NOT NULL IDENTITY(1, 1), 
[DwhFileID] [int] NOT NULL, 
[A_MOD_TIMESTAMP] [datetime2] NOT NULL, 
[A_MOD_TIMESTAMP_GMT] [datetimeoffset] NULL, 
[A_TRADE_LINK_NO] [int] NOT NULL, 
[A_SUB_TRANSACTION_NO] [int] NOT NULL, 
[A_BUY_SELL_FLAG] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_TRADE_TYPE] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_TRADE_DATE] [datetime2] NOT NULL, 
[A_TRADE_TIMESTAMP] [datetime2] NOT NULL, 
[A_TRADE_TIMESTAMP_GMT] [datetimeoffset] NULL, 
[A_OTC_TRADE_TIME] [time] NOT NULL, 
[A_PRICE_CURRENCY] [varchar] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_MATCH_PRICE_X] [decimal] (19, 6) NOT NULL, 
[A_TRADE_SIZE_X] [decimal] (19, 6) NOT NULL, 
[A_AUCTION_TRADE_FLAG] [varchar] (2) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_MEMBER_ID] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_ACCOUNT_TYPE] [varchar] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_ORDER_TYPE] [varchar] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_ORDER_RESTRICTION] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_ORDER_MARKET_VALUE] [decimal] (19, 6) NOT NULL, 
[A_MEMBER_CTPY_ID] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_SETTLEMENT_DATE] [date] NOT NULL, 
[A_SETTLEMENT_TYPE] [varchar] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_MOD_REASON_CODE] [varchar] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_INSERT_TIMESTAMP] [datetime2] NOT NULL, 
[A_OTC_TRADE_FLAG_1] [varchar] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_OTC_TRADE_FLAG_2] [varchar] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_OTC_TRADE_FLAG_3] [varchar] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_DEFERRED_IND] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_IND_PUBLICATION_TIME] [datetime2] NULL, 
[A_IND_PUBLICATION_TIME_GMT] [datetimeoffset] NULL, 
[A_TRADER_ID] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_BEST_BID_PRICE] [decimal] (19, 6) NOT NULL, 
[A_BEST_ASK_PRICE] [decimal] (19, 6) NOT NULL, 
[A_OFFICIAL_OPENING_PRICE] [decimal] (19, 6) NOT NULL, 
[A_OFFICIAL_CLOSING_PRICE] [decimal] (19, 6) NOT NULL, 
[A_TRADE_TIME_OCP] [datetime] NOT NULL, 
[A_TRADE_TIME_OCP_GMT] [datetimeoffset] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_TxSaft] on [dbo].[TxSaft]'
GO
ALTER TABLE [dbo].[TxSaft] ADD CONSTRAINT [PK_TxSaft] PRIMARY KEY CLUSTERED  ([TxSfaftID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_TxSaft_1] on [dbo].[TxSaft]'
GO
CREATE NONCLUSTERED INDEX [IX_TxSaft_1] ON [dbo].[TxSaft] ([DwhFileID], [A_ISIN], [A_TRADE_TIME_OCP], [A_OFFICIAL_CLOSING_PRICE])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_TxSaft] on [dbo].[TxSaft]'
GO
CREATE NONCLUSTERED INDEX [IX_TxSaft] ON [dbo].[TxSaft] ([DwhFileID], [A_TRADE_DATE], [A_SUB_TRANSACTION_NO], [A_BUY_SELL_FLAG])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[udfTxSaftOcp]'
GO
  
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 13/2/2017  
-- Description:	OCP / Official CLosing Price from TxSAFT files  
-- =============================================  
CREATE FUNCTION [dbo].[udfTxSaftOcp]  
(	  
	@TradeDate DATE  
)  
RETURNS TABLE   
AS  
RETURN   
(  
	SELECT  
		T.A_ISIN,  
		MAX(A_OFFICIAL_CLOSING_PRICE) AS A_OFFICIAL_CLOSING_PRICE,  
		MAX(A_TRADE_TIME_OCP) AS A_TRADE_TIME_OCP,  
		MAX(A_TRADE_TIME_OCP_GMT) AS A_TRADE_TIME_OCP_GMT,  
		COUNT(DISTINCT A_OFFICIAL_CLOSING_PRICE) AS PriceVersions,  
		COUNT(DISTINCT A_TRADE_TIME_OCP) AS TimeVersions  
	FROM  
			dbo.[File] F  
		INNER JOIN  
			dbo.TxSaft T  
		ON F.DwhFileID = T.DwhFileID   
	WHERE  
		T.A_TRADE_DATE = @TradeDate  
	AND  
		F.FileTag = 'TxSaft'  
	AND  
		F.ContainsEndOfDayDetailsYN = 'Y' 
	AND  
		/* NOT A DELAYED TRADE */  
		A_DEFERRED_IND != 'Y'  
	AND  
		/* NOT CANCELED */  
		A_MOD_REASON_CODE != '003'  
	GROUP BY  
		T.A_ISIN  
--	HAVING  
	--	MAX(A_OFFICIAL_CLOSING_PRICE) IS NOT NULL  
  
  
)  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[udfTxSaftOop]'
GO
  
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 13/2/2017  
-- Description:	OOP / Official Opening Price from TxSAFT files  
-- =============================================  
CREATE FUNCTION [dbo].[udfTxSaftOop]  
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
			dbo.[File] F  
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
	GROUP BY  
		T.A_ISIN  
	HAVING  
		MAX(A_OFFICIAL_OPENING_PRICE) IS NOT NULL  
  
  
)  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TxSaft_BestTrade]'
GO
 
 
CREATE VIEW [dbo].[TxSaft_BestTrade] AS 
	/*  
		MOST RECENT COPY OF A TRADE 
		TRADES ARE SENT SEVERAL TIMES DURING THE DAY 
		THIS VIEW GETS THE MOST RECENT VERSION OF A TRADE IN THE TABLE 
	*/  
	SELECT 
		A_TRADE_DATE, 
		A_TRADE_LINK_NO, 
		A_BUY_SELL_FLAG, 
		COUNT(*) AS CNT, 
		MAX(TxSfaftID) AS TxSfaftID 
	FROM 
		dbo.TxSaft 
	GROUP BY 
		A_TRADE_DATE, 
		A_TRADE_LINK_NO, 
		A_BUY_SELL_FLAG 
 
 
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TxSaft_Open]'
GO
 
 
 
CREATE VIEW [dbo].[TxSaft_Open] AS 
	/*  
		TRADES IN THE ODS THAT ETL SHOPULD TRY TO PUT INTO DHW - MIGHT DUPLCIATES THAT WILL BE REMOVED BY ETL PIPELINE 
		TRADES INCLUDE: 
			TRADES IN FILES NOT MARKED COMPLETE OR REJECT 
	*/  
	SELECT 
		/* DATE AND TIME FIELDS */ 
		CAST(CONVERT(CHAR,A_TRADE_TIMESTAMP_GMT,112) AS INT) AS TradeDateID, 
		CAST(REPLACE(LEFT(CONVERT(CHAR,A_TRADE_TIMESTAMP_GMT,114),5),':','') AS SMALLINT) AS TradeTimeID, 
		CONVERT(TIME,A_TRADE_TIMESTAMP_GMT) AS TradeTimestamp, 
		CONVERT(TIME,A_TRADE_TIMESTAMP) AS UTCTradeTimeStamp, 
		ISNULL(CAST(CONVERT(CHAR,A_IND_PUBLICATION_TIME_GMT,112) AS INT),-1) AS PublishDateID, 
		ISNULL(CAST(REPLACE(LEFT(CONVERT(CHAR,A_IND_PUBLICATION_TIME_GMT,114),5),':','') AS SMALLINT),-1) AS PublishTimeID, 
		/* GENRAL LOOKUPS */ 
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
		A_TRADE_LINK_NO AS TradingSysTransNo, 
		A_MATCH_PRICE_X AS TradePrice, 
		A_BEST_BID_PRICE AS BidPrice, 
		A_BEST_ASK_PRICE AS OfferPrice, 
		A_TRADE_SIZE_X AS TradeVolume, 
		A_ORDER_MARKET_VALUE AS TradeTurnover, 
		O.DwhFileID, 
		/* MINOR CHANGES */ 
		IIF(A_DEFERRED_IND = 'Y' , 'Y', 'N' ) AS DelayedTradeYN 
	FROM 
			dbo.TxSaft O 
		INNER JOIN 
			dbo.[File] F 
		ON O.DwhFileID = F.DwhFileID 
 
 
	WHERE 
		F.DwhStatus NOT IN ( 'COMPLETE', 'REJECT' ) 
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
PRINT N'Creating [dbo].[EtlAggregateDate]'
GO
CREATE TABLE [dbo].[EtlAggregateDate] 
( 
[AggregateDate] [date] NULL 
)
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
