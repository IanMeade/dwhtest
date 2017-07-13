SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 28/4/2017  
-- Description: Validate T7TradeMainDataFlowOutput - move invalid rows into quarantine - Defered trade with no defered time specified 
-- =============================================  
CREATE PROCEDURE [dbo].[DELETE_ValidateT7TradeMainDataFlowOutputQuarantine_NegotiatedTradeWithoutDelay]  
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
			-199 AS Code,  
			'Trade [' + UniqueKey + '] moved to quarantine: Trade is marked NEGOTIATED DEAL but DEFERRED FLAG is not set.' AS Message  
		FROM  
				T7TradeMainDataFlowOutput  
		WHERE  
				TradeType = 'ND' 
			AND 
				DelayedTradeYN IS NULL 
 
 
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
		Code = -199 
		  
END  
GO
