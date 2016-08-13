

CREATE	VIEW [dbo].[vw_PerformanceScoreAverages] 
AS
SELECT etj.EventTurnID
    ,etjs.JudgingCriteriaID JudgingCriteriaID
    ,jc.ScoringCategoryID ScoringCategoryID
    ,dbo.fnGetScoringCriteriaLevelMaxValue(MAX(etj.EventTurnJudgeID), etjs.JudgingCriteriaID) MaxValue
    ,dbo.fnGetPerformanceCategoryComments(etj.EventTurnID, jc.ScoringCategoryID) JudgeComments
    ,(CAST(MAX(etjs.MinValue) AS VARCHAR(10)) + ' - ' + CAST(MAX(etjs.MaxValue) AS VARCHAR(10))) DifficultyRange
    ,AVG(cast(etjs.SCORE AS DECIMAL(9,4))) AvgDifficultScore
    ,AVG(CAST(etjs.EXECUTION AS DECIMAL(9,4))) AvgTechniqueScore
    ,(AVG(cast(etjs.SCORE AS DECIMAL(9,4))) + AVG(CAST(etjs.EXECUTION AS DECIMAL(9,4)))) TotalCriteriaSCore
FROM tblEventTurnJudgeScores etjs
    INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID = jc.JudgingCriteriaID
    INNER JOIN tblEventTurnJudge etj ON etj.EventTurnJudgeID = etjs.EventTurnJudgeID 
WHERE etj.EventTurnJudgeID  IN
    (SELECT EventTurnJudgeID FROM tblEventTurnJudge etj 
        WHERE JudgeID IN 
            (
                SELECT DISTINCT JudgeID
                FROM tblEventPanelJudgeCategories epjc
                WHERE epjc.EventPanelID = dbo.fnGetEventPanelID(etj.EventTurnID)
            )
    )
GROUP BY etj.EventTurnID, etjs.JudgingCriteriaID, jc.ScoringCategoryID 
		 

