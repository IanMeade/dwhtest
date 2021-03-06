/* 
Run this script on: 
 
        T7-SYS-DW-01.Staging    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.Staging 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 21/06/2017 17:16:17 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [Staging]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 8/3/2017   
-- Description: Validate T7TradeMainDataFlowOutput - move invalid rows into quarantine   
-- =============================================   
ALTER PROCEDURE [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine]   
AS   
BEGIN   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
	TRUNCATE TABLE dbo.T7QuarantineTrade   
   
	INSERT INTO   
			dbo.T7QuarantineTrade   
		(   
			TradeDateID,  
			TradingSysTransNo,  
			ISIN,  
			TradeTypeCategory, 
			Code,  
			Message 
		)   
		SELECT   
			TradeDateID,  
			TradingSysTransNo,  
			A_ISIN,  
			TradeTypeCategory,   
			1 AS Code,   
			'Trade [' + UniqueKey  + '] moved to quarantine: ISIN [' + A_ISIN + '] could not be assigned to an instrument' AS Message   
		FROM   
			T7TradeMainDataFlowOutput   
		WHERE   
			InstrumentID IS NULL   
		UNION ALL 
		SELECT   
			TradeDateID,   
			TradingSysTransNo,   
			A_ISIN,  
			TradeTypeCategory,   
			2 AS Code,   
			'Trade [' + UniqueKey + '] moved to quarantine: Currency [' + A_PRICE_CURRENCY + '] could not be assigned' AS Message   
		FROM   
			T7TradeMainDataFlowOutput   
		WHERE   
			CurrencyID IS NULL   
		UNION  
		SELECT   
			TradeDateID,   
			TradingSysTransNo,   
			A_ISIN,  
			TradeTypeCategory,   
			3 AS Code,   
			'Trade [' + UniqueKey + '] moved to quarantine: Junk dimension cannot be assigned. Check TradeSideCode, TradeOrderType, TradeOrderRestrictionCode, TradeType, PrincipalAgentCode, AuctionFlagCode and TradeFlags are valid and in MDM' AS Message   
		FROM   
			T7TradeMainDataFlowOutput   
		WHERE   
			EquityTradeJunkID IS NULL   
		UNION  
		SELECT   
			TradeDateID,   
			TradingSysTransNo,   
			A_ISIN,  
			TradeTypeCategory,   
			4 AS Code,   
			'Trade [' + UniqueKey + '] moved to quarantine: Trade Modification Type [' + A_MOD_REASON_CODE + '] cannot be assigned. Check TradeSideCode, TradeOrderType, TradeOrderRestrictionCode, TradeType, PrincipalAgentCode, AuctionFlagCode and TradeFlags are valid and in MDM' AS Message   
		FROM   
			T7TradeMainDataFlowOutput   
		WHERE   
			TradeModificationTypeID IS NULL   
		UNION  
		SELECT   
			TradeDateID,   
			TradingSysTransNo,   
			A_ISIN,  
			TradeTypeCategory,   
			5 AS Code,   
			'Trade [' + UniqueKey + '] moved to quarantine: Broker [' + A_MEMBER_ID + '] cannot be assigned. Check Broker is in MDM' AS Message   
		FROM   
			T7TradeMainDataFlowOutput   
		WHERE   
			BrokerID IS NULL   
		/* MOVED TO SEPERATE STORED PROCEDURE TO ALLOW CONTROL FROM PROCESS CONTROL */  
		/*  
		UNION   
		SELECT   
			TradeDateID,   
			TradingSysTransNo,   
			6 AS Code,   
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Trade is marked DELAYED but PUBLISH TIME is not set.' AS Message   
		FROM   
			T7TradeMainDataFlowOutput   
		WHERE   
				DelayedTradeYN = 'Y'  
			AND  
				PublishDateTime IS NULL  
		*/  
		UNION  
		SELECT   
			TradeDateID,   
			TradingSysTransNo,   
			A_ISIN,  
			TradeTypeCategory,   
			6 AS Code,   
			'Trade [' + UniqueKey + '] moved to quarantine: ISIN [' + A_ISIN + '] with Instrument Status [' + StatusName + '] is not supported .' AS Message   
		FROM   
			T7TradeMainDataFlowOutput   
		WHERE   
			StatusName NOT IN ( 'Listed', 'ConditionalDealings' )  
		UNION  
		SELECT   
			TradeDateID,   
			TradingSysTransNo,   
			A_ISIN,  
			TradeTypeCategory,   
			7 AS Code,   
			'Trade [' + UniqueKey + '] moved to quarantine: ISIN [' + A_ISIN + '] with Instrument Type [' + InstrumentType + '] is not supported.' AS Message   
		FROM   
			T7TradeMainDataFlowOutput   
		WHERE   
			InstrumentType NOT IN ( 'EQUITY', 'ETF' )  
  
	/* Second set of validation - removes trades without 2 rws in thetrade. Possible 1 row has been removed by validation above and left an orphan */  
 	INSERT INTO   
			dbo.T7QuarantineTrade   
		(   
			TradeDateID,   
			TradingSysTransNo,   
			ISIN,  
			TradeTypeCategory,   
			Code,   
			Message   
		)   
  
		SELECT  
			TradeDateID,  
			TradingSysTransNo,  
			A_ISIN,  
			TradeTypeCategory,   
			101 as Code,  
			'Trade [' + MAX(UniqueKey) + '] moved to quarantine. [' + STR(COUNT(*)) + '] rows in trade - exected 2 (Buy and Sell).' AS Message   
		FROM   
			T7TradeMainDataFlowOutput   
		WHERE  
			A_MOD_REASON_CODE = '001'  
		GROUP BY  
			TradeDateID,  
			TradingSysTransNo,  
			A_ISIN,  
			TradeTypeCategory 
		HAVING  
			COUNT(*) <> 2  
		  
  
		/* Remove invalid rows from T7TradeMainDataFlowOutput */   
   
		DELETE   
			STG 
		FROM 
				T7TradeMainDataFlowOutput STG 
			INNER JOIN 
				dbo.T7QuarantineTrade BAD 
			ON STG.TradeDateID = BAD.TradeDateID  
			AND STG.TradingSysTransNo = BAD.TradingSysTransNo 
			AND STG.A_ISIN = BAD.ISIN 
			AND STG.TradeTypeCategory = BAD.TradeTypeCategory 
 
		/* Return results to validation framework */   
		SELECT   
			Code,   
			Message   
		FROM   
			dbo.T7QuarantineTrade   
   
   
