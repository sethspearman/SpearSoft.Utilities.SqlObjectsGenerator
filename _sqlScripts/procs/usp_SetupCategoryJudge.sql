

if object_id(dbo.usp_SetupCategoryJudge) is not null
	drop procedure dbo.usp_SetupCategoryJudge




CREATE PROCEDURE [dbo].[usp_SetupCategoryJudge]
    @EventPanelID INT,
    @JudgeID INT,
	@JudgingCriteriaID INT,
    @remove bit
AS 
    BEGIN
		SET @remove=ISNULL(@remove,0)
        
        IF @remove=1
            DELETE FROM tblEventPanelCategoryJudges WHERE EventPanelID=@EventPanelID AND JudgeID=@JudgeID AND JudgingCriteriaID=@JudgingCriteriaID
        ELSE
            IF NOT EXISTS(SELECT 1 FROM tblEventPanelCategoryJudges WHERE EventPanelID=@EventPanelID AND JudgeID=@JudgeID AND JudgingCriteriaID=@JudgingCriteriaID)
                INSERT INTO tblEventPanelCategoryJudges (EventPanelID,JudgeID,JudgingCriteriaID) VALUES (@EventPanelID,@JudgeID,@JudgingCriteriaID) 
    END



-- grant execute on usp_SetupCategoryJudge to myUser
