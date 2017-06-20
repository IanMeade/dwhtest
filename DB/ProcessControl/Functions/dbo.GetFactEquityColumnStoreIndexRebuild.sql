SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 02/6/2017  
-- Description:	Bulld commnad string to rebuld column stored index -  
--				Assumption - index rebuild is late in date => include today as last day in filter 
-- =============================================  
CREATE FUNCTION  [dbo].[GetFactEquityColumnStoreIndexRebuild](  
)  
RETURNS VARCHAR(3000) 
AS  
BEGIN  
	DECLARE @CMD AS VARCHAR(3000) 
  
	SELECT 
		@CMD = REPLACE(SwitchValue,'?',CONVERT(CHAR,GETDATE(),112)) 
	FROM 
		dbo.Switches 
	WHERE 
		SwitchKey = 'INDEX_REBUILD' 
 
---	REPLACE('CREATE NONCLUSTERED COLUMNSTORE INDEX [FactEquityTradeNonClusteredColumnStoreIndex] ON [DWH].[FactEquityTrade] ([EquityTradeID],	[InstrumentID],	[TradingSysTransNo],	[TradeDateID],	[TradeTimeID],	[TradeTimestamp],	[UTCTradeTimeStamp],	[PublishDateID],	[PublishTimeID],	[PublishedDateTime],	[UTCPublishedDateTime],	[DelayedTradeYN],	[EquityTradeJunkID],	[BrokerID],	[TraderID],	[CurrencyID],	[TradePrice],	[BidPrice],	[OfferPrice],	[TradeVolume],	[TradeTurnover],	[TradeModificationTypeID],	[TradeCancelled],	[InColumnStore],	[TradeFileID],	[BatchID],	[CancelBatchID] ) WHERE ([TradeDateID]<=(?)) WITH (DROP_EXISTING = ON, COMPRESSION_DELAY = 0) ON [PRIMARY]','?','00010101') 
  
	RETURN @CMD   
END  
 
GO
