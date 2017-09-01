/* SSIS CONFIGURATIONS */

/* CONNECTIONS TO T7-SYS-DW-01 FROM EQ1 */

/* CREATE SSIS ENVIRNMENT */

EXEC [SSISDB].[catalog].[create_environment] @environment_name=N'EQ1', @environment_description=N'', @folder_name=N'EQ1'

GO


GO

/* SSIS PARAMETERS */

DECLARE @var sql_variant = N'Data Source=T7-SYS-DW-01;Initial Catalog=DWH;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'DWH_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Data Source=T7-SYS-DW-01;Initial Catalog=MDM;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'MDM_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Data Source=T7-SYS-DW-01;Initial Catalog=ProcessControl;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'ProcessControl_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Data Source=T7-SYS-DW-01;Initial Catalog=Staging;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'Staging_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Data Source=T7-SYS-DW-01;Initial Catalog=T7_ODS;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'T7_ODS_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Data Source=T7-SYS-DW-01;Initial Catalog=XT_ODS;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'XT_ODS_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO

GO


GO


/* CREATE REFERENCE */
Declare @reference_id bigint
EXEC [SSISDB].[catalog].[create_environment_reference] @environment_name=N'EQ1', @reference_id=@reference_id OUTPUT, @project_name=N'ETL', @folder_name=N'EQ1', @reference_type=R
Select @reference_id

GO



/* BIND PROJECT TO ENVIRNMENT */

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

GO


