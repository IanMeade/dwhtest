/* 
Run this script on: 
 
        T7-DDT-06.Reuters_ODS    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.Reuters_ODS 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 28/04/2017 15:52:50 
 
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
           @OLAST NUMERIC(8,3), 
           @OOPEN NUMERIC(8,3), 
           @OHIGH NUMERIC(15,3), 
           @OLOW NUMERIC(8,3), 
           @ORETURN NUMERIC(8,3), 
           @FLAST NUMERIC(8,3), 
           @FOPEN NUMERIC(8,3), 
           @FHIGH NUMERIC(15,3), 
           @FLOW NUMERIC(8,3), 
           @FRETURN NUMERIC(8,3), 
           @GLAST NUMERIC(8,3), 
           @GOPEN NUMERIC(8,3), 
           @GHIGH NUMERIC(15,3), 
           @GLOW NUMERIC(8,3), 
           @GRETURN NUMERIC(8,3), 
           @SLAST NUMERIC(8,3), 
           @SOPEN NUMERIC(8,3), 
           @SHIGH NUMERIC(15,3), 
           @SLOW NUMERIC(8,3), 
           @SRETURN NUMERIC(8,3), 
           @ILAST NUMERIC(8,3), 
           @IOPEN NUMERIC(8,3), 
           @IHIGH NUMERIC(15,3), 
           @ILOW NUMERIC(8,3), 
           @IRETURN NUMERIC(8,3), 
           @ELAST NUMERIC(8,3), 
           @EOPEN NUMERIC(8,3), 
           @EHIGH NUMERIC(15,3), 
           @ELOW NUMERIC(8,3), 
           @ERETURN NUMERIC(8,3), 
           @NLAST NUMERIC(8,3), 
           @NOPEN NUMERIC(8,3), 
           @NHIGH NUMERIC(15,3), 
           @NLOW NUMERIC(8,3), 
           @XLAST NUMERIC(8,3), 
           @XOPEN NUMERIC(8,3), 
           @XHIGH NUMERIC(15,3), 
           @XLOW NUMERIC(8,3), 
           @XRETURN NUMERIC(8,3), 
           @VLAST NUMERIC(8,3), 
           @VOPEN NUMERIC(8,3), 
           @VHIGH NUMERIC(15,3), 
           @VLOW NUMERIC(8,3), 
           @VRETURN NUMERIC(8,3), 
           @LLAST NUMERIC(8,3), 
           @LOPEN NUMERIC(8,3), 
           @LHIGH NUMERIC(15,3), 
           @LLOW NUMERIC(8,3), 
           @LRETURN NUMERIC(8,3), 
           @CLAST NUMERIC(8,3), 
           @COPEN NUMERIC(8,3), 
           @CHIGH NUMERIC(15,3), 
           @CLOW NUMERIC(8,3), 
           @CRETURN NUMERIC(8,3) 
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
			@OLAST, 
			@OOPEN, 
			@OHIGH, 
			@OLOW, 
			@ORETURN, 
			@FLAST, 
			@FOPEN, 
			@FHIGH, 
			@FLOW, 
			@FRETURN, 
			@GLAST, 
			@GOPEN, 
			@GHIGH, 
			@GLOW, 
			@GRETURN, 
			@SLAST, 
			@SOPEN, 
			@SHIGH, 
			@SLOW, 
			@SRETURN, 
			@ILAST, 
			@IOPEN, 
			@IHIGH, 
			@ILOW, 
			@IRETURN, 
			@ELAST, 
			@EOPEN, 
			@EHIGH, 
			@ELOW, 
			@ERETURN, 
			@NLAST, 
			@NOPEN, 
			@NHIGH, 
			@NLOW, 
			@XLAST, 
			@XOPEN, 
			@XHIGH, 
			@XLOW, 
			@XRETURN, 
			@VLAST, 
			@VOPEN, 
			@VHIGH, 
			@VLOW, 
			@VRETURN, 
			@LLAST, 
			@LOPEN, 
			@LHIGH, 
			@LLOW, 
			@LRETURN, 
			@CLAST, 
			@COPEN, 
			@CHIGH, 
			@CLOW, 
			@CRETURN 
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
