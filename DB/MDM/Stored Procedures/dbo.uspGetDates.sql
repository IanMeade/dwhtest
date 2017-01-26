SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[uspGetDates]
    (
      @StartDate CHAR(4) ,
      @EndDate CHAR(4)
    )
AS
    BEGIN
        SET @StartDate = CASE ISDATE(@StartDate)
                           WHEN 1 THEN @StartDate
                           ELSE 
--handle no a valid year
                                '1990'
                         END;

        SET @EndDate = CASE ISDATE(@EndDate)
                         WHEN 1 THEN @EndDate
                         ELSE ---handle not a valid year
                              '2060'
                       END;

        WITH    dates
                  AS ( SELECT   CONVERT(DATE, @StartDate) AS [date] --start
                       UNION ALL
                       SELECT   DATEADD(DAY, 1, [date])
                       FROM     [dates]
                       WHERE    [date] < ( @EndDate + '-12-31' ) --end
                     )
            SELECT  CAST(CONVERT(VARCHAR, d.[date], 112) AS INT) AS DateID ,
                    CONVERT(VARCHAR(10), d.[date], 103) AS DateText ,
                    d.[date] AS [Day] ,
                    CAST(DATENAME(dw, d.[date]) AS CHAR(20)) AS DayText ,
                    CASE WHEN DATENAME(dw, d.[date]) IN ( 'Saturday', 'Sunday' )
                              OR d.[date] IN ( SELECT   SpecialDate
                                               FROM     [dbo].[SpecialDays]
                                               WHERE    [HolidayYN] = 'Y' )
                         THEN 'N'
                         ELSE 'Y'
                    END AS WorkingDayYN ,
                    CASE WHEN DATENAME(dw, d.[date]) IN ( 'Saturday', 'Sunday' )
                              OR d.[date] IN (
                              SELECT    SpecialDate
                              FROM      [dbo].[SpecialDays]
                              WHERE     [HolidayYN] = 'Y'
                                        OR ( [HolidayYN] = 'N'
                                             AND [TradingEndTime] NOT IN (
                                             '00:00' )
                                           ) ) THEN 'Y'
                         ELSE 'N'
                    END AS SpecialDayYN ,
                    CAST(DAY(d.[date]) AS TINYINT) AS MonthDayNo ,
                    CAST(YEAR(d.[date]) AS SMALLINT) AS [Year] ,
                    CAST(MONTH(d.[date]) AS TINYINT) AS MonthNo ,
                    CAST(DATENAME(MONTH, d.[date]) AS CHAR(20)) AS MonthName ,
                    CAST(DATENAME(QUARTER, d.[date]) AS TINYINT) AS QuarterNo ,
                    'Q' + CAST(DATENAME(QUARTER, d.[date]) AS CHAR(20)) AS QuarterText ,
                    CAST(DATENAME(YEAR, d.[date]) + DATENAME(QUARTER, d.[date]) AS INT) AS YearQuarterNo ,
                    CAST(DATENAME(YEAR, d.[date]) + ' Q'
                    + CAST(DATENAME(QUARTER, d.[date]) AS CHAR) AS CHAR(30)) AS YearQuarterText ,
                    CASE WHEN YEAR(d.[date]) = YEAR(GETDATE())
                              AND MONTH(d.[date]) = MONTH(GETDATE()) THEN 'Y'
                         ELSE 'N'
                    END AS MonthToDateYN ,
                    CASE WHEN YEAR(d.[date]) = YEAR(GETDATE()) THEN 'Y'
                         ELSE 'N'
                    END AS YearToDateYN ,
                    CASE WHEN DATENAME(dw, d.[date]) IN ( 'Saturday', 'Sunday' )
                         THEN '00:00'
                         WHEN d.[date] IN ( SELECT  SpecialDate
                                            FROM    [dbo].[SpecialDays] )
                         THEN ( SELECT  [TradingStartTime]
                                FROM    [dbo].[SpecialDays]
                                WHERE   d.[date] = SpecialDate
                              )
                         ELSE ( SELECT  [NormalTradingStartTime]
                                FROM    [dbo].[DateControl]
                              )
                    END AS TradingStartTime ,
                    CASE WHEN DATENAME(dw, d.[date]) IN ( 'Saturday', 'Sunday' )
                         THEN '00:00'
                         WHEN d.[date] IN ( SELECT  SpecialDate
                                            FROM    [dbo].[SpecialDays] )
                         THEN ( SELECT  [TradingEndTime]
                                FROM    [dbo].[SpecialDays]
                                WHERE   d.[date] = SpecialDate
                              )
                         ELSE ( SELECT  [NormalTradingEndTime]
                                FROM    [dbo].[DateControl]
                              )
                    END AS TradingEndTime ,
                    CASE WHEN CAST(CONVERT(VARCHAR, d.[date], 112) AS INT) > = ( SELECT
                                                              ISTStartDate
                                                              FROM
                                                              IrishStandardTime
                                                              WHERE
                                                              ISTYear = CAST(YEAR(d.[date]) AS SMALLINT)
                                                              )
                              AND CAST(CONVERT(VARCHAR, d.[date], 112) AS INT) <= ( SELECT
                                                              ISTEndDate
                                                              FROM
                                                              IrishStandardTime
                                                              WHERE
                                                              ISTYear = CAST(YEAR(d.[date]) AS SMALLINT)
                                                              ) THEN 'Y'
                         ELSE 'N'
                    END AS UTCOffSetYN ,
                    CASE WHEN CAST(CONVERT(VARCHAR, d.[date], 112) AS INT) = ( SELECT
                                                              ISTStartDate
                                                              FROM
                                                              IrishStandardTime
                                                              WHERE
                                                              ISTYear = CAST(YEAR(d.[date]) AS SMALLINT)
                                                              ) THEN 'Y'
                         ELSE 'N'
                    END AS UTCOffSetBeginYN ,
                    CASE WHEN CAST(CONVERT(VARCHAR, d.[date], 112) AS INT) = ( SELECT
                                                              ISTEndDate
                                                              FROM
                                                              IrishStandardTime
                                                              WHERE
                                                              ISTYear = CAST(YEAR(d.[date]) AS SMALLINT)
                                                              ) THEN 'Y'
                         ELSE 'N'
                    END AS UTCOffSetEndYN ,
                    CASE WHEN CAST(CONVERT(VARCHAR, d.[date], 112) AS INT) > = ( SELECT
                                                              ISTStartDate
                                                              FROM
                                                              IrishStandardTime
                                                              WHERE
                                                              ISTYear = CAST(YEAR(d.[date]) AS SMALLINT)
                                                              )
                              AND CAST(CONVERT(VARCHAR, d.[date], 112) AS INT) <= ( SELECT
                                                              ISTEndDate
                                                              FROM
                                                              IrishStandardTime
                                                              WHERE
                                                              ISTYear = CAST(YEAR(d.[date]) AS SMALLINT)
                                                              )
                         THEN ( SELECT  ISTStartTime
                                FROM    IrishStandardTime
                                WHERE   ISTYear = CAST(YEAR(d.[date]) AS SMALLINT)
                              )
                    END AS UTCStartTime ,
                    CASE WHEN CAST(CONVERT(VARCHAR, d.[date], 112) AS INT) > = ( SELECT
                                                              ISTStartDate
                                                              FROM
                                                              IrishStandardTime
                                                              WHERE
                                                              ISTYear = CAST(YEAR(d.[date]) AS SMALLINT)
                                                              )
                              AND CAST(CONVERT(VARCHAR, d.[date], 112) AS INT) <= ( SELECT
                                                              ISTEndDate
                                                              FROM
                                                              IrishStandardTime
                                                              WHERE
                                                              ISTYear = CAST(YEAR(d.[date]) AS SMALLINT)
                                                              )
                         THEN ( SELECT  ISTEndTime
                                FROM    IrishStandardTime
                                WHERE   ISTYear = CAST(YEAR(d.[date]) AS SMALLINT)
                              )
                    END AS UTCEndTime
            FROM    dates d
            WHERE   d.[date] BETWEEN @StartDate AND @EndDate
        OPTION  ( MAXRECURSION 0 );
    END;
GO
