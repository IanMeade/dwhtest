/* 
Run this script on: 
 
        T7-DDT-06.ProcessControl    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.ProcessControl 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 28/04/2017 15:45:11 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [ProcessControl]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ProcessStatus]'
GO
CREATE TABLE [dbo].[ProcessStatus] 
( 
[ProcessStatusID] [int] NOT NULL IDENTITY(1, 1), 
[BatchID] [int] NOT NULL, 
[Message] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL, 
[MessageDateTime] [datetime2] NOT NULL CONSTRAINT [DF_ProcessStatus_MessageDateTime] DEFAULT (getdate()) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ProcessStatus] on [dbo].[ProcessStatus]'
GO
ALTER TABLE [dbo].[ProcessStatus] ADD CONSTRAINT [PK_ProcessStatus] PRIMARY KEY CLUSTERED  ([ProcessStatusID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[InsertProcessStatus]'
GO
 
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 1/3/2017  
-- Description:	Add an entry to the ProcessStatus table 
-- =============================================  
CREATE PROCEDURE [dbo].[InsertProcessStatus] 
	@BatchID INT, 
	@Message VARCHAR(MAX) 
AS  
BEGIN  
	SET NOCOUNT ON;  
  
	INSERT INTO dbo.ProcessStatus 
		( 
			BatchID,  
			Message 
		) 
		VALUES 
		( 
			@BatchID, 
			@Message 
		) 
 
END  
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidationUnitTest]'
GO
CREATE TABLE [dbo].[ValidationUnitTest] 
( 
[ValidationUnitTestID] [int] NOT NULL IDENTITY(1, 1), 
[ValidationTestSuiteID] [int] NOT NULL, 
[ValidationUnitTestName] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[ValidationUnitTestTag] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[RunOrder] [int] NOT NULL, 
[TestDatabase] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[TestStoredProcedure] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[Enabled] [bit] NOT NULL, 
[ErrorCondition] [bit] NOT NULL, 
[WarningCondition] [bit] NOT NULL, 
[SilentChanges] [bit] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ValidationTest] on [dbo].[ValidationUnitTest]'
GO
ALTER TABLE [dbo].[ValidationUnitTest] ADD CONSTRAINT [PK_ValidationTest] PRIMARY KEY CLUSTERED  ([ValidationUnitTestID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_ValidationUnitTest] on [dbo].[ValidationUnitTest]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ValidationUnitTest] ON [dbo].[ValidationUnitTest] ([ValidationUnitTestTag])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidationTestSuite]'
GO
CREATE TABLE [dbo].[ValidationTestSuite] 
( 
[ValidationTestSuiteID] [int] NOT NULL IDENTITY(1, 1), 
[ValidationTestSuiteName] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[ValidationTestSuiteTag] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[Enabled] [bit] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ValidationControl] on [dbo].[ValidationTestSuite]'
GO
ALTER TABLE [dbo].[ValidationTestSuite] ADD CONSTRAINT [PK_ValidationControl] PRIMARY KEY CLUSTERED  ([ValidationTestSuiteID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetUnitTestList]'
GO
 
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 7/4/2017  
-- Description:	Gte list of unti tests to run  
-- =============================================  
CREATE PROCEDURE [dbo].[GetUnitTestList]  
	@ValidationTestSuiteTag VARCHAR(100)  
AS  
BEGIN  
	SET NOCOUNT ON;  
  
	SELECT  
		TS.ValidationTestSuiteID,  
		UT.ValidationUnitTestID,   
		UT.ValidationUnitTestName,   
		UT.ValidationUnitTestTag,   
		UT.TestDatabase,   
		UT.TestStoredProcedure, 	  
		UT.ErrorCondition,   
		UT.WarningCondition,   
		UT.SilentChanges  
	FROM  
			dbo.ValidationTestSuite TS  
		INNER JOIN  
			dbo.ValidationUnitTest UT  
		ON TS.ValidationTestSuiteID = UT.ValidationTestSuiteID  
	WHERE  
		TS.ValidationTestSuiteTag = @ValidationTestSuiteTag   
	AND  
		TS.Enabled = 1  
	AND  
		UT.Enabled = 1  
	ORDER BY  
		RunOrder  
END  
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Switches]'
GO
CREATE TABLE [dbo].[Switches] 
( 
[SwitchKey] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[SwitchValue] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Switches] on [dbo].[Switches]'
GO
ALTER TABLE [dbo].[Switches] ADD CONSTRAINT [PK_Switches] PRIMARY KEY CLUSTERED  ([SwitchKey])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetNextDateTime]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 18/4/2017 
-- Description:	Determine next time the choosen function can run - based on configured delay time 
-- ============================================= 
CREATE FUNCTION [dbo].[GetNextDateTime] 
( 
	@TaskControlTag VARCHAR(50) 
) 
RETURNS DATETIME 
AS 
BEGIN 
	DECLARE @DELAY_SECONDS INT 
	DECLARE @NEXT_RUN AS DATETIME 
 
	SELECT 
		@DELAY_SECONDS = CAST(SwitchValue AS INT) 
	FROM 
		dbo.Switches  
	WHERE 
		SwitchKey = @TaskControlTag 
 
	SELECT 
		@NEXT_RUN = CAST(DATEADD(SECOND, @DELAY_SECONDS, GETDATE()) AS TIME) 
 
	RETURN @NEXT_RUN  
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DelayForControlledPollingAction]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 19/4/2017 
-- Description:	Wrapper for WAITFOR delay - used by near real time package 
-- ============================================= 
CREATE PROCEDURE [dbo].[DelayForControlledPollingAction] 
	@ACTION_TAG VARCHAR(100) 
AS 
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from 
	-- interfering with SELECT statements. 
	SET NOCOUNT ON; 
 
	/* TEST DELAY */ 
 
	DECLARE @NEXT_RUN AS DATETIME 
 
	SELECT 
		GETDATE() 
 
	SELECT 
		@NEXT_RUN = dbo.GetNextDateTime(@ACTION_TAG )  
 
	WAITFOR 
		TIME @NEXT_RUN 
 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TaskControl]'
