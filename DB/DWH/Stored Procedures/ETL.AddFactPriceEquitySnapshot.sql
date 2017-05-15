SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 10/5/2017
-- Description:	Take a price sample from FactEquitySnapshot and FactEtfSnapshot for website
-- =============================================
CREATE PROCEDURE [ETL].[AddFactPriceEquitySnapshot]
	@DateID INT,
	@BatchID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @DateChar CHAR(8) = CAST(@DateID AS CHAR)

	/* GET THE TIME FROM THE DimFile TABLE */

	DECLARE @SampleTime TIME
	
	SELECT
		@SampleTime = MAX(ExpectedStartTime)
	FROM
		DWH.DimFile
	WHERE
			FileTypeTag = 'TxSaft'
		AND
			CHARINDEX(@DateChar,FileName) <> 0
		AND
			FileProcessedStatus = 'COMPLETE'

	IF @SampleTime IS NOT NULL
	BEGIN

		/* BIT PRIMATIVE */

		/* DELETE EXISITNG ROWS */

		DELETE
			F
		FROM	
			DWH.FactEquityPriceSnapshot F
		WHERE
			F.SampleDateID = @DateID
		AND 
			F.SampleTime = @SampleTime

		INSERT INTO
				DWH.FactEquityPriceSnapshot
			(
				SampleDateID, 
				SampleTime, 
				InstrumentID, 
				LtpDateID, 
				LtpTimeID, 
				LTP, 
				BatchID
			)
			SELECT
				@DateID,
				@SampleTime,
				InstrumentID,
				LTPDateID,
				LTPTimeID,
				LTP,
				@BatchID AS BatchID
			FROM
				DWH.FactEquitySnapshot
			WHERE
				DateID = @DateID
			UNION ALL
			SELECT			
				@DateID,
				@SampleTime,
				InstrumentID,
				LTPDateID,
				LTPTimeID,
				LTP,
				@BatchID AS BatchID
			FROM
				DWH.FactEtfSnapshot	
			WHERE
				DateID = @DateID
		
	END

END
GO
