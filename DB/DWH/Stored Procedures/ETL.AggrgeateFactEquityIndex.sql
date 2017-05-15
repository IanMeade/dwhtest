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
	@IndexDateID INT 
AS 
BEGIN 
	SET NOCOUNT ON; 
 
	/* FIND FIRST AND LAST ROWS */ 
	; 
	WITH SamplesRequired AS ( 
					SELECT 
						IndexDateID 
					FROM 
							DWH.FactEquityIndex O 
					WHERE 
						IndexDateID = @IndexDateID 
					GROUP BY 
						IndexDateID 
				) 
		SELECT 
			X.IndexDateID, 
			FirstSample.EquityIndexID AS  FirstSampleEquityIndexID, 
			LastSample.EquityIndexID AS  LastSampleEquityIndexID 
		INTO 
			#Samples 
		FROM 
				SamplesRequired AS X 
			CROSS APPLY ( 
					SELECT 
						TOP 1 
						EquityIndexID 
					FROM 
						DWH.FactEquityIndex I 
					WHERE 
						X.IndexDateID = I.IndexDateID 
					ORDER BY 
						I.IndexTimeID, 
						I.EquityIndexID 
				) AS FirstSample 
			CROSS APPLY ( 
					SELECT 
						TOP 1 
						EquityIndexID 
					FROM 
						DWH.FactEquityIndex I 
					WHERE 
						X.IndexDateID = I.IndexDateID 
					ORDER BY 
						I.IndexTimeID DESC, 
						I.EquityIndexID DESC 
				) AS LastSample 
 
				; 
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
					I.EquityIndexID = S.FirstSampleEquityIndexID 
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
			'IEOD' AS IndexCode, 
			ISEQ20InverseOpen AS OpenValue 
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
			'IE0E' AS IndexCode, 
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
				ON I.EquityIndexID = S.FirstSampleEquityIndexID 
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
			'IEOD' AS IndexCode, 
			ISEQ20InverseLast AS LastValue, 
			ISEQ20InverseReturn AS ReturnValue 
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
				MIN(OverallLast) OverallDailyLow, 
				MIN(FinancialLast) FinancialDailyLow, 
				MIN(GeneralLast) GeneralDailyLow, 
				MIN(SmallCapLast) SamllCapDailyLow, 
				MIN(ITEQLast) ITEQDailyLow, 
				MIN(ISEQ20Last) ISEQ20DailyLow, 
				MIN(ISEQ20INAVLast) ISEQ20INAVDailyLow, 
				MIN(ESMLast) ESMDailyLow, 
				MIN(ISEQ20InverseLast) ISEQ20InverseDailyLow, 
				MIN(ISEQ20LeveragedLast) ISEQ20LeveragedDailyLow, 
				MIN(ISEQ20CappedLast) ISEQ20CappedDailyLow, 
 
				MAX(OverallLast) OverallDailyHigh, 
				MAX(FinancialLast) FinancialDailyHigh, 
				MAX(GeneralLast) GeneralDailyHigh, 
				MAX(SmallCapLast) SamllCapDailyHigh, 
				MAX(ITEQLast) ITEQDailyHigh, 
				MAX(ISEQ20Last) ISEQ20DailyHigh, 
				MAX(ISEQ20INAVLast) ISEQ20INAVDailyHigh, 
				MAX(ESMLast) ESMDailyHigh, 
				MAX(ISEQ20InverseLast) ISEQ20InverseDailyHigh, 
				MAX(ISEQ20LeveragedLast) ISEQ20LeveragedDailyHigh, 
				MAX(ISEQ20CappedLast) ISEQ20CappedDailyHigh 
			FROM 
				DWH.FactEquityIndex O 
			WHERE 
				IndexDateID = @IndexDateID 
			GROUP BY 
				IndexDateID 
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
			'IEOD' AS IndexCode, 
			ISEQ20InverseDailyLow AS DailyLowValue, 
			ISEQ20InverseDailyHigh AS DailyHighValue 
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
