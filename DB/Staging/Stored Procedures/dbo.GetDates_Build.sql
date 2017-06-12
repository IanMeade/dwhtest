SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

  
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 13/1/2017  
-- Description:	Builds initial date table - extra fields will be added by calling routine
-- =============================================  
CREATE PROCEDURE [dbo].[GetDates_Build]  
	@StartYear INT,
	@EndYear INT,
	@TradingStartTime TIME,
	@TradingEndTime TIME
AS  
BEGIN  
	-- SET NOCOUNT ON added to prevent extra result sets from  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  

	/* USING A STAGINT BALE TO BUILD DATES */
	TRUNCATE TABLE dbo.BuildDwhDimDate
    
	DECLARE @StartDate AS DATE  
	SET @StartDate = CAST(@StartYear AS CHAR(4)) + '0101';  
  
  
	WITH dates AS (  
		SELECT  
			@StartDate AS [date]   
		UNION ALL  
		SELECT  
			dateadd(day, 1, [date])  
		FROM  
			[dates]  
		WHERE  
			YEAR([date]) <  @EndYear  
		),
		datesPlus AS (
			SELECT
				[date]   
			FROM
				dates
			UNION
			SELECT
				'00010101'
		)

	INSERT INTO 
			BuildDwhDimDate
		SELECT   
			CAST(CONVERT(VARCHAR, d.[date], 112) AS INT) AS DateID,  
			LEFT(CONVERT(VARCHAR, d.[date], 103),20) AS DateText,  
			d.[date] as [Day],  
			CASE   
				WHEN SD.HolidayYN IS NOT NULL AND SD.HolidayYN = 'Y' THEN 'N' 
				WHEN SD.HolidayYN IS NOT NULL AND SD.HolidayYN = 'N' THEN 'Y' 
				WHEN  DATENAME(DW,d.[date]) in ('Saturday','Sunday') THEN 'N'  
				ELSE 'Y'  
			END AS WorkingDayYN,  
			CAST(YEAR(d.[date]) AS SMALLINT) AS [Year] ,  
			CAST(MONTH(d.[date]) AS SMALLINT) AS MonthNo,  
			CAST(DATENAME(MONTH,d.[date]) AS CHAR(20)) AS MonthName,  
			CAST(DATENAME(QUARTER,d.[date]) AS SMALLINT) AS QuarterNo,  
			CAST('Q' + DATENAME(QUARTER,d.[date]) AS CHAR) AS QuarterText,  
			(YEAR(d.[date]) * 10) + DATEPART(QUARTER,d.[date]) AS YearQuarterNo,  
			CAST(DATENAME(YEAR,d.[date]) + ' Q' + DATENAME(QUARTER,d.[date]) AS CHAR) AS YearQuarterText,  
			CAST(DAY(d.[date]) AS SMALLINT) AS MonthDayNo,  
			CAST(DATENAME(DW,d.[date]) AS CHAR(20)) AS DayText,  
  
			CASE  
				WHEN   
						YEAR(d.[date])=YEAR(GETDATE())   
					AND   
						MONTH(d.[date])=MONTH(GETDATE())   
					AND DAY(d.[date])<=DAY(GETDATE())  
				THEN 'Y'  
				ELSE 'N'  
			END AS MonthToDateYN,  
			CASE  
				WHEN YEAR(d.[date])=YEAR(GETDATE()) AND   
					(	  
							( MONTH(d.[date])<MONTH(GETDATE()) )  
						OR  
							( MONTH(d.[date])=MONTH(GETDATE()) AND DAY(d.[date])<=DAY(GETDATE()) )  
					)  
				THEN 'Y'  
				ELSE 'N'  
			END AS YearToDateYN,  
			ISNULL(SD.TradingStartTime,	@TradingStartTime) AS TradingStartTime,  
			ISNULL(SD.TradingEndTime, @TradingEndTime) AS TradingEndTime  
		FROM   
				datesPlus d  
			LEFT OUTER JOIN  
				dbo.MdmSpecialDays SD  
			ON D.date = SD.SpecialDate  
		WHERE  
			YEAR(d.[date]) BETWEEN @StartYear AND @EndYear  
		OR
			d.date = '00010101'
		UNION 

		SELECT
			DateID, 
			DateText, 
			Day, 
			WorkingDayYN, 
			Year, 
			MonthNo, 
			MonthName, 
			QuarterNo, 
			QuarterText, 
			YearQuarterNo, 
			YearQuarterText, 
			MonthDayNo, 
			DayText, 
			MonthToDateYN, 
			YearToDateYN, 
			TradingStartTime, 
			TradingEndTime
		FROM
			dbo.MdmExtraDates
		OPTION (MAXRECURSION 0);  
  
  
  
  
  
  
END  

GO
