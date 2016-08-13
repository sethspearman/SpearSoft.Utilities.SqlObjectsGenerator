

if object_id(dbo.vw_GetTabularScoringDataGenericWithTotals) is not null
	drop view dbo.vw_GetTabularScoringDataGenericWithTotals




CREATE	VIEW [dbo].[vw_GetTabularScoringDataGenericWithTotals] 
AS
	SELECT 
         [JudgeAlias]
		,[JudgeName]
		,[JudgeID]
		,[EventTurnID] [EventTurnID]
		,[EventTurnJudgeID]
        ,[RawScore]
        
         ,CAST((Criteria_1) AS DECIMAL(9,4)) AS Criteria_1
        ,CAST((Criteria_2) AS DECIMAL(9,4)) AS Criteria_2
        ,CAST((Criteria_3) AS DECIMAL(9,4)) AS Criteria_3
        ,CAST((Criteria_4) AS DECIMAL(9,4)) AS Criteria_4
        ,CAST((Criteria_5) AS DECIMAL(9,4)) AS Criteria_5
        ,CAST((Criteria_6) AS DECIMAL(9,4)) AS Criteria_6
        ,CAST((Criteria_7) AS DECIMAL(9,4)) AS Criteria_7
        ,CAST((Criteria_8) AS DECIMAL(9,4)) AS Criteria_8
        ,CAST((Criteria_9) AS DECIMAL(9,4)) AS Criteria_9
        ,CAST((Criteria_10) AS DECIMAL(9,4)) AS Criteria_10
        ,CAST((Criteria_11) AS DECIMAL(9,4)) AS Criteria_11
        ,CAST((Criteria_12) AS DECIMAL(9,4)) AS Criteria_12
        ,CAST((Criteria_13) AS DECIMAL(9,4)) AS Criteria_13
        ,CAST((Criteria_14) AS DECIMAL(9,4)) AS Criteria_14
        ,CAST((Criteria_15) AS DECIMAL(9,4)) AS Criteria_15
        ,CAST((Criteria_16) AS DECIMAL(9,4)) AS Criteria_16        
        ,CAST((Criteria_17) AS DECIMAL(9,4)) AS Criteria_17 
        
        ,CAST((Criteria_1_Exec)  AS DECIMAL(9,4)) AS Criteria_1_Exec
        ,CAST((Criteria_2_Exec)  AS DECIMAL(9,4)) AS Criteria_2_Exec
        ,CAST((Criteria_3_Exec)  AS DECIMAL(9,4)) AS Criteria_3_Exec
        ,CAST((Criteria_4_Exec)  AS DECIMAL(9,4)) AS Criteria_4_Exec
        ,CAST((Criteria_5_Exec)  AS DECIMAL(9,4)) AS Criteria_5_Exec
        ,CAST((Criteria_6_Exec)  AS DECIMAL(9,4)) AS Criteria_6_Exec
        ,CAST((Criteria_7_Exec)  AS DECIMAL(9,4)) AS Criteria_7_Exec
        ,CAST((Criteria_8_Exec)  AS DECIMAL(9,4)) AS Criteria_8_Exec
        ,CAST((Criteria_9_Exec)  AS DECIMAL(9,4)) AS Criteria_9_Exec
        ,CAST((Criteria_10_Exec) AS DECIMAL(9,4)) AS Criteria_10_Exec
        ,CAST((Criteria_11_Exec) AS DECIMAL(9,4)) AS Criteria_11_Exec
        ,CAST((Criteria_12_Exec) AS DECIMAL(9,4)) AS Criteria_12_Exec   
        ,CAST((Criteria_13_Exec) AS DECIMAL(9,4)) AS Criteria_13_Exec   
        ,CAST((Criteria_14_Exec) AS DECIMAL(9,4)) AS Criteria_14_Exec   
        ,CAST((Criteria_15_Exec) AS DECIMAL(9,4)) AS Criteria_15_Exec   
        ,CAST((Criteria_16_Exec) AS DECIMAL(9,4)) AS Criteria_16_Exec           
        ,CAST((Criteria_17_Exec) AS DECIMAL(9,4)) AS Criteria_17_Exec 
    
        ,CAST((Criteria_1 + Criteria_1_Exec) AS DECIMAL(9,4)) AS Criteria_1_Total
        ,CAST((Criteria_2 + Criteria_2_Exec) AS DECIMAL(9,4)) AS Criteria_2_Total
        ,CAST((Criteria_3 + Criteria_3_Exec) AS DECIMAL(9,4)) AS Criteria_3_Total
        ,CAST((Criteria_4 + Criteria_4_Exec) AS DECIMAL(9,4)) AS Criteria_4_Total
        ,CAST((Criteria_5 + Criteria_5_Exec) AS DECIMAL(9,4)) AS Criteria_5_Total
        ,CAST((Criteria_6 + Criteria_6_Exec) AS DECIMAL(9,4)) AS Criteria_6_Total
        ,CAST((Criteria_7 + Criteria_7_Exec) AS DECIMAL(9,4)) AS Criteria_7_Total
        ,CAST((Criteria_8 + Criteria_8_Exec) AS DECIMAL(9,4)) AS Criteria_8_Total
        ,CAST((Criteria_9 + Criteria_9_Exec) AS DECIMAL(9,4)) AS Criteria_9_Total
        ,CAST((Criteria_10 + Criteria_10_Exec) AS DECIMAL(9,4)) AS Criteria_10_Total
        ,CAST((Criteria_11 + Criteria_11_Exec) AS DECIMAL(9,4)) AS Criteria_11_Total
        ,CAST((Criteria_12 + Criteria_12_Exec) AS DECIMAL(9,4)) AS Criteria_12_Total
        ,CAST((Criteria_13 + Criteria_13_Exec) AS DECIMAL(9,4)) AS Criteria_13_Total
        ,CAST((Criteria_14 + Criteria_14_Exec) AS DECIMAL(9,4)) AS Criteria_14_Total
        ,CAST((Criteria_15 + Criteria_15_Exec) AS DECIMAL(9,4)) AS Criteria_15_Total
        ,CAST((Criteria_16 + Criteria_16_Exec) AS DECIMAL(9,4)) AS Criteria_16_Total        
        ,CAST((Criteria_17 + Criteria_17_Exec) AS DECIMAL(9,4)) AS Criteria_17_Total 
    FROM vw_GetTabularScoringDataGeneric


-- grant execute on vw_GetTabularScoringDataGenericWithTotals to myUser
