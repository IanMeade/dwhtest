SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		Ian Meade
-- Create date: 03/2/2016
-- Description:	WIP
-- =============================================
CREATE PROCEDURE [dbo].[ValidateSaftMainDataFlow]
AS
BEGIN
	SET NOCOUNT ON;


	SELECT 
		'ISIN NOT FOUND' AS QuarantineReasom,
		[A_MEMBER_ID],
		[A_ISIN],
		[TradeDateID],
		[TradingSysTransNo],
		[A_BUY_SELL_FLAG],
		[DwhFileID]
	FROM 
		[dbo].[T7TradeMianDataFlowOutput]
	WHERE
		InstrumentID IS NULL
	UNION ALL
	SELECT 
		'BROKER NOT FOUND' AS QuarantineReasom,
		[A_MEMBER_ID],
		[A_ISIN],
		[TradeDateID],
		[TradingSysTransNo],
		[A_BUY_SELL_FLAG],
		[DwhFileID]
	FROM 
		[dbo].[T7TradeMianDataFlowOutput]
	WHERE
		[BrokerID] IS NULL
	UNION ALL
	SELECT 
		'GENERIC BAD KEY' AS QuarantineReasom,
		[A_MEMBER_ID],
		[A_ISIN],
		[TradeDateID],
		[TradingSysTransNo],
		[A_BUY_SELL_FLAG],
		[DwhFileID]
	FROM 
		[dbo].[T7TradeMianDataFlowOutput]
	WHERE
		/*
			InstrumentID IS NULL
		OR
			[BrokerID] IS NULL
		*/
			[TradeDateID] IS NULL
		OR
			[TradeTimeID] IS NULL
		OR
			[PublishDateID] IS NULL
		OR
			[PublishTimeID] IS NULL
		OR
			[EquityTradeJunkID] IS NULL
		OR
			[TraderID] IS NULL
		OR
			[CurrencyID] IS NULL
		OR
			[TradeModificationTypeID] IS NULL
		OR
			[DwhFileID] IS NULL
		OR
			[BatchID] IS NULL
		OR
			[CancelBatchID] IS NULL


END



GO
