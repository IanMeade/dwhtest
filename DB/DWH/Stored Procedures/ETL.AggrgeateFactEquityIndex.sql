SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================    
-- Author:		Ian Meade    
-- Create date: 25/4/2017    
-- Description:	Aggregate the Equity Indexes - for upodate to FactEquityIndexSnapshot    
--				Note: cannot call storted proecedure dirrectly from SSIS due to meta-data issue - populating tbale for next step    
-- =============================================    
CREATE PROCEDURE [ETL].[AggrgeateFactEquityIndex]    
	@IndexDateID INT, 
	@ExpectedTime DATETIME 
AS    
BEGIN    
	SET NOCOUNT ON;    
    
	DECLARE @TimeID INT  
 
	SELECT 
		@TimeID = CAST(LEFT(REPLACE( CONVERT(CHAR, @ExpectedTime, 114), ':', ''),4) AS INT) 
 
 
   /* FIND LAST INDX SAMPLE FOR REQUIRED DATE */ 
 
	SELECT 
		MAX(EquityIndexID) AS EquityIndexID 
	INTO    
		#Samples    
	FROM 
		DWH.FactEquityIndex 
	WHERE 
		IndexDateID = @IndexDateID 
	AND 
		IndexTimeID = ( 
					SELECT				 
						MAX(IndexTimeID) 
					FROM 
						DWH.FactEquityIndex 
					WHERE 
						IndexDateID = @IndexDateID 
					AND 
						IndexTimeID <= @TimeID 
				); 
 
	 /* Get Open values in #FIRST tmep table */   
	 /* Get Last & Return in #LAST tnep table */   
	 /* Gets gih and low in #AGG temp table */   
     
	WITH RowBased AS (    
			SELECT    
				I.IndexDateID,    
				OverallOpen,    
				FinancialOpen,    
				GeneralOpen,    
				SmallCapOpen,    
				ITEQOpen,    
				ISEQ20Open,    
				ISEQ20INAVOpen,    
				ESMopen,    
				ISEQ20InverseOpen,    
				ISEQ20LeveragedOpen,    
				ISEQ20CappedOpen    
			FROM    
					DWH.FactEquityIndex I    
				INNER JOIN    
					#Samples S    
				ON    
					I.EquityIndexID = S.EquityIndexID   
			)    
		SELECT    
			IndexDateID,    
			'IEOP' AS IndexCode,    
			OverallOpen AS OpenValue    
		INTO     
			#FIRST    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEUP' AS IndexCode,    
			FinancialOpen AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEQP' AS IndexCode,    
			GeneralOpen AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEYP' AS IndexCode,    
			SmallCapOpen AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEEP' AS IndexCode,    
			ISEQ20Open AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOA' AS IndexCode,    
			ESMopen AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOC' AS IndexCode,    
			ISEQ20LeveragedOpen AS OpenValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOE' AS IndexCode,    
			ISEQ20CappedOpen AS OpenValue    
		FROM    
			RowBased;    
    
	WITH RowBased AS (    
			SELECT    
				I.IndexDateID,    
				OverallLast,    
				FinancialLast,    
				GeneralLast,    
				SmallCapLast,    
				ITEQLast,    
				ISEQ20Last,    
				ISEQ20INAVLast,    
				ESMLast,    
				ISEQ20InverseLast,    
				ISEQ20LeveragedLast,    
				ISEQ20CappedLast,    
				OverallReturn,    
				FinancialReturn,    
				GeneralReturn,    
				SmallCapReturn,    
				ITEQReturn,    
				ISEQ20Return,    
				NULL AS ISEQ20INAVReturn,    
				ESMReturn,    
				ISEQ20InverseReturn,    
				ISEQ20CappedReturn    
			FROM    
					DWH.FactEquityIndex I    
				INNER JOIN    
					#Samples S    
				ON I.EquityIndexID = S.EquityIndexID    
			)    
		SELECT    
			IndexDateID,    
			'IEOP' AS IndexCode,    
			OverallLast AS LastValue,    
			OverallReturn AS ReturnValue    
		INTO #LAST    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEUP' AS IndexCode,    
			FinancialLast AS LastValue,    
			FinancialReturn AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEQP' AS IndexCode,    
			GeneralLast AS LastValue,    
			GeneralReturn AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEYP' AS IndexCode,    
			SmallCapLast AS LastValue,    
			SmallCapReturn AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEEP' AS IndexCode,    
			ISEQ20Last AS LastValue,    
			ISEQ20Return AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOA' AS IndexCode,    
			ESMLast AS LastValue,    
			ESMReturn AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOC' AS IndexCode,    
			ISEQ20LeveragedLast AS LastValue,    
			NULL AS ReturnValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOE' AS IndexCode,    
			ISEQ20CappedLast AS LastValue,    
			ISEQ20CappedReturn AS ReturnValue    
		FROM    
			RowBased;    
    
    
	/* HIGHEST AND HighEST */    
	WITH RowBased AS (    
			SELECT    
				IndexDateID,    
				(OverallLow) OverallDailyLow,    
				(FinancialLow) FinancialDailyLow,    
				(GeneralLow) GeneralDailyLow,    
				(SmallCapLow) SamllCapDailyLow,    
				(ITEQLow) ITEQDailyLow,    
				(ISEQ20Low) ISEQ20DailyLow,    
				(ISEQ20INAVLow) ISEQ20INAVDailyLow,    
				(ESMLow) ESMDailyLow,    
				(ISEQ20InverseLow) ISEQ20InverseDailyLow,    
				(ISEQ20LeveragedLow) ISEQ20LeveragedDailyLow,    
				(ISEQ20CappedLow) ISEQ20CappedDailyLow,    
    
				(OverallHigh) OverallDailyHigh,    
				(FinancialHigh) FinancialDailyHigh,    
				(GeneralHigh) GeneralDailyHigh,    
				(SmallCapHigh) SamllCapDailyHigh,    
				(ITEQHigh) ITEQDailyHigh,    
				(ISEQ20High) ISEQ20DailyHigh,    
				(ISEQ20INAVHigh) ISEQ20INAVDailyHigh,    
				(ESMHigh) ESMDailyHigh,    
				(ISEQ20InverseHigh) ISEQ20InverseDailyHigh,    
				(ISEQ20LeveragedHigh) ISEQ20LeveragedDailyHigh,    
				(ISEQ20CappedHigh) ISEQ20CappedDailyHigh    
			FROM    
					DWH.FactEquityIndex I    
				INNER JOIN    
					#Samples S    
				ON I.EquityIndexID = S.EquityIndexID  
		)    
		SELECT    
			IndexDateID,    
			'IEOP' AS IndexCode,    
			OverallDailyLow AS DailyLowValue,    
			OverallDailyHigh AS DailyHighValue    
		INTO #AGG    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEUP' AS IndexCode,    
			FinancialDailyLow AS DailyLowValue,    
			FinancialDailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEQP' AS IndexCode,    
			GeneralDailyLow AS DailyLowValue,    
			GeneralDailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEYP' AS IndexCode,    
			SamllCapDailyLow AS DailyLowValue,    
			SamllCapDailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEEP' AS IndexCode,    
			ISEQ20DailyLow AS DailyLowValue,    
			ISEQ20DailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOA' AS IndexCode,    
			ESMDailyLow AS DailyLowValue,    
			ESMDailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOC' AS IndexCode,    
			ISEQ20LeveragedDailyLow AS DailyLowValue,    
			ISEQ20LeveragedDailyHigh AS DailyHighValue    
		FROM    
			RowBased    
		UNION ALL    
		SELECT    
			IndexDateID,    
			'IEOE' AS IndexCode,    
			ISEQ20CappedDailyLow AS DailyLowValue,    
			ISEQ20CappedDailyHigh AS DailyHighValue    
		FROM    
			RowBased;    
    
	TRUNCATE TABLE ETL.FactEquityIndexPrep    
    
	INSERT INTO    
			ETL.FactEquityIndexPrep    
		(    
			IndexDateID,    
			IndexCode,    
			OpenValue,    
			LastValue,    
			ReturnValue,    
			DailyLowValue,    
			DailyHighValue    
		)    
		SELECT    
			F.IndexDateID,    
			F.IndexCode,    
			F.OpenValue,    
			L.LastValue,    
			L.ReturnValue,    
			A.DailyLowValue,    
			A.DailyHighValue    
		FROM    
				#FIRST F    
			INNER JOIN    
				#LAST L    
			ON F.IndexDateID = L.IndexDateID    
			AND F.IndexCode = L.IndexCode    
			INNER JOIN    
				#AGG A    
			ON F.IndexDateID = A.IndexDateID    
			AND F.IndexCode = A.IndexCode    

 

	DROP TABLE #Samples    
	DROP TABLE #FIRST    
	DROP TABLE #LAST    
	DROP TABLE #AGG    
    
END    
    

GO
