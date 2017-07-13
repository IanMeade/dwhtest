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
	@TURNOVER VARCHAR(100),  
	@VOL VARCHAR(100),  
	@DEALS VARCHAR(100)
AS  
BEGIN  
	SET NOCOUNT ON;  
  
	DECLARE @DATE AS DATE = GETDATE()  

	/* CONVERT INPUT STRINGS INTO NUMBERS - REQUIRED AS BRAIN / EXCEL IS SENDING NUMBERS IN REAL FORMAT AND SQL WAS NOT PROCESSING CORRECTLY */
	DECLARE @TURNOVER_NUMBER NUMERIC(19,6)
	DECLARE @VOL_NUMBER NUMERIC(19,6)
	DECLARE @DEALS_NUMBER INT


	SELECT
		@TURNOVER_NUMBER = CAST(CAST(@TURNOVER AS real) AS NUMERIC(19,6)),
		@VOL_NUMBER	= CAST(CAST(@VOL AS real) AS NUMERIC(19,6)),
		@DEALS_NUMBER = CAST(CAST(@DEALS AS REAL) AS INT)
		
	/* VALIDATE VOLUME */
	IF @TURNOVER_NUMBER > 2000000
	BEGIN
		DECLARE @MESSAGE VARCHAR(200) = 'Invalid Turnover passed. Maximium supported value is 2000000, ' + @TURNOVER + ' was passed'
		RAISERROR( @MESSAGE, 16, 1 )
	END
	ELSE
	BEGIN
		/* TRY TO PROCESS THE MESSAGE */

		IF EXISTS( SELECT * FROM dbo.SetsValue WHERE SetsDate = @DATE AND ISIN = @ISIN )  
		BEGIN  
			/* UPDATE EXISTING RATE */  
			UPDATE  
				dbo.SetsValue  
			SET  
				ValueInserted = GETDATE(),  
				ISIN = @ISIN,  
				TURNOVER = @TURNOVER_NUMBER,  
				VOLUME = @VOL_NUMBER,  
				DEALS = @DEALS_NUMBER  
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
					@TURNOVER_NUMBER,   
					@VOL_NUMBER,   
					@DEALS_NUMBER
				)  
		END  
	END  
END



GO
