SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 5/5/2017
-- Description:	Adds an entyr to the p[rice snapshot
-- =============================================
CREATE PROCEDURE [ETL].[AddFactEquityPriceSnapshot_DELETE]
	@AggregationDateID INT
AS
BEGIN
--	SET NOCOUNT ON;


	/* Add a Price sample for the currently available Snapshot entries */

	DECLARE @DateID INT
	DECLARE @TimeID SMALLINT

	SELECT
		@DateID = CAST(CONVERT(CHAR,GETDATE(),112) AS int)

	SELECT
		@TimeID = CAST(REPLACE(LEFT(CONVERT(CHAR,GETDATE(),114),5),':','') AS SMALLINT)

	IF @AggregationDateID = @DateID
	BEGIN
		/* Add a sample for currenty avaialbe details - do not add a smaple for re-aggregations */

		INSERT INTO
				DWH.FactEquityPriceSnapshot
			(
				SampleDateID, 
				SampleTimeID, 
				InstrumentID, 
				LtpDateID, 
				LtpTimeID, 
				LTP
			)
			SELECT
				@DateID,
				@TimeID,
				InstrumentID,
				LTPDateID,
				LTPTimeID,
				LTP
			FROM
				DWH.FactEquitySnapshot SN
			WHERE
				DateID = @DateID
				/*
					Does not check if a smaple alreayd exists
							AND
								NOT EXISTS (
										SELECT
											*
										FROM
											DWH.FactEquityPriceSnapshot S1
										WHERE
											S1.SampleDateID = @DateID
										AND
											SN.InstrumentID = S1.InstrumentID
									)
				*/
			UNION ALL
			SELECT
				@DateID,
				@TimeID,
				InstrumentID,
				LTPDateID,
				LTPTimeID,
				LTP
			FROM
				DWH.FactEtfSnapshot SN
			WHERE
				DateID = @DateID
				/*
					Does not check if a smaple alreayd exists
							AND
								NOT EXISTS (
										SELECT
											*
										FROM
											DWH.FactEquityPriceSnapshot S1
										WHERE
											S1.SampleDateID = @DateID
										AND
											SN.InstrumentID = S1.InstrumentID
									)
				*/

				PRINT 'HELLO'
	END
END
GO
