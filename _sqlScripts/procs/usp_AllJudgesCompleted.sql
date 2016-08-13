

CREATE PROCEDURE [dbo].[usp_AllJudgesCompleted]
    @EventTurnID INT,
	@AllJudgesCompleted bit OUTPUT
AS 
    BEGIN
	
		DECLARE @NumJudgesNotCompleted tinyint ; 
		DECLARE @NumPanelJudgesToScore tinyint;
		DECLARE @NumPanelJudgesPulled tinyint ;
        DECLARE @EventPanelID int ;
	        
		SET NOCOUNT ON ;
		IF EXISTS (SELECT 1 FROM tblEventTurnJudge WHERE EventTurnID = @EventTurnID)	
			BEGIN	
                SET @EventPanelID = dbo.fnGetEventPanelID(@EventTurnID)
                
				SET @NumPanelJudgesToScore = 
				(
					SELECT COUNT(*) 
					FROM tblEventPanelJudges
					WHERE EventPanelID=@EventPanelID
						AND PanelJudge = 1
				)
		        
				SET @NumPanelJudgesPulled = 
				(
					SELECT COUNT(*)
					FROM tblEventTurnJudge
					WHERE EventTurnID = @EventTurnID 
						AND JudgeID IN 
						(
							SELECT JudgeID 
							FROM tblEventPanelJudges 					
							WHERE EventPanelID=@EventPanelID 
								AND PanelJudge = 1
						)
				)
				IF @NumPanelJudgesToScore = @NumPanelJudgesPulled
					--ALL JUDGES HAVE PULLED SCORES...NOW JUST VERIFY THEY ARE COMPLETED.
					BEGIN
						SET @NumJudgesNotCompleted = (SELECT COUNT(*) FROM tblEventTurnJudge WHERE EventTurnID=@EventTurnID AND ISNULL(Completed,0)=0)
						SET @AllJudgesCompleted = CASE WHEN @NumJudgesNotCompleted>0 THEN 0 ELSE 1 END
					END
				ELSE
					SET @AllJudgesCompleted = 0
			END
        ELSE
            SET @AllJudgesCompleted = 0
    END


