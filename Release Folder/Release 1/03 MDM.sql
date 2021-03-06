USE MDM
GO

/* 
Run this script on a database with the schema represented by: 
 
        MDM    -  This database will be modified. The scripts folder will not be modified. 
 
to synchronize it with a database with the schema represented by: 
 
        T7-DDT-01.MDM 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 24/02/2017 12:32:46 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Broker]'
GO
CREATE TABLE [dbo].[Broker] 
( 
[BrokerCode] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL, 
[BrokerName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[BondTurnoverYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[StatusValidYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketMakerYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[DailyOfficalListYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[CrestCode] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[MemberPackYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[EBCFee] [numeric] (19, 6) NOT NULL, 
[Location] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[MemberType] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Broker] on [dbo].[Broker]'
GO
ALTER TABLE [dbo].[Broker] ADD CONSTRAINT [PK_Broker] PRIMARY KEY CLUSTERED  ([BrokerCode])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Trader]'
GO
CREATE TABLE [dbo].[Trader] 
( 
[TraderCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[BrokerCode] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL, 
[TraderType] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Trader] on [dbo].[Trader]'
GO
ALTER TABLE [dbo].[Trader] ADD CONSTRAINT [PK_Trader] PRIMARY KEY CLUSTERED  ([TraderCode], [BrokerCode])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DateControl]'
GO
CREATE TABLE [dbo].[DateControl] 
( 
[StartYear] [smallint] NOT NULL, 
[EndYear] [smallint] NOT NULL, 
[NormalTradingStartTime] [time] NOT NULL, 
[NormalTradingEndTime] [time] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DateControl] on [dbo].[DateControl]'
GO
ALTER TABLE [dbo].[DateControl] ADD CONSTRAINT [PK_DateControl] PRIMARY KEY CLUSTERED  ([StartYear])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SpecialDays]'
GO
CREATE TABLE [dbo].[SpecialDays] 
( 
[SpecialDate] [date] NOT NULL, 
[HolidayYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradingStartTime] [time] NOT NULL, 
[TradingEndTime] [time] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_SpecialDays] on [dbo].[SpecialDays]'
GO
ALTER TABLE [dbo].[SpecialDays] ADD CONSTRAINT [PK_SpecialDays] PRIMARY KEY CLUSTERED  ([SpecialDate])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[uspGetDates]'
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
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AuctionFlag]'
GO
CREATE TABLE [dbo].[AuctionFlag] 
( 
[AuctionFlagCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[AuctionFlagName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[DefaultValueYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_AuctionFlag] on [dbo].[AuctionFlag]'
GO
ALTER TABLE [dbo].[AuctionFlag] ADD CONSTRAINT [PK_AuctionFlag] PRIMARY KEY CLUSTERED  ([AuctionFlagCode])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Currency]'
GO
CREATE TABLE [dbo].[Currency] 
( 
[CurrencySymbol] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[CurrencyISOCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[CurrencyName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[CurrencyCountry] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Currency] on [dbo].[Currency]'
GO
ALTER TABLE [dbo].[Currency] ADD CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED  ([CurrencyISOCode])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[EquityFeeBand]'
GO
CREATE TABLE [dbo].[EquityFeeBand] 
( 
[FeeBandName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[Min] [int] NOT NULL, 
[Max] [int] NOT NULL, 
[Fee] [numeric] (9, 6) NOT NULL, 
[FeeType] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_EquityFeeBand] on [dbo].[EquityFeeBand]'
GO
ALTER TABLE [dbo].[EquityFeeBand] ADD CONSTRAINT [PK_EquityFeeBand] PRIMARY KEY CLUSTERED  ([FeeBandName])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Index]'
GO
CREATE TABLE [dbo].[Index] 
( 
[IndexCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[IndexName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[ISIN] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL, 
[SEDOL] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[ReturnISIN] [varchar] (7) COLLATE Latin1_General_CI_AS NOT NULL, 
[ReturnSEDOL] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Index] on [dbo].[Index]'
GO
ALTER TABLE [dbo].[Index] ADD CONSTRAINT [PK_Index] PRIMARY KEY CLUSTERED  ([IndexCode])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Market]'
GO
CREATE TABLE [dbo].[Market] 
( 
[MarketCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[MarketName] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[XtCode] [varchar] (20) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Market_1] on [dbo].[Market]'
GO
ALTER TABLE [dbo].[Market] ADD CONSTRAINT [PK_Market_1] PRIMARY KEY CLUSTERED  ([MarketCode])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[PrincipalAgent]'
GO
CREATE TABLE [dbo].[PrincipalAgent] 
( 
[PrincipalAgentCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[PrincipalAgentName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_PrincipalAgent] on [dbo].[PrincipalAgent]'
GO
ALTER TABLE [dbo].[PrincipalAgent] ADD CONSTRAINT [PK_PrincipalAgent] PRIMARY KEY CLUSTERED  ([PrincipalAgentCode])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Status]'
GO
CREATE TABLE [dbo].[Status] 
( 
[StatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__Status__05E7698BA7453788] on [dbo].[Status]'
GO
ALTER TABLE [dbo].[Status] ADD CONSTRAINT [PK__Status__05E7698BA7453788] PRIMARY KEY CLUSTERED  ([StatusName])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TradeFlag]'
GO
CREATE TABLE [dbo].[TradeFlag] 
( 
[TradeFlagCode] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeFlagName] [char] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[DefaultValue] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_TradeFlag] on [dbo].[TradeFlag]'
GO
ALTER TABLE [dbo].[TradeFlag] ADD CONSTRAINT [PK_TradeFlag] PRIMARY KEY CLUSTERED  ([TradeFlagCode])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TradeModificationType]'
GO
CREATE TABLE [dbo].[TradeModificationType] 
( 
[TradeModificationTypeCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradingSysModificationTypeCode] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeModificationTypeName] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_TradeModificationType] on [dbo].[TradeModificationType]'
GO
ALTER TABLE [dbo].[TradeModificationType] ADD CONSTRAINT [PK_TradeModificationType] PRIMARY KEY CLUSTERED  ([TradeModificationTypeCode])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TradeOrderType]'
GO
CREATE TABLE [dbo].[TradeOrderType] 
( 
[TradeOrderTypeCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeOrderRestrictionCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeType] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeTypeCategory] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[DefaultValueYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_TradeType] on [dbo].[TradeOrderType]'
GO
ALTER TABLE [dbo].[TradeOrderType] ADD CONSTRAINT [PK_TradeType] PRIMARY KEY CLUSTERED  ([TradeOrderTypeCode], [TradeOrderRestrictionCode])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TradeSide]'
GO
CREATE TABLE [dbo].[TradeSide] 
( 
[TradeSideCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeSideName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__TradeSid__9D52F5B014D8C226] on [dbo].[TradeSide]'
GO
ALTER TABLE [dbo].[TradeSide] ADD CONSTRAINT [PK__TradeSid__9D52F5B014D8C226] PRIMARY KEY CLUSTERED  ([TradeSideCode])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[Trader]'
GO
ALTER TABLE [dbo].[Trader] ADD CONSTRAINT [FK_Trader_Broker] FOREIGN KEY ([BrokerCode]) REFERENCES [dbo].[Broker] ([BrokerCode]) 
GO
ALTER TABLE [dbo].[Trader] ADD CONSTRAINT [FK_Trader_Trader] FOREIGN KEY ([TraderCode], [BrokerCode]) REFERENCES [dbo].[Trader] ([TraderCode], [BrokerCode]) 
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
