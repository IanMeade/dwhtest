/* SSIS CONFIGURATIONS */
/* CONNECTIONS TO T7-DDT-07 FROM EQ1 ENVIRONMENT */


EXEC [SSISDB].[catalog].[delete_environment] @environment_name=N'EQ1', @folder_name=N'EQ1'


GO

/* CREATE SSIS ENVIRONMENT */

EXEC [SSISDB].[catalog].[create_environment] @environment_name=N'EQ1', @environment_description=N'', @folder_name=N'EQ1'

GO


GO

/* SSIS PARAMETERS */

DECLARE @var sql_variant = N'Data Source=.;Initial Catalog=DWH;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'DWH_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Data Source=.;Initial Catalog=MDM;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'MDM_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Data Source=.;Initial Catalog=ProcessControl;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'ProcessControl_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Data Source=.;Initial Catalog=Staging;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'Staging_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Data Source=.;Initial Catalog=T7_ODS;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'T7_ODS_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Data Source=.;Initial Catalog=XT_ODS;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'XT_ODS_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO

/* NEW DBs */

DECLARE @var sql_variant = N'Data Source=.;Initial Catalog=Reuters_ODS;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'Reuters_ODS_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Data Source=.;Initial Catalog=StateStreet_ODS;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'StateStreet_ODS_ConnectionStringg', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Data Source=.;Initial Catalog=Stoxx_ODS;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'Stoxx_ODS_ConnectionString', @sensitive=False, @description=N'', @environment_name=N'EQ1', @folder_name=N'EQ1', @value=@var, @data_type=N'String'
GO




GO
