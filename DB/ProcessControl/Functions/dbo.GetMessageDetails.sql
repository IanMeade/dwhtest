SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
