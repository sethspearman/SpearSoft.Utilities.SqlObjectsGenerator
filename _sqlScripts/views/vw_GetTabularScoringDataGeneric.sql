

if object_id(dbo.vw_GetTabularScoringDataGeneric) is not null
	drop view dbo.vw_GetTabularScoringDataGeneric




CREATE	VIEW [dbo].[vw_GetTabularScoringDataGeneric] 
AS
SELECT 
		 dbo.fnGetJudgeAliasForReport(etj.EventTurnID, etj.JudgeID) [JudgeAlias]
		,j.FirstName + ' ' + j.LastName [JudgeName]
		,j.JudgeID [JudgeID]
		,[EventTurnID] [EventTurnID]
		,etj.[EventTurnJudgeID] [EventTurnJudgeID]
        ,0 [RawScore]  --dbo.fnGetEventTurnJudgeRawScore (etj.EventTurnJudgeID, Null) [RawScore]        
		,[Criteria_1]        = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_1')
        ,[Criteria_1_Exec]   = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_1')
		,[Criteria_2]        = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_2')
		,[Criteria_2_Exec]   = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_2')
		,[Criteria_3]        = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_3')
		,[Criteria_3_Exec]   = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_3')
		,[Criteria_4]        = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_4')
		,[Criteria_4_Exec]   = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_4')
		,[Criteria_5]        = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_5')
 		,[Criteria_5_Exec]   = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_5')
		,[Criteria_6]        = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_6')
		,[Criteria_6_Exec]   = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_6')
		,[Criteria_7]        = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_7')
		,[Criteria_7_Exec]   = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_7')
		,[Criteria_8]        = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_8')
		,[Criteria_8_Exec]   = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_8')
		,[Criteria_9]        = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_9')
		,[Criteria_9_Exec]   = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_9')
		,[Criteria_10]       = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_10')
		,[Criteria_10_Exec]  = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_10')
		,[Criteria_11]       = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_11')
		,[Criteria_11_Exec]  = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_11')
        ,[Criteria_12]       = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_12')
        ,[Criteria_12_Exec]  = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_12')
        ,[Criteria_13]       = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_13')
        ,[Criteria_13_Exec]  = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_13')
        ,[Criteria_14]       = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_14')
        ,[Criteria_14_Exec]  = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_14')
        ,[Criteria_15]       = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_15')
        ,[Criteria_15_Exec]  = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_15')
        ,[Criteria_16]       = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_16')
        ,[Criteria_16_Exec]  = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_16')
        ,[Criteria_17]       = (SELECT     Score FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_17')
        ,[Criteria_17_Exec]  = (SELECT Execution FROM tblEventTurnJudgeScores etjs INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID=jc.JudgingCriteriaID WHERE etjs.EventTurnJudgeID=etj.EventTurnJudgeID AND jc.PivotColumnMapping='Criteria_17')


        
    FROM tblEventTurnJudge etj
        INNER JOIN tblJudges j
            ON etj.JudgeID=j.JudgeID
    WHERE etj.JudgeID NOT IN (SELECT JudgeId FROM dbo.fnGetEventTurnDeductionJudgeIDs(etj.EventTurnID))


-- grant execute on vw_GetTabularScoringDataGeneric to myUser
