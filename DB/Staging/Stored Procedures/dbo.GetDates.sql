SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
   
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 13/1/2017   
-- Description:	Return dataset to populate DimDate -  levarges lower level routines 
-- =============================================   
CREATE PROCEDURE [dbo].[GetDates] 
AS   
BEGIN   
	-- SET NOCOUNT ON added to prevent extra result sets from   
	-- interfering with SELECT statements.   
	SET NOCOUNT ON;   
 
	DECLARE @StartYear INT   
	DECLARE @EndYear INT    
	DECLARE @StartYearBase INT   
	DECLARE @EndYearBase INT    
	DECLARE @TradingStartTime TIME   
	DECLARE @TradingEndTime TIME   
   
	/* GET DATES FROM CONTROL TABLE */   
	SELECT   
		@StartYear = StartYear,    
		@EndYear = EndYear,   
		@TradingStartTime = NormalTradingStartTime,   
		@TradingEndTime = NormalTradingEndTime   
	FROM   
		[dbo].[MdmDateControl]   
 
	/* Add extra days to avoid NULLs in Previous Year / Day fields  */ 
	SELECT   
		@StartYearBase = @StartYear - 1, 
		@EndYearBase = @EndYear + 1 
 
	/* BUILD BASE TABLE */ 
	EXEC dbo.GetDates_Build @StartYearBase, @EndYearBase, @TradingStartTime, @TradingEndTime 
 
 
	/* Add extra fields and return results */ 
 
	;WITH YW AS ( 
			SELECT 
				DateID, 
				(YEAR*100) + DATEPART(WW,DAY) AS YearWeekNo, 
				WorkingDayYN 
			FROM 
				dbo.BuildDwhDimDate 
		), 
		WS AS ( 
			SELECT 
				YearWeekNo, 
				MIN(DateID) AS WeekStart, 
				MAX(DateID) AS WeekEnd 
			FROM 
				YW 
			WHERE 
				WorkingDayYN = 'Y' 
			GROUP BY 
				YearWeekNo 
		), 
		MS AS ( 
					SELECT 
						ROW_NUMBER() OVER (	ORDER BY Year,MonthNo ) AS RN, 
						Year, 
						MonthNo, 
						MIN(DateID) AS MonthStart, 
						MAX(DateID) AS MonthEnd 
					FROM 
						dbo.BuildDwhDimDate 
					WHERE 
						DateID <> -1 
					AND 
						WorkingDayYN = 'Y' 
					GROUP BY 
						YEAR, 
						MonthNo 
			), 
		QS AS ( 
			SELECT 
				ROW_NUMBER() OVER (	ORDER BY YearQuarterNo ) AS RN, 
				YearQuarterNo, 
				MIN(DateID) AS QuarterStart, 
				MAX(DateID) AS QuarterEnd 
			FROM 
				dbo.BuildDwhDimDate 
			WHERE 
				DateID <> -1 
			AND 
				WorkingDayYN = 'Y' 
			GROUP BY 
				YearQuarterNo 
		), 
		YS AS ( 
			SELECT 
				ROW_NUMBER() OVER (	ORDER BY Year ) AS RN, 
				Year, 
				MIN(DateID) AS YearStart, 
				MAX(DateID) AS YearEnd 
			FROM 
				dbo.BuildDwhDimDate 
			WHERE 
				DateID <> -1 
			AND 
				WorkingDayYN = 'Y' 
			GROUP BY 
				Year 
		), 
		CD AS ( 
			SELECT 
				MAX(DateID) AS CurrentDate 
			FROM 
				dbo.BuildDwhDimDate 
			WHERE 
				Day <= GETDATE() 
			AND 
				WorkingDayYN = 'Y' 
		) 
	SELECT 
		D.DateID, 
		(	SELECT  
				MAX(DateID) 
			FROM 
				dbo.BuildDwhDimDate D2 
			WHERE 
				D2.DateID < D.DateID 
			AND
				D2.WorkingDayYN = 'Y'
		) AS PreviousDateID, 
		D.DateText,  
		D.Day,  
		D.DayText,  
		D.WorkingDayYN,  
		IIF(CD.CurrentDate IS NULL,'N','Y') AS CurrentDateYN, 
		D.TradingStartTime,  
		D.TradingEndTime, 
		D.Year,  
		YW.YearWeekNo, 
		(D.YEAR*100) + D.MonthNo AS YearMonthNo, 
		CAST(STR(D.YEAR,4) + ' ' + UPPER(LEFT(DATENAME(M,D.DAY),3)) AS CHAR(8)) AS YearMonthText, 
		YS.YearStart, 
		YS.YearEnd, 
		YsPrev.YearEnd AS LastYearEnd, 
		D.YearToDateYN,  
		D.QuarterNo,  
		D.QuarterText,  
		D.YearQuarterNo,  
		D.YearQuarterText,  
		QS.QuarterStart, 
		QS.QuarterEnd, 
		QsPrev.QuarterEnd AS LastQuarterEnd, 
		MS.MonthStart, 
		MS.MonthEnd, 
		MsPrev.MonthEnd AS LastMonthEnd, 
		D.MonthNo,  
		D.MonthName,  
		D.MonthDayNo,  
		D.MonthToDateYN,  
		/* CAN BE NULL IF THE FIRST OR LAST WEEK OF THE YEAR IS VERY SHORT => USE TODAY */ 
		ISNULL(WS.WeekStart,D.DateID) AS WeekStart, 
		ISNULL(WS.WeekEnd,D.DateID) AS WeekEnd, 
		SUM(IIF(D.WorkingDayYN='Y',1,0)) OVER( PARTITION BY D.Year ORDER BY D.DateID ROWS UNBOUNDED PRECEDING) AS DaysYTD, 
		SUM(IIF(D.WorkingDayYN='Y',1,0)) OVER( PARTITION BY D.Year, D.MonthNo ORDER BY D.DateID ROWS UNBOUNDED PRECEDING) AS DaysMTD, 
		SUM(IIF(D.WorkingDayYN='Y',1,0)) OVER( PARTITION BY D.YearQuarterNo ORDER BY D.DateID ROWS UNBOUNDED PRECEDING) AS DaysQTD 
	FROM 
			dbo.BuildDwhDimDate D 
		LEFT OUTER JOIN 
			YW 
		ON D.DateID = YW.DateID 
		LEFT OUTER JOIN 
			WS 
		ON YW.YearWeekNo = WS.YearWeekNo 
		LEFT OUTER JOIN 
			MS 
		ON D.Year = MS.Year 
		AND D.MonthNo = MS.MonthNo 
		LEFT OUTER JOIN 
			MS MsPrev 
		ON MS.RN = MsPrev.RN+1 
		LEFT OUTER JOIN 
			QS 
		ON 
			D.YearQuarterNo = QS.YearQuarterNo 
		LEFT OUTER JOIN 
			QS QsPrev 
		ON QS.RN = QsPrev.RN+1 
		LEFT OUTER JOIN 
			YS 
		ON D.Year = YS.Year 
		LEFT OUTER JOIN 
			YS YsPrev 
		ON YS.RN = YsPrev.RN+1 
		LEFT OUTER JOIN 
			CD 
		ON D.DateID = CD.CurrentDate 
	WHERE 
		/* EXTRA DATES ARE INCLDUED IN BASE TBALE TO AVOID NULLS */ 
		D.Year BETWEEN @StartYear AND @EndYear  
	OR 
		D.DateID = 10101		   
END   
 
GO
