SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 28/4/2017 
-- Description: Validate T7TradeMainDataFlowOutput - move invalid rows into quarantine - Defered trade with no defered time specified
-- ============================================= 
CREATE PROCEDURE [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine_NegotiatedTradeWithoutDelay] 
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
			Code, 
			Message 
		) 
		SELECT 
			TradeDateID, 
			TradingSysTransNo, 
			-199 AS Code, 
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Trade is marked NEGOTIATED DEAL but DEFERRED FLAG is not set.' AS Message 
		FROM 
				T7TradeMainDataFlowOutput 
		WHERE 
				TradeType = 'ND'
			AND
				DelayedTradeYN IS NULL


	/* Remove invalid rows from T7TradeMainDataFlowOutput */ 
 
	DELETE 
		T7TradeMainDataFlowOutput 
	WHERE 
		EXISTS ( 
					SELECT 
						* 
					FROM 
						dbo.T7QuarantineTrade Q 
					WHERE 
						T7TradeMainDataFlowOutput.TradingSysTransNo = Q.TradingSysTransNo 
					AND 
						T7TradeMainDataFlowOutput.TradeDateID = Q.TradeDateID  
			) 
 
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
