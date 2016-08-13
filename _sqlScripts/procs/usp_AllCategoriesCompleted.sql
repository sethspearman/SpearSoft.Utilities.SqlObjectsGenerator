

if object_id(dbo.usp_AllCategoriesCompleted) is not null
	drop procedure dbo.usp_AllCategoriesCompleted




CREATE PROCEDURE [dbo].[usp_AllCategoriesCompleted]
    @EventTurnID INT,
	@AllCategoriesCompleted bit OUTPUT
AS 
    BEGIN

	DECLARE @NumJudgesNotCompleted tinyint ; 
    DECLARE @NumCategoriesToScore tinyint;
    DECLARE @NumCategoriesPulled tinyint ;
    DECLARE @LevelId INT ;

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;
        
        SET @LevelId = (SELECT dbo.fnGetLevelID (null,@EventTurnId, null) );
        
        SET @NumCategoriesToScore = 
            (
                SELECT COUNT(DISTINCT JudgingCriteriaID) 
                FROM tblEventPanelCategoryJudges epcj
                    INNER JOIN tblEventPanels ep ON epcj.EventPanelID = ep.EventPanelID
                WHERE epcj.EventPanelID=dbo.fnGetEventPanelID(@EventTurnID) 
                    AND ep.EventPanelTypeID=dbo.fnGetEventPanelTypeID(@EventTurnID)
                    AND epcj.JudgingCriteriaID IN 
                        (SELECT DISTINCT JudgingCriteriaID
                            FROM tblJudgingCriteriaMaxScores jcms
                            WHERE epcj.JudgingCriteriaID = jcms.JudgingCriteriaID
                                AND jcms.MaxValue <> 0
                                AND jcms.LevelId=@LevelId
                        )
            )
        
        SET @NumCategoriesPulled = 
            (
                SELECT COUNT(DISTINCT JudgingCriteriaID)
                FROM tblEventTurnJudgeStartValues
                WHERE EventTurnJudgeID IN 
                    (
                        SELECT EventTurnJudgeID 
                        FROM tblEventTurnJudge 
                        WHERE EventTurnID=@EventTurnID
                    )
            )
            
        IF (@NumCategoriesToScore>0) AND (@NumCategoriesPulled >= @NumCategoriesToScore)
            BEGIN
                SET @NumJudgesNotCompleted = 
                    (
                        SELECT COUNT(*) 
                        FROM tblEventTurnJudgeStartValues 
                        WHERE EventTurnJudgeID IN 
                            (
                                SELECT EventTurnJudgeID 
                                FROM tblEventTurnJudge 
                                WHERE EventTurnID=@EventTurnID
                            )
                        AND LockedIn=0
                    )
                SET @AllCategoriesCompleted = CASE WHEN @NumJudgesNotCompleted>0 THEN 0 ELSE 1 END 
            END
        ELSE
            SET @AllCategoriesCompleted = 0

            SET @AllCategoriesCompleted = ISNULL(@AllCategoriesCompleted,0)
            
    END



-- grant execute on usp_AllCategoriesCompleted to myUser
