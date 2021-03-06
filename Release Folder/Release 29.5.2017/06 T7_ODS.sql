/* 
Run this script on: 
 
        T7-DDT-06.T7_ODS    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.T7_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 29/05/2017 14:18:23 
 
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
PRINT N'Creating [dbo].[PriceFile]'
GO
CREATE TABLE [dbo].[PriceFile] 
( 
[PriceFileID] [bigint] NOT NULL IDENTITY(1, 1), 
[FileID] [int] NOT NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[CURRENCY] [varchar] (3) COLLATE Latin1_General_CI_AS NULL, 
[PRICE_TIMESTAMP] [datetime2] NOT NULL, 
[MOD_TIMESTAMP] [datetime2] NULL, 
[PRICE_DATE] [date] NULL, 
[BEST_BID_PRICE] [numeric] (19, 6) NULL, 
[BEST_ASK_PRICE] [numeric] (19, 6) NULL, 
[CLOSING_AUCT_BID_PRICE] [numeric] (19, 6) NULL, 
[CLOSING_AUCT_ASK_PRICE] [numeric] (19, 6) NULL 
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
CREATE NONCLUSTERED INDEX [IX_PriceFile] ON [dbo].[PriceFile] ([ISIN], [PRICE_DATE], [PRICE_TIMESTAMP])
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
				PRICE_DATE,  
				MAX(PRICE_TIMESTAMP) AS PRICE_TIMESTAMP  
			FROM  
				dbo.PriceFile  
			GROUP BY  
				ISIN,  
				PRICE_DATE  
		) AS X  
		ON   
			P.ISIN = X.ISIN  
		AND  
			P.PRICE_TIMESTAMP = X.PRICE_TIMESTAMP  
		AND  
			P.PRICE_DATE = X.PRICE_DATE  
	WHERE  
		P.PRICE_DATE = @PriceDate  
	GROUP BY  
		P.ISIN,  
		P.PRICE_DATE,  
		P.PRICE_TIMESTAMP  
  
  
)  
  
  
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[FileList]'
GO
CREATE TABLE [dbo].[FileList] 
( 
[DwhFileID] [int] NOT NULL, 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[EtlVersion] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[Populated] [datetime2] NOT NULL CONSTRAINT [DF_File_Populated] DEFAULT (getdate()), 
[DwhStatus] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[FileLetter] [char] (2) COLLATE Latin1_General_CI_AS NULL, 
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[ContainsEndOfDayDetailsYN] [char] (1) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_File] on [dbo].[FileList]'
GO
ALTER TABLE [dbo].[FileList] ADD CONSTRAINT [PK_File] PRIMARY KEY CLUSTERED  ([DwhFileID])
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
				PRICE_DATE,   
				MAX(PRICE_TIMESTAMP) AS PRICE_TIMESTAMP   
			FROM   
				dbo.PriceFile   
			GROUP BY   
				ISIN,   
				PRICE_DATE   
		) AS X   
		ON    
			P.ISIN = X.ISIN   
		AND   
			P.PRICE_TIMESTAMP = X.PRICE_TIMESTAMP 
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
		P.PRICE_TIMESTAMP 
   
   
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
[A_MOD_TIMESTAMP_LOCAL] [datetime2] NULL, 
[A_TRADE_LINK_NO] [int] NOT NULL, 
[A_SUB_TRANSACTION_NO] [int] NOT NULL, 
[A_BUY_SELL_FLAG] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_TRADE_TYPE] [varchar] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_TRADE_DATE] [datetime2] NOT NULL, 
[A_TRADE_TIMESTAMP] [datetime2] NOT NULL, 
[A_TRADE_TIMESTAMP_LOCAL] [datetime2] NULL, 
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
[A_IND_PUBLICATION_TIME_LOCAL] [datetime2] NULL, 
[A_TRADER_ID] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[A_BEST_BID_PRICE] [decimal] (19, 6) NOT NULL, 
[A_BEST_ASK_PRICE] [decimal] (19, 6) NOT NULL, 
[A_OFFICIAL_OPENING_PRICE] [decimal] (19, 6) NOT NULL, 
[A_OFFICIAL_CLOSING_PRICE] [decimal] (19, 6) NOT NULL, 
[A_TRADE_TIME_OCP] [datetime] NOT NULL, 
[A_TRADE_TIME_OCP_LOCAL] [datetime2] NOT NULL 
) 
WITH 
( 
DATA_COMPRESSION = PAGE 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_TxSaft] on [dbo].[TxSaft]'
GO
ALTER TABLE [dbo].[TxSaft] ADD CONSTRAINT [PK_TxSaft] PRIMARY KEY CLUSTERED  ([TxSfaftID]) WITH (DATA_COMPRESSION = PAGE)
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
CREATE NONCLUSTERED INDEX [IX_TxSaft] ON [dbo].[TxSaft] ([DwhFileID], [A_TRADE_DATE], [A_SUB_TRANSACTION_NO], [A_BUY_SELL_FLAG], [A_MOD_REASON_CODE])
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
		MAX(A_TRADE_TIME_OCP_LOCAL) AS A_TRADE_TIME_OCP_LOCAL,   
		COUNT(DISTINCT A_OFFICIAL_CLOSING_PRICE) AS PriceVersions,   
		COUNT(DISTINCT A_TRADE_TIME_OCP) AS TimeVersions   
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
		A_MOD_REASON_CODE, 
		COUNT(*) AS CNT,  
		MAX(TxSfaftID) AS TxSfaftID  
	FROM  
		dbo.TxSaft  
	GROUP BY  
		A_TRADE_DATE,  
		A_TRADE_LINK_NO,  
		A_BUY_SELL_FLAG, 
		A_MOD_REASON_CODE 
  
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
		A_TRADE_LINK_NO AS TradingSysTransNo,  
		A_MATCH_PRICE_X AS TradePrice,  
		A_BEST_BID_PRICE AS BidPrice,  
		A_BEST_ASK_PRICE AS OfferPrice,  
		A_TRADE_SIZE_X AS TradeVolume,  
		A_ORDER_MARKET_VALUE AS TradeTurnover,  
		O.DwhFileID,  
		/* MINOR CHANGES */  
	--	IIF(A_DEFERRED_IND = 'Y' , 'Y', 'N' ) AS DelayedTradeYN  
		A_DEFERRED_IND AS DelayedTradeYN  
	FROM  
			dbo.TxSaft O  
		INNER JOIN  
			dbo.FileList F  
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
PRINT N'Creating [dbo].[FileListRawTc]'
GO
CREATE TABLE [dbo].[FileListRawTc] 
( 
[FileID] [int] NOT NULL IDENTITY(1, 1), 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[Populated] [datetime2] NOT NULL CONSTRAINT [DF_FileListRawTc_Populated] DEFAULT (getdate()) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FileListRawTc] on [dbo].[FileListRawTc]'
GO
ALTER TABLE [dbo].[FileListRawTc] ADD CONSTRAINT [PK_FileListRawTc] PRIMARY KEY CLUSTERED  ([FileID])
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
PRINT N'Creating [dbo].[RawTcC810]'
GO
CREATE TABLE [dbo].[RawTcC810] 
( 
[RawTc810Id] [int] NOT NULL IDENTITY(1, 1), 
[FileID] [int] NOT NULL, 
[REPORT_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[REPORT_EFF_DATE] [datetime] NULL, 
[REPORT_PROCESS_DATE] [datetime] NULL, 
[ENV_ONE] [tinyint] NULL, 
[ENV_TWO] [tinyint] NULL, 
[CLRMEM_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[CLRMEM_SETTLE_LOC] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[CLRMEM_SETTLE_ACC] [int] NULL, 
[EXCHMEMB_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[OWNER_EXMEMB_INST_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[OWNER_EXMEMB_BR_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[INSTRU_ISIN] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[UNITS] [tinyint] NULL, 
[TRANS_TIME] [bigint] NULL, 
[PARTA_SUBGRP_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[PARTA_USR_NO] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[UNIQ_TRADE_NO] [int] NULL, 
[TRADE_NO_SUFX] [tinyint] NULL, 
[TRANS_TYPE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[ORIGIN_TYPE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[CROSS_IND] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[SETTLE_IND] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[OTC_TRADE_TIME] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[ORDER_INSTR_ISIN] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[ORD_NO] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[EXECUTOR_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[INTERMEM_ORD_NO] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[FREE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[ACC_TYPE_CODE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[ACC_TYPE_NO] [tinyint] NULL, 
[BUY_SELL_IND] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[NETTING_TYPE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[MATCHED_QTY] [decimal] (28, 10) NULL, 
[MATCHED_PRICE] [decimal] (28, 10) NULL, 
[SETTLE_AMOUNT] [decimal] (28, 10) NULL, 
[SETTLE_DATE] [datetime] NULL, 
[SETTLE_CODE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[ACCRUED_INTEREST] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[ACCRUED_INTEREST_DAY] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[EXCHMEM_INST_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[EXCHMEM_BR_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[PART_USR_GRP_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[PART_USR_NO] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[COUNTER_EXCHMEM_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[COUNTER_EXCHMEM_BR_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[COUNTER_CRL_SET_MEM_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[COUNTER_SETL_LOC] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[COUNTER_SETL_ACC] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[COUNTER_KASSEN_NO] [int] NULL, 
[DEPOSITORY_TYPE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[TRANS_FEE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL, 
[TRANS_FEE_CURRENCY] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL 
) 
WITH 
( 
DATA_COMPRESSION = PAGE 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_RawTcC810] on [dbo].[RawTcC810]'
GO
ALTER TABLE [dbo].[RawTcC810] ADD CONSTRAINT [PK_RawTcC810] PRIMARY KEY CLUSTERED  ([RawTc810Id]) WITH (DATA_COMPRESSION = PAGE)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_RawTcC810] on [dbo].[RawTcC810]'
GO
CREATE NONCLUSTERED INDEX [IX_RawTcC810] ON [dbo].[RawTcC810] ([FileID])
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
