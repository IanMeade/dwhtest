SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 7/3/2017
-- Description:	Get a list of instrument status chnages
-- =============================================
CREATE PROCEDURE [dbo].[GetInstrumentStatusChanges]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		O.GID,
		UPPER(O.ListingStatus) AS StatusName,
		UPPER(COALESCE(PrevState.ListingStatus, S.StatusName, 'New')) AS OldStatusName,
		CASE 
			WHEN O.InstrumentStatusDate = '19000101' THEN -1
			ELSE CAST(CONVERT(CHAR,O.InstrumentStatusDate,112) AS INT) 
		END AS InstrumemtStatusDateID,
		CAST(REPLACE(LEFT(CONVERT(CHAR,O.InstrumentStatusDate,114),5),':','') AS SMALLINT) AS InstrumemtStatusTimeID, 
		CONVERT(TIME,O.InstrumentStatusDate) AS InstrumemtStatusTime,
		CAST(CONVERT(CHAR,O.InstrumentStatusCreatedDatetime,112) AS INT) AS InstrumentStatusCreatedDateID,
		CAST(REPLACE(LEFT(CONVERT(CHAR,O.InstrumentStatusCreatedDatetime,114),5),':','') AS SMALLINT) AS InstrumentStatusCreatedTimeID,
		CONVERT(TIME,O.InstrumentStatusCreatedDatetime) AS InstrumentStatusCreatedTime
	FROM
			dbo.XtOdsShare O
		OUTER APPLY (
			/* PREVIOUS STATE IN ODS SAMPLE */
			SELECT
				TOP 1
				I.ListingStatus,
				I.InstrumentStatusDate
			FROM
				dbo.XtOdsShare I
			WHERE
				O.GID = I.GID
			AND
				O.ExtractSequenceId > I.ExtractSequenceId 
			ORDER BY
				I.ExtractSequenceId DESC
		) AS PrevState
		/* CURRENT STATE IN DWH */
		LEFT OUTER JOIN
			dbo.DwhDimInstrumentEquityEtf DI
		ON O.GID = DI.InstrumentGlobalID
		AND DI.CurrentRowYN = 'Y'
		LEFT OUTER JOIN
			DwhDimStatus S
		ON DI.InstrumentStatusID = S.StatusID
	WHERE
		O.ListingStatus <> COALESCE(PrevState.ListingStatus, S.StatusName, 'New' )

END
GO
