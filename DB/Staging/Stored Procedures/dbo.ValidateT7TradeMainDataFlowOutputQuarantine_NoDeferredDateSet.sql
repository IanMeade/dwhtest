SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 28/4/2017  
-- Description: Validate T7TradeMainDataFlowOutput - move invalid rows into quarantine - Defered trade with no defered time specified 
-- =============================================  
CREATE PROCEDURE [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine_NoDeferredDateSet]  
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
