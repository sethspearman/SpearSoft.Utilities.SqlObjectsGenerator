

CREATE PROCEDURE [dbo].[usp_SetPerformanceCriteriaScoreAllJudges]
    @EventTurnID INT,
    @JudgingCriteriaID INT,
    @Score MONEY
AS 
    BEGIN

        UPDATE tblEventTurnJudgeScores SET Score=@Score, MinValue=0, MaxValue=11 WHERE EventTurnJudgeScoreID IN 
            (
                SELECT EventTurnJudgeScoreID FROM tblEventTurnJudgeScores etjs
                    INNER JOIN tblEventTurnJudge etj ON etjs.EventTurnJudgeID = etj.EventTurnJudgeID
                WHERE etj.EventTurnID = @EventTurnID 
                    AND etjs.JudgingCriteriaID = @JudgingCriteriaID
            )
    
    
    END

