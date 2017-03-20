SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 8/3/2017
-- Description: Validate T7TradeMainDataFlowOutput - move invalid rows into quarantine
-- =============================================
CREATE PROCEDURE [dbo].[ValidateT7TradeMainDataFlowOutputQuarantine]
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
			1 AS Code,
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: ISIN [' + A_ISIN + '] could not be assigned to an instrument' AS Message
		FROM
			T7TradeMainDataFlowOutput
		WHERE
			InstrumentID IS NULL
		UNION
		SELECT
			TradeDateID,
			TradingSysTransNo,
			2 AS Code,
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Currency [' + A_PRICE_CURRENCY + '] could not be assigned' AS Message
		FROM
			T7TradeMainDataFlowOutput
		WHERE
			CurrencyID IS NULL
		UNION
		SELECT
			TradeDateID,
			TradingSysTransNo,
			3 AS Code,
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Junk dimension cannot be assigned. Check TradeSideCode, TradeOrderType, TradeOrderRestrictionCode, TradeType, PrincipalAgentCode, AuctionFlagCode and TradeFlags are valid and in MDM' AS Message
		FROM
			T7TradeMainDataFlowOutput
		WHERE
			EquityTradeJunkID IS NULL
		UNION
		SELECT
			TradeDateID,
			TradingSysTransNo,
			4 AS Code,
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Trade Modification Type [' + A_MOD_REASON_CODE + '] cannot be assigned. Check TradeSideCode, TradeOrderType, TradeOrderRestrictionCode, TradeType, PrincipalAgentCode, AuctionFlagCode and TradeFlags are valid and in MDM' AS Message
		FROM
			T7TradeMainDataFlowOutput
		WHERE
			TradeModificationTypeID IS NULL
		UNION
		SELECT
			TradeDateID,
			TradingSysTransNo,
			5 AS Code,
			'Trade [' + CAST(TradeDateID AS CHAR(8)) + '\' + RTRIM(CAST(TradingSysTransNo AS CHAR)) + '] moved to quarantine: Broker [' + A_MEMBER_ID + '] cannot be assigned. Check Broker is in MDM' AS Message
		FROM
			T7TradeMainDataFlowOutput
		WHERE
			BrokerID IS NULL

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


END
GO
