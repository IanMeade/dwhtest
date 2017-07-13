SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:	Ian Meade
-- Create date: 27/6/2017
-- Description:	Call Stored Procedure in DSS to add entry to ProcessStatus table
-- =============================================
CREATE PROCEDURE [dbo].[DssAddProcessStatus]
	@Message VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON;
	
	/* CALL STORED PROCEDURES ON ORACLE */


	/* CREATE AN ENTRY */
	EXECUTE ('BEGIN  ISEDBA.PKG_IP.P_PS_STS_UP_EP_START (?); END;', @Message ) AT DSS

	/* MARK ENTRY AS COMPLETE */
	EXECUTE ('BEGIN  ISEDBA.PKG_IP.P_PS_STS_UP_EP_END (?); END;', @Message ) AT DSS

END
GO
