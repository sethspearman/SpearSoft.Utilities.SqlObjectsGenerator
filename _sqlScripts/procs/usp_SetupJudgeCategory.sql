

CREATE PROCEDURE [dbo].[usp_SetupJudgeCategory]
    @EventPanelID INT,
    @JudgeID INT,
	@JudgingCriteriaID INT,
    @remove bit
AS 
    BEGIN
		SET @remove=ISNULL(@remove,0)
        
        IF @remove=1
            DELETE FROM tblEventPanelJudgeCategories WHERE EventPanelID=@EventPanelID AND JudgeID=@JudgeID AND JudgingCriteriaID=@JudgingCriteriaID
        ELSE
            IF NOT EXISTS(SELECT 1 FROM tblEventPanelJudgeCategories WHERE EventPanelID=@EventPanelID AND JudgeID=@JudgeID AND JudgingCriteriaID=@JudgingCriteriaID)
                INSERT INTO tblEventPanelJudgeCategories (EventPanelID,JudgeID,JudgingCriteriaID) VALUES (@EventPanelID,@JudgeID,@JudgingCriteriaID) 
    END


