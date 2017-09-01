SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


    
-- =============================================    
-- Author:		Ian Meade    
-- Create date: 13/2/2017    
-- Description:	OCP / Official CLosing Price from TxSAFT files    
-- =============================================    
CREATE FUNCTION [dbo].[udfTxSaftOcp]    
(	    
	@TradeDate DATE    
)    
RETURNS TABLE     
AS    
RETURN     
(    
	WITH
		RequiredTrade AS (
				SELECT    
					T.A_TRADE_DATE,
					T.A_ISIN, 
					MAX(F.FileLetter) AS FileLetter
				FROM    
						dbo.FileList F    
					INNER JOIN    
						dbo.TxSaft T    
					ON F.DwhFileID = T.DwhFileID  
				WHERE
					F.DwhStatus NOT IN ( 'REJECT' )   
				AND   
					T.A_TRADE_DATE = @TradeDate
				AND
					F.ProcessFileYN = 'Y'			
				AND
					F.ContainsEndOfDayDetailsYN = 'Y'
				AND
					/* ENSURE PRICE IS POPULATED */
					A_TRADE_TIME_OCP <> '1858-11-17 00:00:00.000'
				AND
					T.A_OFFICIAL_CLOSING_PRICE <> 0
				AND
					NOT EXISTS (
						/* TRADE HAS NOT BEEN CANCELLED */
						SELECT
							*
						FROM
							dbo.TxSaft T2
						WHERE
							T.A_TRADE_DATE = T2.A_TRADE_DATE
						AND
							T.A_TRADE_LINK_NO = T2.A_TRADE_LINK_NO 
						AND
							T.A_ISIN = T2.A_ISIN
						AND
							T.A_ORDER_TYPE = T2.A_ORDER_TYPE
						AND    
							/* NOT CANCELED */    
							T2.A_MOD_REASON_CODE = '003'    
					)
				GROUP BY
					T.A_TRADE_DATE,
					T.A_ISIN
			)
		SELECT
			T.A_ISIN,    
			MAX(T.A_OFFICIAL_CLOSING_PRICE) AS A_OFFICIAL_CLOSING_PRICE,    
			MAX(T.A_TRADE_TIME_OCP) AS A_TRADE_TIME_OCP,    
			MAX(T.A_TRADE_TIME_OCP_LOCAL) AS A_TRADE_TIME_OCP_LOCAL,    
			COUNT(DISTINCT T.A_OFFICIAL_CLOSING_PRICE) AS PriceVersions,    
			COUNT(DISTINCT T.A_TRADE_TIME_OCP) AS TimeVersions  
		FROM
				RequiredTrade R
			INNER JOIN
				dbo.FileList F    
			ON R.FileLetter = F.FileLetter
			INNER JOIN    
				dbo.TxSaft T    
			ON F.DwhFileID = T.DwhFileID  
		WHERE
				R.A_TRADE_DATE = T.A_TRADE_DATE
			AND
				R.A_ISIN = T.A_ISIN
			AND
				F.DwhStatus NOT IN ( 'REJECT' )   
			AND
				F.ProcessFileYN = 'Y'			
			AND   
				F.ContainsEndOfDayDetailsYN = 'Y'
			AND
				/* ENSURE PRICE IS POPULATED */
				A_TRADE_TIME_OCP <> '1858-11-17 00:00:00.000'
			AND
				T.A_OFFICIAL_CLOSING_PRICE <> 0
		GROUP BY
			R.FileLetter,
			T.A_ISIN
   
)    
  

GO
