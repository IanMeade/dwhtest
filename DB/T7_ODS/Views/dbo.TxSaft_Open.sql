SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
		FileID AS DwhFileID,
		/* MINOR CHANGES */
		IIF(A_DEFERRED_IND = 'Y' , 'Y', 'N' ) AS DelayedTradeYN
	FROM
			dbo.TxSaft O

	WHERE
		/* APPLY FILTERS */

		/* OPEN FILES ONLY */
		EXISTS (
					SELECT
						*
					FROM
							dbo.[File] F
						INNER JOIN
							dbo.TxSaft TX
						ON F.DwhFileID = TX.FileID
					WHERE
						F.DwhStatus NOT IN ( 'COMPLETE', 'REJECT' )
					AND
						O.FileID= TX.FileID
			)
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