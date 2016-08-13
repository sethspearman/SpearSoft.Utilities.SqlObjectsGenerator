

CREATE FUNCTION [dbo].[fnGetDifficultyScore] 
    (   @JudgingCriteriaID INT,
        @EventTurnJudgeID INT 
    )
RETURNS MONEY
AS BEGIN

    DECLARE @Result MONEY ;

    SELECT  @Result = cast(ISNULL(etjs.Score,0) as MONEY)
    FROM    dbo.tblEventTurnJudgeScores AS etjs
    WHERE   etjs.JudgingCriteriaID = @JudgingCriteriaID
        AND etjs.EventTurnJudgeID = @EventTurnJudgeID
        
    RETURN @Result ;
   END


