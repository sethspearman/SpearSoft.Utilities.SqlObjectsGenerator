

if object_id(dbo.usp_AllJudgesScoresPulled) is not null
	drop procedure dbo.usp_AllJudgesScoresPulled




CREATE PROCEDURE [dbo].[usp_AllJudgesScoresPulled]
    @EventTurnID INT,
	@AllJudgesScoresPulled bit OUTPUT
AS 
    BEGIN
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
					WHERE EventPanelID= @EventPanelID
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
                    SET @AllJudgesScoresPulled = 1
				ELSE
					SET @AllJudgesScoresPulled = 0
			END
        ELSE
            SET @AllJudgesScoresPulled = 0
    END



-- grant execute on usp_AllJudgesScoresPulled to myUser
