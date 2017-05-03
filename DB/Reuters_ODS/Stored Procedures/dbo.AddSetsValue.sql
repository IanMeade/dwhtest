SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Ian Meade
-- Create date: 13/4/2017
-- Description:	Add sets value rate to the ODS - keep one value per day - daye is assumed to be today
-- =============================================
CREATE PROCEDURE [dbo].[AddSetsValue]
	@ISIN VARCHAR(12),
	@TURNOVER NUMERIC(19,6),
	@VOLUME NUMERIC(19,6),
	@DEALS INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @DATE AS DATE = GETDATE()

	IF EXISTS( SELECT * FROM dbo.SetsValue WHERE SetsDate = @DATE AND ISIN = @ISIN )
	BEGIN
		/* UPDATE EXISTING RATE */
		UPDATE
			dbo.SetsValue
		SET
			ValueInserted = GETDATE(),
			ISIN = @ISIN,
			TURNOVER = @TURNOVER,
			VOLUME = @VOLUME,
			DEALS = @DEALS
		WHERE
			SetsDate = @DATE 
		AND 
			ISIN = @ISIN
	END
	ELSE
	BEGIN
		/* INSERT A NEW ROW */
		INSERT INTO
				dbo.SetsValue
			(
				SetsDate, 
				ISIN, 
				TURNOVER, 
				VOLUME, 
				DEALS
			)
			VALUES
			(
				@DATE,
				@ISIN, 
				@TURNOVER, 
				@VOLUME, 
				@DEALS
			)
	END
END


GO
