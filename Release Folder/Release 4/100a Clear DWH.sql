USE [msdb]
GO

/****** Object:  Job [Clear DWH]    Script Date: 28/03/2017 16:16:34 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'edf4f91f-a497-4c85-bacc-d08e0d21ffc7', @delete_unused_schedule=1
GO

/****** Object:  Job [Clear DWH]    Script Date: 28/03/2017 16:16:34 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/03/2017 16:16:34 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Clear DWH', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'SYS-ISE\IanM', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Clear DWH]    Script Date: 28/03/2017 16:16:35 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Clear DWH', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/* CLEAR DWH PERSISTENT DATABASES */

USE DWH
GO
EXEC [DWH].[ClearAllTables]
GO
USE T7_ODS
TRUNCATE TABLE [dbo].[PriceFile]
TRUNCATE TABLE [dbo].[TxSaft]
TRUNCATE TABLE [dbo].[File]
GO
USE ProcessControl
UPDATE XT_UpdateControl SET ExtractSequenceId = 0
TRUNCATE TABLE dbo.AlertLog
TRUNCATE TABLE dbo.ErrorLog
TRUNCATE TABLE dbo.ValidationLogMessage
TRUNCATE TABLE dbo.ValidationLog
TRUNCATE TABLE dbo.CanceledTradeManualList
TRUNCATE TABLE dbo.CanceledTradeReviewList
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


