
 
CREATE	VIEW [dbo].[tblScoringCriteriaTypeLevels] 
AS
	
SELECT DISTINCT jc.ScoringCriteriaTypeID, jcms.LevelID 
FROM tblJudgingCriteria jc
    INNER JOIN tblJudgingCriteriaMaxScores jcms
        ON jc.JudgingCriteriaID = jcms.JudgingCriteriaID
        