GO
CREATE TABLE [dbo].[TaskControl] 
( 
[TaskControlID] [smallint] NOT NULL IDENTITY(1, 1), 
[TaskControlName] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[TaskControlTag] [char] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[TaskControlEnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[TaskControlRuleSchedule] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_TaskControl] on [dbo].[TaskControl]'
GO
ALTER TABLE [dbo].[TaskControl] ADD CONSTRAINT [PK_TaskControl] PRIMARY KEY CLUSTERED  ([TaskControlID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[TaskControl]'
GO
ALTER TABLE [dbo].[TaskControl] ADD CONSTRAINT [IX_TaskControl] UNIQUE NONCLUSTERED  ([TaskControlID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[CheckScheduleTag]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 17/1/2017  
-- Description:	Checks if the passed in Scheduletag can be run now  
--				WARNING --- SCALAR FUNCTIONS ARE NOT SUITBALE FOR LARGE NUMBERS OF ROWS - USE ONLY FOPR SMALL RESULT SETS  
-- =============================================  
CREATE FUNCTION [dbo].[CheckScheduleTag]   
(  
	@ScheduleTag VARCHAR(100)  
)  
RETURNS BIT  
AS  
BEGIN  
	-- Declare the return variable here  
	DECLARE @YesWeCan BIT = 0  
  
	DECLARE @TestDate DATETIME = GETDATE()  
	--DECLARE @ScheduleTag VARCHAR(100)  
	DECLARE @TestTime CHAR(5) = CONVERT(CHAR(5), @TestDate , 114 )  
  
	/* SAMPLE SCHEDULE TAGS */  
	/*  
		SET @ScheduleTag = 'ALWAYS'  
		SET @ScheduleTag = 'DAILY:[09:00=17:00]'  
		SET @ScheduleTag = 'DAILY:[21:00=22:00]'  
		SET @ScheduleTag = 'MONDAY:TUESDAY:THURSDAY'  
		SET @ScheduleTag = 'SATURDAY:SUNDAY'  
	*/  
  
	SELECT  
		@YesWeCan = ISNULL(MAX(YesWeCan), @YesWeCan )   
	FROM  
		(  
			/* ALWAYS RUN */  
			SELECT  
				1 AS YesWeCan  
			WHERE  
				@ScheduleTag = 'ALWAYS'  
			UNION ALL  
			/* RUN DAILY BETWEEN SPECIFIED TIMES */  
			SELECT  
				1 AS YesWeCan  
			WHERE  
				LEFT(@ScheduleTag,5) = 'DAILY'   
			AND  
				@TestTime BETWEEN 	SUBSTRING(@ScheduleTag,8,5) AND SUBSTRING(@ScheduleTag,14,5)  
			UNION ALL  
			/* NAMED DAY OF WEEK - NO TIME SPECIFIED*/  
			SELECT  
				1 AS YesWeCan  
			WHERE  
				CHARINDEX(UPPER(DATENAME(DW,@TestDate)),UPPER(@ScheduleTag)) <> 0  
		) AS YesWeCan  
  
  
	-- Return the result of the function  
	RETURN @YesWeCan  
  
END  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[CheckTaskControl]'
GO
  
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 17/1/2017  
-- Description:	Checks if the passed in TaskControlTag can be run now  
--				WARNING --- SCALAR FUNCTIONS ARE NOT SUITBALE FOR LARGE NUMBERS OF ROWS - USE ONLY FOPR SMALL RESULT SETS  
-- =============================================  
CREATE FUNCTION [dbo].[CheckTaskControl]   
(  
	@TaskControlTag VARCHAR(100)  
)  
RETURNS BIT  
AS  
BEGIN  
	-- Declare the return variable here  
	DECLARE @YesWeCan BIT = 0  
  
	SELECT  
		@YesWeCan = dbo.CheckScheduleTag(TaskControlRuleSchedule)  
	FROM  
		[dbo].[TaskControl]  
	WHERE  
		TaskControlTag = @TaskControlTag  
	AND  
		TaskControlEnabledYN = 'Y'  
  
  
	-- Return the result of the function  
	RETURN @YesWeCan  
  
END  
  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[FileControlT7]'
GO
CREATE TABLE [dbo].[FileControlT7] 
( 
[FileLetter] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL, 
[ExpectedStartTime] [time] NULL, 
[ExpectedFinishTime] [time] NULL, 
[ProcessFileYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ContainsEndOfDayDetailsYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[ReprocessDelayMinutes] [smallint] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FileControlT7] on [dbo].[FileControlT7]'
GO
ALTER TABLE [dbo].[FileControlT7] ADD CONSTRAINT [PK_FileControlT7] PRIMARY KEY CLUSTERED  ([FileLetter])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[FileControl]'
GO
CREATE TABLE [dbo].[FileControl] 
( 
[FileControlID] [int] NOT NULL IDENTITY(1, 1), 
[ODS] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[EnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[FileTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileNameMask] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[FilePrefix] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[SourceFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProcessFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[ArchiveFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[RejectFolder] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FileControl] on [dbo].[FileControl]'
GO
ALTER TABLE [dbo].[FileControl] ADD CONSTRAINT [PK_FileControl] PRIMARY KEY CLUSTERED  ([FileControlID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_FileControl] on [dbo].[FileControl]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_FileControl] ON [dbo].[FileControl] ([FileTag])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetExpectedFileList]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 8/3/2017  
-- Description:	get list of espected lists and hopw long to wait for them  
-- =============================================  
CREATE FUNCTION [dbo].[GetExpectedFileList]  
(  
)  
RETURNS   
	@ExpectedFileList TABLE   
(  
	ExpectedFileYN CHAR(1),  
	ExpectedFileName VARCHAR(50),  
	ExpectedByTime TIME(7)  
)  
AS  
BEGIN  
  
	/* NOTE:  
		  
		MULTI-STATEMENT FUNCTIONS CAN CAUSE PERFORMANCE ISSUES => USE WITH CARE  
  
		DESIGNED TO RETURN ONE FILE OMLY - INTERFACER SUPPORTS MULTIPLE FILES AND CAN BE EXTENDED  
  
	*/  
  
	DECLARE @ExpectedFileLetter CHAR(1) = NULL  
	DECLARE @ExpectedFileName VARCHAR(50)  
	DECLARE @ExpectedByTime TIME   
  
	SELECT  
		TOP 1  
		@ExpectedFileLetter = FileLetter,  
		@ExpectedByTime = DATEADD( minute, ReprocessDelayMinutes, ExpectedStartTime )  
	FROM  
		FileControlT7  
	WHERE  
		CAST( GETDATE() AS TIME) BETWEEN ExpectedStartTime AND ExpectedFinishTime  
	AND  
		ProcessFileYN = 'Y'  
	ORDER BY  
		FileLetter DESC  
  
  
	SELECT  
		@ExpectedFileName = FilePrefix + CONVERT(CHAR(8),GETDATE(),112) + @ExpectedFileLetter   
	FROM  
		FileControl  
	WHERE  
		FileTag = 'TxSaft'  
  
	INSERT INTO  
			@ExpectedFileList  
		SELECT  
			IIF( @ExpectedFileName IS NULL, 'N', 'Y' ) AS ExpectedFileYN,  
			@ExpectedFileName AS ExpectedFileName,  
			@ExpectedByTime AS ExpectedByTime  
  
  
	RETURN   
END  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[EmailMessageControl]'
GO
CREATE TABLE [dbo].[EmailMessageControl] 
( 
[MessageID] [smallint] NOT NULL IDENTITY(1, 1), 
[MessageTag] [varchar] (50) COLLATE Latin1_General_CI_AS NULL, 
[MessageTo] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[MessageCC] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[MessageSubject] [varchar] (2000) COLLATE Latin1_General_CI_AS NULL, 
[MessageBody] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[MessagePriority] [int] NULL, 
[MessageEnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_EmailMessageControl] on [dbo].[EmailMessageControl]'
GO
ALTER TABLE [dbo].[EmailMessageControl] ADD CONSTRAINT [PK_EmailMessageControl] PRIMARY KEY CLUSTERED  ([MessageID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetMessageDetails]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 2/3/2017  
-- Description:	Get the message details for inout error / validation / message tag  
-- =============================================  
CREATE FUNCTION [dbo].[GetMessageDetails]  
(	  
	@TAG VARCHAR(1000)  
)  
RETURNS TABLE   
AS  
RETURN   
(  
	SELECT  
		MessageID,  
		MessageTo,  
		MessageCC,  
		MessageSubject,  
		MessageBody,  
		MessagePriority,  
		MessageEnabledYN  
	FROM  
		EmailMessageControl E  
	WHERE  
		E.MessageTag = COALESCE(  
									(  
  
									/* NOTE: THIS QUERY PATTERN WILL PERFORM BABDLY WITH LARGER VOLUMES OF DATA - DO NOT RE-USE WITHOUT CONSIDERING THIS FACT */  
  
										/* SPECIFIC MESSAGE */  
										SELECT  
											E.MessageTag   
										FROM  
											EmailMessageControl E  
										WHERE  
											E.MessageTag = @TAG  
									),  
									(  
										/* VALIDATION ERROR MESSAGE */  
										SELECT  
											'GENERIC_VALIDATION_ERROR'  
										FROM  
											ValidationUnitTest E  
										WHERE  
											E.ValidationUnitTestTag = @TAG  
										AND  
											E.ErrorCondition = 1  
										/* VALIDATION WARNING MESSAGE */  
									),  
									(  
										SELECT  
											'GENERIC_VALIDATION_WARNING'  
										FROM  
											ValidationUnitTest E  
										WHERE  
											E.ValidationUnitTestTag = @TAG  
										AND  
											E.WarningCondition = 1  
									),  
									/* LAST RESORT FOR ERROR MESSAGE */  
									'GENERIC_ERROR'  
					)  
)  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[CanceledTradeReviewList]'
GO
CREATE TABLE [dbo].[CanceledTradeReviewList] 
( 
[TradeDateID] [int] NOT NULL, 
[TradingSysTransNo] [int] NOT NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[TradeVolume] [numeric] (19, 6) NOT NULL, 
[TradePrice] [numeric] (19, 6) NOT NULL, 
[BrokerCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[TraderCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[Reviewed] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_CanceledTradeReviewList_Reviewed] DEFAULT ('N'), 
[Approved] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_CanceledTradeReviewList_Approved] DEFAULT ('N'), 
[Processed] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_CanceledTradeReviewList_Processed] DEFAULT ('N'), 
[DwhFileID] [int] NOT NULL, 
[CancelationLogged] [datetime2] NOT NULL CONSTRAINT [DF_CanceledTradeReviewList_CancelationLogged] DEFAULT (getdate()), 
[CancelationProcessed] [datetime2] NULL, 
[BatchID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[CanceledTradeManualList]'
GO
CREATE TABLE [dbo].[CanceledTradeManualList] 
( 
[TradeDateID] [int] NOT NULL, 
[TradingSysTransNo] [int] NOT NULL, 
[BrokerCode] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL, 
[ISIN] [varchar] (12) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProcessedAttempted] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProcessedSucceeded] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[CancelationLogged] [datetime2] NOT NULL CONSTRAINT [DF_CanceledTradeManualList_CancelationLogged] DEFAULT (getdate()), 
[CancelationProcessed] [datetime2] NULL, 
[BatchID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AggregationRebuildSystemList]'
GO
CREATE TABLE [dbo].[AggregationRebuildSystemList] 
( 
[AggregationDateID] [int] NOT NULL, 
[ProcessedAttempted] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_AggregationRebuildSystemList_ProcessedAttempted] DEFAULT ('N'), 
[ProcessedSucceeded] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[AggregationLogged] [datetime2] NOT NULL CONSTRAINT [DF_AggregationRebuildSystemList_AggregationLogged] DEFAULT (getdate()), 
[AggregationProcessed] [datetime2] NULL, 
[InsertedBatchID] [int] NOT NULL, 
[ProcessedBatchID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AddAggregationRebuildSystemList]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 14/2/2017  
-- Description:	Add aggregation rebuilds requests for canceled trades  
-- =============================================  
CREATE PROCEDURE [dbo].[AddAggregationRebuildSystemList]  
	@BatchID INT  
AS  
BEGIN  
	SET NOCOUNT ON;  
  
	INSERT INTO   
		dbo.AggregationRebuildSystemList  
		(  
			AggregationDateID,   
			ProcessedAttempted,   
			AggregationLogged,   
			InsertedBatchID  
		)  
		SELECT  
			TradeDateID AS AggregationDateID,   
			'N' AS ProcessedAttempted,   
			GETDATE() AS AggregationLogged,   
			@BatchID AS InsertedBatchID  
		FROM  
			dbo.CanceledTradeManualList  
		WHERE  
			BatchID = @BatchID  
		UNION  
		SELECT  
			TradeDateID AS AggregationDateID,   
			'N' AS ProcessedAttempted,   
			GETDATE() AS AggregationLogged,   
			@BatchID AS InsertedBatchID  
		FROM  
			dbo.CanceledTradeReviewList  
		WHERE  
			BatchID = @BatchID  
END  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AggregationRebuildManualList]'
GO
CREATE TABLE [dbo].[AggregationRebuildManualList] 
( 
[AggregationDateID] [int] NOT NULL, 
[ProcessedAttempted] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_AggregationRebuildManualList_ProcessedAttempted] DEFAULT ('N'), 
[ProcessedSucceeded] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[AggregationLogged] [datetime2] NULL CONSTRAINT [DF_AggregationRebuildManualList_AggregationLogged] DEFAULT (getdate()), 
[AggregationProcessed] [datetime2] NULL, 
[BatchID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetAggregationDateList]'
GO
-- =============================================   
-- Author:		Ian Meade   
-- Create date: 13/2/2017   
-- Description:	Get days to aggregate   
-- =============================================   
CREATE PROCEDURE [dbo].[GetAggregationDateList]   
AS   
BEGIN   
	SET NOCOUNT ON;   
	SELECT   
		/* Today */   
		CAST(GETDATE() AS DATE) AS AggregateDate,   
		CAST(CONVERT(CHAR,GETDATE(),112) AS INT) AggregationDateID   
	UNION   
	SELECT   
		CONVERT(DATE,CAST(AggregationDateID AS CHAR),112) AS AggregateDate,   
		AggregationDateID   
	FROM	   
		dbo.AggregationRebuildManualList   
	WHERE   
		ProcessedAttempted = 'N'   
	UNION   
	SELECT   
		CONVERT(DATE,CAST(AggregationDateID AS CHAR),112) AS AggregationDate,   
		AggregationDateID   
	FROM	   
		dbo.AggregationRebuildSystemList   
	WHERE   
		ProcessedAttempted = 'N'   
	ORDER BY   
		AggregateDate   
  
END   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetFileControlList]'
GO
-- =============================================  
-- Author:		Ian Meade  
-- Create date: 16/1/2017  
-- Description:	Get file control details  
-- =============================================  
CREATE PROCEDURE [dbo].[GetFileControlList]  
AS  
BEGIN  
	-- SET NOCOUNT ON added to prevent extra result sets from  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	SELECT  
		FileTag,  
		FileNameMask,  
		FilePrefix,  
		SourceFolder,  
		ProcessFolder,  
		ArchiveFolder,  
		RejectFolder  
	FROM  
		dbo.FileControl 
	WHERE  
		EnabledYN = 'Y'  
  
END  
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidationLogMessage]'
GO
CREATE TABLE [dbo].[ValidationLogMessage] 
( 
[ValidationLogMessageID] [int] NOT NULL IDENTITY(1, 1), 
[ValidationLogID] [int] NOT NULL, 
[ErrorCode] [int] NOT NULL, 
[Message] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ValidationLogMessage] on [dbo].[ValidationLogMessage]'
GO
ALTER TABLE [dbo].[ValidationLogMessage] ADD CONSTRAINT [PK_ValidationLogMessage] PRIMARY KEY CLUSTERED  ([ValidationLogMessageID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ValidationLog]'
GO
CREATE TABLE [dbo].[ValidationLog] 
( 
[ValidationLogID] [int] NOT NULL IDENTITY(1, 1), 
[BatchID] [int] NOT NULL, 
[ValidationUnitTestID] [int] NOT NULL, 
[UnitTestRun] [datetime2] NOT NULL CONSTRAINT [DF_ValidationLog_UnitTestRun] DEFAULT (getdate()), 
[ErrorCount] [int] NOT NULL, 
[WarningCount] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ValidationLog] on [dbo].[ValidationLog]'
GO
ALTER TABLE [dbo].[ValidationLog] ADD CONSTRAINT [PK_ValidationLog] PRIMARY KEY CLUSTERED  ([ValidationLogID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetValidationMessage]'
GO
-- ============================================= 
-- Author:		Ian Meade 
-- Create date: 31/3/2017 
-- Description:	Get a validation message suitbale for email 
-- ============================================= 
CREATE FUNCTION [dbo].[GetValidationMessage] 
( 
	@ValidationLogID INT 
) 
RETURNS VARCHAR(1000) 
AS 
BEGIN 
	/* WARNING - SCALAR UDFs CAN LEAD TO PERFORMANCE ISSUES - DO NOT USE WITHOUT CONSIDERING IMPACT */ 
 
	RETURN 
	( 
		SELECT  
			TOP 1 
			'Validation routine [' + ut.ValidationUnitTestName + ' \ ' + UT.TestStoredProcedure + '] returned [' + LTRIM(STR(L.WarningCount + L.ErrorCount)) + '] messages ' + CHAR(13) + CHAR(10) +  
								'First message: ' + M.Message + CHAR(13) + CHAR(10) +  
								'Refer to the ProcesControl ValidationLog [' + LTRIM(L.ValidationLogID) + '] for more details' AS X 
										 
		FROM 
				dbo.ValidationLog L 
			INNER JOIN	 
				dbo.ValidationLogMessage M 
			ON L.ValidationLogID = M.ValidationLogID 
			INNER JOIN 
				dbo.ValidationUnitTest UT 
			ON L.ValidationUnitTestID = UT.ValidationUnitTestID 
		WHERE 
			L.ValidationLogID = @ValidationLogID 
		ORDER BY 
			L.ValidationLogID 
	)				 
 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AlertLog]'
GO
CREATE TABLE [dbo].[AlertLog] 
( 
[AlertID] [int] NOT NULL IDENTITY(1, 1), 
[BatchID] [int] NULL, 
[MessageTag] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[AlertDateTime] [datetime2] NOT NULL CONSTRAINT [DF_AlertLog_AlertDateTime] DEFAULT (getdate()), 
[Message1] [varchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL, 
[Message2] [varchar] (max) COLLATE Latin1_General_CI_AS NULL, 
[Message3] [varchar] (max) COLLATE Latin1_General_CI_AS NULL, 
[Message4] [varchar] (max) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_AlertLog] on [dbo].[AlertLog]'
GO
ALTER TABLE [dbo].[AlertLog] ADD CONSTRAINT [PK_AlertLog] PRIMARY KEY CLUSTERED  ([AlertID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ErrorLog]'
GO
CREATE TABLE [dbo].[ErrorLog] 
( 
[ErrorID] [int] NOT NULL IDENTITY(1, 1), 
[BatchID] [int] NOT NULL, 
[ErrorDateTime] [datetime2] NOT NULL CONSTRAINT [DF_ErrorLog_ErrorDateTime] DEFAULT (getdate()), 
[ErrorCode] [int] NOT NULL, 
[ErrorDescription] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL, 
[SourceDescription] [varchar] (max) COLLATE Latin1_General_CI_AS NULL, 
[SourceID] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL, 
[SourceName] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL, 
[SourceParentGUID] [varchar] (max) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ErrorLog] on [dbo].[ErrorLog]'
GO
ALTER TABLE [dbo].[ErrorLog] ADD CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED  ([ErrorID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[QuarantineRule]'
GO
CREATE TABLE [dbo].[QuarantineRule] 
( 
[QuarantineRuleID] [smallint] NOT NULL, 
[QuarantineRuleTag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[Entity] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[EnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[RuleDescription] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[RuleFunction] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_QuarantineRule] on [dbo].[QuarantineRule]'
GO
ALTER TABLE [dbo].[QuarantineRule] ADD CONSTRAINT [PK_QuarantineRule] PRIMARY KEY CLUSTERED  ([QuarantineRuleID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[QuarantineRule]'
GO
ALTER TABLE [dbo].[QuarantineRule] ADD CONSTRAINT [IX_QuarantineRule] UNIQUE NONCLUSTERED  ([QuarantineRuleTag])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[QuarantineLog]'
GO
CREATE TABLE [dbo].[QuarantineLog] 
( 
[QuarantineLogID] [int] NOT NULL, 
[QuarantineRuleID] [smallint] NOT NULL, 
[Entity] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[RowID] [int] NOT NULL, 
[QuartineEntryDatetime] [datetime2] NOT NULL, 
[QuarantineExitDatetime] [datetime2] NULL, 
[QuarantineLastCheckDatetime] [datetime2] NULL, 
[QuartineEntryBatchID] [int] NOT NULL, 
[QuartineExitBatchID] [int] NULL, 
[QuartinelastCheckBatchID] [int] NULL, 
[RetryCount] [smallint] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_QuarantineLog] on [dbo].[QuarantineLog]'
GO
ALTER TABLE [dbo].[QuarantineLog] ADD CONSTRAINT [PK_QuarantineLog] PRIMARY KEY CLUSTERED  ([QuarantineLogID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[EmailServer]'
GO
CREATE TABLE [dbo].[EmailServer] 
( 
[SmptServerAddress] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
[SentFromMessageBox] [varchar] (200) COLLATE Latin1_General_CI_AS NULL, 
[EnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_EmailServer] on [dbo].[EmailServer]'
GO
ALTER TABLE [dbo].[EmailServer] ADD CONSTRAINT [PK_EmailServer] PRIMARY KEY CLUSTERED  ([SmptServerAddress])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Reuters_UpdateControl]'
GO
CREATE TABLE [dbo].[Reuters_UpdateControl] 
( 
[TableName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[LastCutOffCounterUsed] [int] NOT NULL, 
[LastChecked] [datetime2] NULL, 
[LastUpdated] [datetime2] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Reuters_UpdateControl] on [dbo].[Reuters_UpdateControl]'
GO
ALTER TABLE [dbo].[Reuters_UpdateControl] ADD CONSTRAINT [PK_Reuters_UpdateControl] PRIMARY KEY CLUSTERED  ([TableName])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SourceSystem]'
GO
CREATE TABLE [dbo].[SourceSystem] 
( 
[SourceSystemID] [int] NOT NULL IDENTITY(1, 1), 
[SourceSystemName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[SourceSystemTag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[ConnectionString] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL, 
[EnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[CutOffMechanismTag] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
[CutOffChar] [varchar] (100) COLLATE Latin1_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_SourceSystem] on [dbo].[SourceSystem]'
GO
ALTER TABLE [dbo].[SourceSystem] ADD CONSTRAINT [PK_SourceSystem] PRIMARY KEY CLUSTERED  ([SourceSystemID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[SourceSystem]'
GO
ALTER TABLE [dbo].[SourceSystem] ADD CONSTRAINT [IX_SourceSystem] UNIQUE NONCLUSTERED  ([SourceSystemTag])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[XT_UpdateControl]'
GO
CREATE TABLE [dbo].[XT_UpdateControl] 
( 
[TableName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[ExtractSequenceId] [bigint] NOT NULL, 
[LastChecked] [datetime2] NULL, 
[LastUpdated] [datetime2] NULL, 
[LastUpdateBatchID] [int] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_XT_UpdateControl] on [dbo].[XT_UpdateControl]'
GO
ALTER TABLE [dbo].[XT_UpdateControl] ADD CONSTRAINT [PK_XT_UpdateControl] PRIMARY KEY CLUSTERED  ([TableName])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[QuarantineLog]'
GO
ALTER TABLE [dbo].[QuarantineLog] ADD CONSTRAINT [FK_QuarantineLog_QuarantineRule] FOREIGN KEY ([QuarantineRuleID]) REFERENCES [dbo].[QuarantineRule] ([QuarantineRuleID]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[ValidationUnitTest]'
GO
ALTER TABLE [dbo].[ValidationUnitTest] ADD CONSTRAINT [FK_ValidationUnitTest_ValidationTestSuite] FOREIGN KEY ([ValidationTestSuiteID]) REFERENCES [dbo].[ValidationTestSuite] ([ValidationTestSuiteID]) 
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
