SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 4/5/2017
-- Description:	Write to Oracle ProcessStatus
-- =============================================
CREATE PROCEDURE [dbo].[AddOracleProcessStatus]
	@RECORD_ID INT,
	@MESSAGE VARCHAR(1000),
	@START DATETIME,
	@END DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/*
	DECLARE @RECORD_ID INT = 698260
	DECLARE @MESSAGE VARCHAR(1000) = 'STORY BUDDIE?'
	DECLARE @START DATETIME = DATEADD(MINUTE,-7,GETDATE())
	DECLARE @END DATETIME = DATEADD(MINUTE,-2,GETDATE())
	*/

	EXECUTE( 'INSERT INTO ISEDBA.PROCESS_STATUS VALUES ( ?, SYSDATE, ?, ''Y'', ?, ? )', @RECORD_ID, @MESSAGE, @START, @END ) AT [DB2]

END
GO
