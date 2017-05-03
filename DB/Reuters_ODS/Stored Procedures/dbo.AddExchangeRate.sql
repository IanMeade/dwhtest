SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 13/4/2017
-- Description:	Add an exchange rate to the ODS - keep one value per day - daye is assumed to be today
-- =============================================
CREATE PROCEDURE [dbo].[AddExchangeRate]
	@CCY CHAR(3),
	@VAL NUMERIC(19,6)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @DATE AS DATE = GETDATE()

	IF EXISTS( SELECT * FROM dbo.ExchangeRateValue WHERE ExchangeRateDate = @DATE AND CCY = @CCY )
	BEGIN
		/* UPDATE EXISTING RATE */
		UPDATE
			dbo.ExchangeRateValue
		SET
			ValueInserted = GETDATE(),
			ExchangeRateDate = GETDATE(),
			VAL = @VAL
		WHERE
			ExchangeRateDate = @DATE 
		AND 
			CCY = @CCY 
	END
	ELSE
	BEGIN
		/* INSERT A NEW ROW */
		INSERT INTO
				dbo.ExchangeRateValue
			(
				ExchangeRateDate, 
				CCY, 
				VAL
			)
			VALUES
			(
				@DATE,
				@CCY,
				@VAL
			)
	END
END

GO
