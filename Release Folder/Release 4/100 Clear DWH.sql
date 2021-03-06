USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'Clear DWH', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]'
		--, 
		--@owner_login_name=N'SYS-ISE\ianm', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'Clear DWH', @server_name = N'T7-DDT-06'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'Clear DWH', @step_name=N'Clear DWH', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
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
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'Clear DWH', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'[Uncategorized (Local)]', 
--		@owner_login_name=N'SYS-ISE\ianm', 
		@notify_email_operator_name=N'', 
		@notify_netsend_operator_name=N'', 
		@notify_page_operator_name=N''
GO
