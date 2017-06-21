SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ian Meade
-- Create date: 21/6/2017
-- Description:	Prepare FactEtfSnapshotMerge table - default values etc...
-- =============================================
CREATE PROCEDURE [ETL].[UpdateFactEtfSnapshotHelper]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/* GET THE DATE AGGREGATION IS RUN FOR - DEFINED TO BE ONE DAY IN EACH PROCEDURE CALL */    
	DECLARE @DateID AS INT    
	SELECT    
		@DateID = MAX(AggregationDateID)    
	FROM    
		ETL.FactEtfSnapshotMerge  

	/* GET PREVIOUS ROWS - FOR DEFAULT VALUES USED IN FIRST ROW PER DAY */     
	SELECT
		DWH.EtfSnapshotID,
		I.InstrumentGlobalID
	INTO
		#PreviousRows
	FROM
		(
			SELECT
				InstrumentGlobalID,
				MAX(DateID)	AS DateID
			FROM
					DWH.FactEtfSnapshot DWH     
				INNER JOIN     
					DWH.DimInstrumentEtf I     
				ON DWH.InstrumentID = I.InstrumentID     
			WHERE
				DWH.DateID < 20170621
			GROUP BY
				InstrumentGlobalID
		) AS Prev
		INNER JOIN
			DWH.FactEtfSnapshot DWH     
		ON DWH.DateID = Prev.DateID
		INNER JOIN     
			DWH.DimInstrumentEtf I 
		ON Prev.InstrumentGlobalID = I.InstrumentGlobalID
		AND DWH.InstrumentID = I.InstrumentID     

	UPDATE
		ETL
	SET
		/* FROM YESTERDAY */
		OCPDateID = COALESCE( ETL.OCPDateID, SN.OCPDateID),
		OCPTimeID = COALESCE( ETL.OCPTimeID, SN.OCPTimeID),
		OCPTime = COALESCE( ETL.OCPTime, SN.OCPTime),
		UtcOCPTime = COALESCE( ETL.UtcOCPTime, SN.UtcOCPTime),
		LTPDateID = COALESCE( ETL.LTPDateID, SN.LTPDateID),
		LTPTimeID = COALESCE( ETL.LTPTimeID, SN.LTPTimeID),
		LTPTime = COALESCE( ETL.LTPTime, SN.LTPTime),
		UtcLTPTime = COALESCE( ETL.UtcLTPTime, SN.UtcLTPTime),
		OpenPrice = COALESCE( ETL.OpenPrice, SN.OpenPrice),
		LowPrice = COALESCE( ETL.LowPrice, SN.LowPrice),
		HighPrice = COALESCE( ETL.HighPrice, SN.HighPrice),
		LastPrice = COALESCE( ETL.LastPrice, SN.LTP),

		/* MAKE NULLABLE FIELD 0 */ 
		Turnover = ISNULL( ETL.Turnover, 0),    
		TurnoverND = ISNULL( ETL.TurnoverND, 0),    
		TurnoverEur = ISNULL( ETL.TurnoverEur, 0),     
		TurnoverNDEur = ISNULL( ETL.TurnoverNDEur, 0),     
		TurnoverOB = ISNULL( ETL.TurnoverOB, 0),     
		TurnoverOBEur = ISNULL( ETL.TurnoverOBEur, 0),     
		Volume = ISNULL( ETL.Volume, 0),     
		VolumeND = ISNULL( ETL.VolumeND, 0),     
		VolumeOB = ISNULL( ETL.VolumeOB, 0),     
		Deals = ISNULL( ETL.Deals, 0),     
		DealsOB = ISNULL( ETL.DealsOB, 0),     
		DealsND = ISNULL( ETL.DealsND, 0)   

	FROM
			ETL.FactEtfSnapshotMerge ETL
		LEFT OUTER JOIN
			#PreviousRows PR
		ON ETL.InstrumentGlobalID = ETL.InstrumentGlobalID
		LEFT OUTER JOIN
			DWH.FactEtfSnapshot SN
		ON PR.EtfSnapshotID = SN.EtfSnapshotID  

	DROP TABLE #PreviousRows
END
GO
