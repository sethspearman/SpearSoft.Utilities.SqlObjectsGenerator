

if object_id(dbo.getScoringCriteriaLevelMaxValue) is not null
	drop procedure dbo.getScoringCriteriaLevelMaxValue




CREATE PROCEDURE [dbo].[getScoringCriteriaLevelMaxValue]
    @EventTurnJudgeID INT,
	@JudgingCriteriaID INT,
    @Result MONEY OUTPUT
AS 
    BEGIN
    
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;
				
        SET @Result = dbo.fnGetScoringCriteriaLevelMaxValue (@EventTurnJudgeID, @JudgingCriteriaID)

    END



-- grant execute on getScoringCriteriaLevelMaxValue to myUser
