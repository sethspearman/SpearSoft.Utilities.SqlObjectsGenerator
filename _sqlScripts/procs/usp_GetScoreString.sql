

if object_id(dbo.usp_GetScoreString) is not null
	drop procedure dbo.usp_GetScoreString




CREATE PROCEDURE [dbo].[usp_GetScoreString]
    @JudgingCriteriaID INT,
    @EventTurnJudgeID INT,
	--DECLARE variable to hold information on @Result, initialized by default to NULL value
	@Result nvarchar(20) OUTPUT
AS 
    BEGIN
        SET  @Result = CAST(ISNULL(dbo.fnGetDifficultyScore ( @JudgingCriteriaID, @EventTurnJudgeID ),0) AS NVARCHAR(20)) 
		SET  @Result = @Result + ' + ' + CAST(ISNULL(dbo.fnGetExecutionScore ( @JudgingCriteriaID, @EventTurnJudgeID ), 0) AS NVARCHAR(20) )  ;
		RETURN
    END



-- grant execute on usp_GetScoreString to myUser
