/* 
Run this script on: 
 
        T7-DDT-06.Reuters_ODS    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.Reuters_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 19/06/2017 16:52:02 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [Reuters_ODS]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating role OdsWriter'
GO
CREATE ROLE [OdsWriter] 
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ExchangeRateValue]'
GO
CREATE TABLE [dbo].[ExchangeRateValue] 
( 
[ExchangeRateID] [int] NOT NULL IDENTITY(1, 1), 
[ValueInserted] [datetime2] NOT NULL CONSTRAINT [DF_ExchangeRateValue_ValueInserted] DEFAULT (getdate()), 
[ExchangeRateDate] [date] NOT NULL CONSTRAINT [DF_ExchangeRateValue_ExchangeRateDate] DEFAULT (getdate()), 
[CCY] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[VAL] [numeric] (19, 6) NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ExchangeRateValue] on [dbo].[ExchangeRateValue]'
GO
ALTER TABLE [dbo].[ExchangeRateValue] ADD CONSTRAINT [PK_ExchangeRateValue] PRIMARY KEY CLUSTERED  ([ExchangeRateID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_ExchangeRateValue] on [dbo].[ExchangeRateValue]'
GO
CREATE NONCLUSTERED INDEX [IX_ExchangeRateValue] ON [dbo].[ExchangeRateValue] ([ExchangeRateID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AddExchangeRate]'
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
		DELETE   
			dbo.ExchangeRateValue   
		WHERE   
			ExchangeRateDate = @DATE    
		AND    
			CCY = @CCY    
	END   
   
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
   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[IndexValue]'
GO
CREATE TABLE [dbo].[IndexValue] 
( 
[IndexValueID] [int] NOT NULL IDENTITY(1, 1), 
[ValueInserted] [datetime2] NOT NULL CONSTRAINT [DF_IndexValue_ValueInserted] DEFAULT (getdate()), 
[OLAST] [numeric] (8, 3) NULL, 
[OOPEN] [numeric] (8, 3) NULL, 
[OHIGH] [numeric] (15, 3) NULL, 
[OLOW] [numeric] (8, 3) NULL, 
[ORETURN] [numeric] (8, 3) NULL, 
[FLAST] [numeric] (8, 3) NULL, 
[FOPEN] [numeric] (8, 3) NULL, 
[FHIGH] [numeric] (15, 3) NULL, 
[FLOW] [numeric] (8, 3) NULL, 
[FRETURN] [numeric] (8, 3) NULL, 
[GLAST] [numeric] (8, 3) NULL, 
[GOPEN] [numeric] (8, 3) NULL, 
[GHIGH] [numeric] (15, 3) NULL, 
[GLOW] [numeric] (8, 3) NULL, 
[GRETURN] [numeric] (8, 3) NULL, 
[SLAST] [numeric] (8, 3) NULL, 
[SOPEN] [numeric] (8, 3) NULL, 
[SHIGH] [numeric] (15, 3) NULL, 
[SLOW] [numeric] (8, 3) NULL, 
[SRETURN] [numeric] (8, 3) NULL, 
[ILAST] [numeric] (8, 3) NULL, 
[IOPEN] [numeric] (8, 3) NULL, 
[IHIGH] [numeric] (15, 3) NULL, 
[ILOW] [numeric] (8, 3) NULL, 
[IRETURN] [numeric] (8, 3) NULL, 
[ELAST] [numeric] (8, 3) NULL, 
[EOPEN] [numeric] (8, 3) NULL, 
[EHIGH] [numeric] (15, 3) NULL, 
[ELOW] [numeric] (8, 3) NULL, 
[ERETURN] [numeric] (8, 3) NULL, 
[NLAST] [numeric] (8, 3) NULL, 
[NOPEN] [numeric] (8, 3) NULL, 
[NHIGH] [numeric] (15, 3) NULL, 
[NLOW] [numeric] (8, 3) NULL, 
[XLAST] [numeric] (8, 3) NULL, 
[XOPEN] [numeric] (8, 3) NULL, 
[XHIGH] [numeric] (15, 3) NULL, 
[XLOW] [numeric] (8, 3) NULL, 
[XRETURN] [numeric] (8, 3) NULL, 
[VLAST] [numeric] (8, 3) NULL, 
[VOPEN] [numeric] (8, 3) NULL, 
[VHIGH] [numeric] (15, 3) NULL, 
[VLOW] [numeric] (8, 3) NULL, 
[VRETURN] [numeric] (8, 3) NULL, 
[LLAST] [numeric] (8, 3) NULL, 
[LOPEN] [numeric] (8, 3) NULL, 
[LHIGH] [numeric] (15, 3) NULL, 
[LLOW] [numeric] (8, 3) NULL, 
[LRETURN] [numeric] (8, 3) NULL, 
[CLAST] [numeric] (8, 3) NULL, 
[COPEN] [numeric] (8, 3) NULL, 
[CHIGH] [numeric] (15, 3) NULL, 
[CLOW] [numeric] (8, 3) NULL, 
[CRETURN] [numeric] (8, 3) NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_IndexValue] on [dbo].[IndexValue]'
GO
ALTER TABLE [dbo].[IndexValue] ADD CONSTRAINT [PK_IndexValue] PRIMARY KEY CLUSTERED  ([IndexValueID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AddIndexValue]'
GO
   
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 13/4/2017   
-- Description:	Insert index values into ODS   
-- =============================================   
CREATE PROCEDURE [dbo].[AddIndexValue]   
		@v_OVERALL_LAST NUMERIC(8,3),   
        @v_OVERALL_OPEN NUMERIC(8,3),   
        @v_OVERALL_HIGH NUMERIC(8,3),   
        @v_OVERALL_LOW NUMERIC(8,3),   
        @v_OVERALL_RETURN NUMERIC(8,3),   
        @v_FINANCIAL_LAST NUMERIC(8,3),   
        @v_FINANCIAL_OPEN NUMERIC(8,3),   
        @v_FINANCIAL_HIGH NUMERIC(8,3),   
        @v_FINANCIAL_LOW NUMERIC(8,3),   
        @v_FINANCIAL_RETURN NUMERIC(8,3),   
        @v_GENERAL_LAST NUMERIC(8,3),   
        @v_GENERAL_OPEN NUMERIC(8,3),   
        @v_GENERAL_HIGH NUMERIC(8,3),   
        @v_GENERAL_LOW NUMERIC(8,3),   
        @v_GENERAL_RETURN NUMERIC(8,3),   
        @v_SMALL_LAST NUMERIC(8,3),   
        @v_SMALL_OPEN NUMERIC(8,3),   
        @v_SMALL_HIGH NUMERIC(8,3),   
        @v_SMALL_LOW NUMERIC(8,3),   
        @v_SMALL_RETURN NUMERIC(8,3),   
        @v_ITEQ_LAST NUMERIC(8,3),   
        @v_ITEQ_OPEN NUMERIC(8,3),   
        @v_ITEQ_HIGH NUMERIC(8,3),   
        @v_ITEQ_LOW NUMERIC(8,3),   
        @v_ITEQ_RETURN NUMERIC(8,3),   
        @v_ETF_LAST NUMERIC(8,3),   
        @v_ETF_OPEN NUMERIC(8,3),   
        @v_ETF_HIGH NUMERIC(8,3),   
        @v_ETF_LOW NUMERIC(8,3),   
        @v_ETF_RETURN NUMERIC(8,3),   
        @v_INAV_LAST NUMERIC(8,3),   
        @v_INAV_OPEN NUMERIC(8,3),   
        @v_INAV_HIGH NUMERIC(8,3),   
        @v_INAV_LOW NUMERIC(8,3),   
        @v_IEX_LAST NUMERIC(8,3),   
        @v_IEX_OPEN NUMERIC(8,3),   
        @v_IEX_HIGH NUMERIC(8,3),   
        @v_IEX_LOW NUMERIC(8,3),   
        @v_IEX_RETURN NUMERIC(8,3),   
        @v_INVERSE_LAST NUMERIC(8,3),   
        @v_INVERSE_OPEN NUMERIC(8,3),   
        @v_INVERSE_HIGH NUMERIC(8,3),   
        @v_INVERSE_LOW NUMERIC(8,3),   
        @v_INVERSE_RETURN NUMERIC(8,3),   
        @v_LEVERAGED_LAST NUMERIC(8,3),   
        @v_LEVERAGED_OPEN NUMERIC(8,3),   
        @v_LEVERAGED_HIGH NUMERIC(8,3),   
        @v_LEVERAGED_LOW NUMERIC(8,3),   
        @v_LEVERAGED_RETURN NUMERIC(8,3),   
        @v_CAPPED_LAST NUMERIC(8,3),   
        @v_CAPPED_OPEN NUMERIC(8,3),   
        @v_CAPPED_HIGH NUMERIC(8,3),   
        @v_CAPPED_LOW NUMERIC(8,3),   
        @v_CAPPED_RETURN NUMERIC(8,3)   
		      
   
AS   
BEGIN   
	-- SET NOCOUNT ON added to prevent extra result sets from   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
   
	INSERT INTO	   
			dbo.IndexValue   
		(        
			OLAST,   
			OOPEN,   
			OHIGH,   
			OLOW,   
			ORETURN,   
			FLAST,   
			FOPEN,   
			FHIGH,   
			FLOW,   
			FRETURN,   
			GLAST,   
			GOPEN,   
			GHIGH,   
			GLOW,   
			GRETURN,   
			SLAST,   
			SOPEN,   
			SHIGH,   
			SLOW,   
			SRETURN,   
			ILAST,   
			IOPEN,   
			IHIGH,   
			ILOW,   
			IRETURN,   
			ELAST,   
			EOPEN,   
			EHIGH,   
			ELOW,   
			ERETURN,   
			NLAST,   
			NOPEN,   
			NHIGH,   
			NLOW,   
			XLAST,   
			XOPEN,   
			XHIGH,   
			XLOW,   
			XRETURN,   
			VLAST,   
			VOPEN,   
			VHIGH,   
			VLOW,   
			VRETURN,   
			LLAST,   
			LOPEN,   
			LHIGH,   
			LLOW,   
			LRETURN,   
			CLAST,   
			COPEN,   
			CHIGH,   
			CLOW,   
			CRETURN   
		)   
		VALUES   
		(   
			@v_OVERALL_LAST,   
			@v_OVERALL_OPEN,   
			@v_OVERALL_HIGH,   
			@v_OVERALL_LOW,   
			@v_OVERALL_RETURN,   
			@v_FINANCIAL_LAST,   
			@v_FINANCIAL_OPEN,   
			@v_FINANCIAL_HIGH,   
			@v_FINANCIAL_LOW,   
			@v_FINANCIAL_RETURN,   
			@v_GENERAL_LAST,   
			@v_GENERAL_OPEN,   
			@v_GENERAL_HIGH,   
			@v_GENERAL_LOW,   
			@v_GENERAL_RETURN,   
			@v_SMALL_LAST,   
			@v_SMALL_OPEN,   
			@v_SMALL_HIGH,   
			@v_SMALL_LOW,   
			@v_SMALL_RETURN,   
			@v_ITEQ_LAST,   
			@v_ITEQ_OPEN,   
			@v_ITEQ_HIGH,   
			@v_ITEQ_LOW,   
			@v_ITEQ_RETURN,   
			@v_ETF_LAST,   
			@v_ETF_OPEN,   
			@v_ETF_HIGH,   
			@v_ETF_LOW,   
			@v_ETF_RETURN,   
			@v_INAV_LAST,   
			@v_INAV_OPEN,   
			@v_INAV_HIGH,   
			@v_INAV_LOW,   
			@v_IEX_LAST,   
			@v_IEX_OPEN,   
			@v_IEX_HIGH,   
			@v_IEX_LOW,   
			@v_IEX_RETURN,   
			@v_INVERSE_LAST,   
			@v_INVERSE_OPEN,   
			@v_INVERSE_HIGH,   
			@v_INVERSE_LOW,   
			@v_INVERSE_RETURN,   
			@v_LEVERAGED_LAST,   
			@v_LEVERAGED_OPEN,   
			@v_LEVERAGED_HIGH,   
			@v_LEVERAGED_LOW,   
			@v_LEVERAGED_RETURN,   
			@v_CAPPED_LAST,   
			@v_CAPPED_OPEN,   
			@v_CAPPED_HIGH,   
			@v_CAPPED_LOW,   
			@v_CAPPED_RETURN   
		)   
   
END   
   
   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SetsValue]'
GO
CREATE TABLE [dbo].[SetsValue] 
( 
[SetsValueID] [int] NOT NULL IDENTITY(1, 1), 
[ValueInserted] [datetime2] NOT NULL CONSTRAINT [DF_SetsValue_ValueInserted] DEFAULT (getdate()), 
[SetsDate] [date] NOT NULL CONSTRAINT [DF_SetsValue_SetsDate] DEFAULT (getdate()), 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[TURNOVER] [numeric] (19, 6) NOT NULL, 
[VOLUME] [numeric] (19, 6) NOT NULL, 
[DEALS] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_SetsValue] on [dbo].[SetsValue]'
GO
ALTER TABLE [dbo].[SetsValue] ADD CONSTRAINT [PK_SetsValue] PRIMARY KEY CLUSTERED  ([SetsValueID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_SetsValue] on [dbo].[SetsValue]'
GO
CREATE NONCLUSTERED INDEX [IX_SetsValue] ON [dbo].[SetsValue] ([SetsValueID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AddSetsValue]'
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
   
   
   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT 
SET @Success = 1 
SET NOEXEC OFF 
IF (@Success = 1) PRINT 'The database update succeeded' 
ELSE BEGIN 
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION 
	PRINT 'The database update failed' 
END
GO
