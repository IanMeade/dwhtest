SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Ian Meade
-- Create date: 22/5/2017
-- Description:	Calls query to put get last trade details for equity and ETF trade snapshot tables - both in ne helper table
-- =============================================
CREATE PROCEDURE [ETL].[BuildLtpHelper]
	@DateID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	TRUNCATE TABLE ETL.FactEquityEtfLtpHelper

	INSERT INTO
			ETL.FactEquityEtfLtpHelper
		SELECT
			AggregationDateID,
			InstrumentGlobalID,
			PublishedDateTime,
			TradeDateID,
			TradeTimeID,
			TradeTimestamp,
			UTCTradeTimeStamp,
			TradePrice			
		FROM
			ETL.udfGetLastTradeDetailsEquity(@DateID) AS LTP

	INSERT INTO
			ETL.FactEquityEtfLtpHelper
		SELECT
			AggregationDateID,
			InstrumentGlobalID,
			PublishedDateTime,
			TradeDateID,
			TradeTimeID,
			TradeTimestamp,
			UTCTradeTimeStamp,
			TradePrice			
		FROM
			ETL.udfGetLastTradeDetailsEtf(@DateID) AS LTP


END

GO
