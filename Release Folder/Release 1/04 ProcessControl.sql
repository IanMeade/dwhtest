USE ProcessControl
GO

/* 
Run this script on a database with the schema represented by: 
 
        ProcessControl    -  This database will be modified. The scripts folder will not be modified. 
 
to synchronize it with a database with the schema represented by: 
 
        T7-DDT-01.ProcessControl 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 24/02/2017 14:13:24 
 
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
PRINT N'Creating [dbo].[AggregationRebuildManualList]'
GO
CREATE TABLE [dbo].[AggregationRebuildManualList] 
( 
[AggregationDateID] [int] NOT NULL, 
[ProcessedAttempted] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_AggregationRebuildManualList_ProcessedAttempted] DEFAULT ('N'), 
[ProcessedSucceeded] [char] (1) COLLATE Latin1_General_CI_AS NULL, 
[AggregationLogged] [datetime2] NOT NULL CONSTRAINT [DF_AggregationRebuildManualList_AggregationLogged] DEFAULT (getdate()), 
[AggregationProcessed] [datetime2] NULL, 
[BatchID] [int] NOT NULL 
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
[BatchID] [int] NOT NULL 
)
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
PRINT N'Creating [dbo].[FileControl]'
GO
CREATE TABLE [dbo].[FileControl] 
( 
[FileControlID] [int] NOT NULL IDENTITY(1, 1), 
[SourceSystemID] [int] NOT NULL, 
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileTag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[FileNameMask] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL, 
[FilePrefix] [varchar] (20) COLLATE Latin1_General_CI_AS NULL, 
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
		CONVERT(DATE,CAST(AggregationDateID AS CHAR),112) AS AggregationDate, 
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
		SS.SourceSystemID, 
		SourceSystemTag, 
		FC.FileTag, 
		FC.FileNameMask, 
		FC.FilePrefix, 
		FC.SourceFolder, 
		FC.ProcessFolder, 
		FC.ArchiveFolder, 
		FC.RejectFolder 
	FROM 
			dbo.SourceSystem SS 
		INNER JOIN 
			dbo.FileControl FC 
		ON SS.SourceSystemID = FC.SourceSystemID 
	WHERE 
		SS.EnabledYN = 'Y' 
 
END 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AggregationRule]'
GO
CREATE TABLE [dbo].[AggregationRule] 
( 
[AggregationRuleID] [smallint] NOT NULL, 
[AggregationRuleName] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[AgregationRuleTag] [char] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[AggregationRuleTarget] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL, 
[AggregationRuleEnabledYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL, 
[AggregationRuleSchedule] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_AggregationRule] on [dbo].[AggregationRule]'
GO
ALTER TABLE [dbo].[AggregationRule] ADD CONSTRAINT [PK_AggregationRule] PRIMARY KEY CLUSTERED  ([AggregationRuleID])
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
PRINT N'Creating [dbo].[EmailServer]'
GO
CREATE TABLE [dbo].[EmailServer] 
( 
[SmptServerAddress] [varchar] (200) COLLATE Latin1_General_CI_AS NOT NULL, 
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
PRINT N'Creating [dbo].[ProcessStatus]'
GO
CREATE TABLE [dbo].[ProcessStatus] 
( 
[ProcessStatusID] [int] NOT NULL, 
[BatchID] [int] NULL, 
[ProcessName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProcessState] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL, 
[ProcessNotes] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL, 
[ProcessStarted] [datetime2] NOT NULL, 
[ProcessEnded] [datetime2] NULL 
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
PRINT N'Creating [dbo].[XT_UpdateControl]'
GO
CREATE TABLE [dbo].[XT_UpdateControl] 
( 
[TableName] [varchar] (11) COLLATE Latin1_General_CI_AS NOT NULL, 
[ExtractSequenceId] [bigint] NOT NULL, 
[LastChecked] [datetime2] NOT NULL, 
[LastUpdated] [datetime2] NOT NULL, 
[LastUpdateBatchID] [int] NOT NULL 
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
PRINT N'Adding foreign keys to [dbo].[FileControl]'
GO
ALTER TABLE [dbo].[FileControl] ADD CONSTRAINT [FK_FileControl_SourceSystem] FOREIGN KEY ([SourceSystemID]) REFERENCES [dbo].[SourceSystem] ([SourceSystemID]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[QuarantineLog]'
GO
ALTER TABLE [dbo].[QuarantineLog] ADD CONSTRAINT [FK_QuarantineLog_QuarantineRule] FOREIGN KEY ([QuarantineRuleID]) REFERENCES [dbo].[QuarantineRule] ([QuarantineRuleID]) 
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
