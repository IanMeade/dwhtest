Declare @reference_id bigint
EXEC [SSISDB].[catalog].[create_environment_reference] @environment_name=N'EQ1', @environment_folder_name=N'EQ1', @reference_id=@reference_id OUTPUT, @project_name=N'ETL', @folder_name=N'EQ1', @reference_type=A
Select @reference_id

GO

GO




USE [msdb]
GO
EXEC msdb.dbo.sp_update_jobstep @job_id=N'5e323b15-5fb1-457b-86b6-4782f181f488', @step_id=1 , 
		@command=N'/ISSERVER "\"\SSISDB\EQ1\ETL\PckMaster.dtsx\"" /SERVER "\"T7-DDT-06\"" /ENVREFERENCE 9 /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
GO



EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'DWH_ConnectionString', @object_name=N'ETL', @folder_name=N'EQ1', @project_name=N'ETL', @value_type=R, @parameter_value=N'DWH_ConnectionString'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'MDM_ConnectionString', @object_name=N'ETL', @folder_name=N'EQ1', @project_name=N'ETL', @value_type=R, @parameter_value=N'MDM_ConnectionString'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'ProcessControl_ConnectionString', @object_name=N'ETL', @folder_name=N'EQ1', @project_name=N'ETL', @value_type=R, @parameter_value=N'ProcessControl_ConnectionString'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'Staging_ConnectionString', @object_name=N'ETL', @folder_name=N'EQ1', @project_name=N'ETL', @value_type=R, @parameter_value=N'Staging_ConnectionString'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'T7_ODS_ConnectionString', @object_name=N'ETL', @folder_name=N'EQ1', @project_name=N'ETL', @value_type=R, @parameter_value=N'T7_ODS_ConnectionString'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'XT_ODS_ConnectionString', @object_name=N'ETL', @folder_name=N'EQ1', @project_name=N'ETL', @value_type=R, @parameter_value=N'XT_ODS_ConnectionString'
GO

EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'Reuters_ODS_ConnectionString', @object_name=N'ETL', @folder_name=N'EQ1', @project_name=N'ETL', @value_type=R, @parameter_value=N'Reuters_ODS_ConnectionString'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'StateStreet_ODS_ConnectionString', @object_name=N'ETL', @folder_name=N'EQ1', @project_name=N'ETL', @value_type=R, @parameter_value=N'StateStreet_ODS_ConnectionStringg'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'Stoxx_ODS_ConnectionString', @object_name=N'ETL', @folder_name=N'EQ1', @project_name=N'ETL', @value_type=R, @parameter_value=N'Stoxx_ODS_ConnectionString'
GO

GO


