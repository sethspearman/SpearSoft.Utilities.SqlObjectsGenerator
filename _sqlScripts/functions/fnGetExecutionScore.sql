

CREATE FUNCTION [dbo].[fnGetExecutionScore] 
    (   @JudgingCriteriaID INT,
        @EventTurnJudgeID INT 
    )
RETURNS MONEY
AS BEGIN

    DECLARE @Result MONEY ;

    SELECT  @Result = cast(etjs.Execution as MONEY)
    FROM    dbo.tblEventTurnJudgeScores AS etjs
    WHERE   etjs.JudgingCriteriaID = @JudgingCriteriaID
        AND etjs.EventTurnJudgeID = @EventTurnJudgeID
        
    RETURN @Result ;
   END


