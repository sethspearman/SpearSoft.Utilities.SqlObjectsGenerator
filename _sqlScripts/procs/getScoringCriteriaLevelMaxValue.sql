

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


