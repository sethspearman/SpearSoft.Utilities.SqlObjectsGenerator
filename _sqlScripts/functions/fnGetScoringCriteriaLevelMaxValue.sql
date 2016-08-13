

CREATE FUNCTION [dbo].[fnGetScoringCriteriaLevelMaxValue] 
    (   
        @EventTurnJudgeID INT,
        @JudgingCriteriaID INT
    )
RETURNS MONEY
AS 
    BEGIN
        DECLARE @LevelID INT;
        DECLARE @IncludeExecution bit ;
        DECLARE @Result MONEY ;
        DECLARE @TechResult MONEY ; 
        
        SET @LevelID = dbo.fnGetLevelID ( null, null, @EventTurnJudgeID ) ;

        SELECT	@Result = jcms.MaxValue,
                @TechResult = CASE jc.IncludeExecution  WHEN 1 THEN jcms.ExecutionTopRange ELSE 0 END,
                @IncludeExecution=jc.IncludeExecution 
        FROM tblJudgingCriteria jc 
            INNER JOIN tblJudgingCriteriaMaxScores jcms 
                ON jc.JudgingCriteriaID=jcms.JudgingCriteriaID
        WHERE jcms.LevelID=@LevelID 
            AND jcms.JudgingCriteriaID=@JudgingCriteriaID
            AND jcms.ToggleValue=1
                
        SET @Result = ISNULL(@Result,0) + CASE WHEN @Result<>0 THEN @TechResult ELSE 0 END
        
        RETURN @Result
   END


