SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================    
-- Author:		Ian Meade    
-- Create date: 25/4/2017    
-- Description:	Update FactEquityIndexSnapshot with details in merge table    
-- =============================================    
CREATE PROCEDURE [ETL].[UpdateFactEquityIndexSnapshot]    
	@BatchID INT
AS    
BEGIN    
	SET NOCOUNT ON;    


	MERGE    
			DWH.FactEquityIndexSnapshot AS DWH    
		USING (    
				SELECT    
					IndexDateID,     
					IndexTypeID,     
					OpenValue,     
					LastValue AS CloseValue,     
					ReturnValue,     
					DailyLowValue,     
					DailyHighValue,     
					InterestRate,     
					MarketCap    
				FROM    
					ETL.FactEquityIndexSnapshotMerge    
			) AS ETL (     
					IndexDateID,     
					IndexTypeID,     
					OpenValue,     
					CloseValue,     
					ReturnValue,     
					DailyLowValue,     
					DailyHighValue,     
					InterestRate,     
					MarketCap     
				)    
			ON (    
				DWH.DateID = ETL.IndexDateID    
			AND    
				DWH.IndexTypeID = ETL.IndexTypeID    
			)    
		WHEN MATCHED     
			THEN UPDATE SET    
				DWH.OpenValue = ETL.OpenValue,     
				DWH.CloseValue = ETL.CloseValue,     
				DWH.ReturnIndex = ETL.ReturnValue,     
				DWH.DailyLow = ETL.DailyLowValue,     
				DWH.DailyHigh = ETL.DailyHighValue,     
				DWH.InterestRate = ETL.InterestRate,     
				DWH.MarketCap = ETL.MarketCap    
		WHEN NOT MATCHED    
			THEN INSERT     
				(    
					DateID,     
					IndexTypeID,     
					OpenValue,     
					CloseValue,     
					ReturnIndex,     
					MarketCap,     
					DailyHigh,     
					DailyLow,     
					InterestRate,     
					BatchID    
				)    
				VALUES    
				(     
					IndexDateID,     
					IndexTypeID,     
					OpenValue,     
					CloseValue,     
					ReturnValue,     
					MarketCap,     
					DailyLowValue,     
					DailyHighValue,     
					InterestRate,     
					@BatchID     
				);    
    
END    
GO