END   
  
 
SELECT * FROM T7TradeMainDataFlowOutput   
SELECT * FROM dbo.T7QuarantineTrade BAD 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine_NoDeferredDateSet]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 28/4/2017   
-- Description: Validate T7TradeMainDataFlowOutput - move invalid rows into quarantine - Defered trade with no defered time specified  
-- =============================================   
ALTER PROCEDURE [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine_NoDeferredDateSet]   
AS   
BEGIN   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
	TRUNCATE TABLE dbo.T7QuarantineTrade   
   
	INSERT INTO   
			dbo.T7QuarantineTrade   
		(   
			TradeDateID,  
			TradingSysTransNo,  
			ISIN,  
			TradeTypeCategory, 
			Code,  
			Message 
		)   
		SELECT   
			TradeDateID,  
			TradingSysTransNo,  
			A_ISIN,  
			TradeTypeCategory,    
			/* IMPORTANT - ENSURE CODE IS IN FILTER AT END OF SP */  
			-101 AS Code,   
			'Trade [' + UniqueKey + '] moved to quarantine: Trade is NEGOTIATED DEAL but DEFERRED INDICATOR is not set.' AS Message   
		FROM   
			T7TradeMainDataFlowOutput   
		WHERE   
				TradeType ='ND'  
			AND   
				DelayedTradeYN NOT IN ( 'N', 'Y' )  
		UNION  
		SELECT   
			TradeDateID,  
			TradingSysTransNo,  
			A_ISIN,  
			TradeTypeCategory,   
			/* IMPORTANT - ENSURE CODE IS IN FILTER AT END OF SP */  
			-99 AS Code,   
			'Trade [' + UniqueKey + '] moved to quarantine: Trade is marked DEFERRED but PUBLISH TIME is not set.' AS Message   
		FROM   
			T7TradeMainDataFlowOutput   
		WHERE   
				DelayedTradeYN = 'Y'  
			AND  
				PublishDateTime IS NULL  
		UNION  
		SELECT   
			TradeDateID,  
			TradingSysTransNo,  
			A_ISIN,  
			TradeTypeCategory,   
			/* IMPORTANT - ENSURE CODE IS IN FILTER AT END OF SP */  
			-99 AS Code,   
			'Trade [' + UniqueKey + '] moved to quarantine: Trade is marked DEFERRED but PUBLISH TIME is not set.' AS Message   
		FROM   
			T7TradeMainDataFlowOutput   
		WHERE   
				DelayedTradeYN = 'Y'  
			AND  
				/* DB is using AS SPECIAL / NULL VALUE - APPLY SAME CHECK AS BEFORE */ 
				CAST(PublishDateTime AS date) = '18581117' 
  
	/* Remove invalid rows from T7TradeMainDataFlowOutput */   
   
	DELETE   
		STG 
	FROM 
			T7TradeMainDataFlowOutput STG 
		INNER JOIN 
			dbo.T7QuarantineTrade BAD 
		ON STG.TradeDateID = BAD.TradeDateID  
		AND STG.TradingSysTransNo = BAD.TradingSysTransNo 
		AND STG.A_ISIN = BAD.ISIN 
		AND STG.TradeTypeCategory = BAD.TradeTypeCategory 
 
	/* Return results to validation framework */   
	SELECT   
		Code,   
		Message   
	FROM   
		dbo.T7QuarantineTrade   
	WHERE  
		/* Only ones raised by this puppy */  
		Code IN ( -99, -101 )  
		   
END   
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
