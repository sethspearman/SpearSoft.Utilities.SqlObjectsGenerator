

if object_id(dbo.tblScoringCriteriaTypeLevels) is not null
	drop view dbo.tblScoringCriteriaTypeLevels



 
CREATE	VIEW [dbo].[tblScoringCriteriaTypeLevels] 
AS
	
SELECT DISTINCT jc.ScoringCriteriaTypeID, jcms.LevelID 
FROM tblJudgingCriteria jc
    INNER JOIN tblJudgingCriteriaMaxScores jcms
        ON jc.JudgingCriteriaID = jcms.JudgingCriteriaID
        


-- grant execute on tblScoringCriteriaTypeLevels to myUser
