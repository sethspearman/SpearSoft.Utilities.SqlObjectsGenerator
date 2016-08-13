

if object_id(dbo.usp_CancelPerformance) is not null
	drop procedure dbo.usp_CancelPerformance




CREATE PROCEDURE [dbo].[usp_CancelPerformance]
    @EventTurnID INT,
	@Result MONEY OUTPUT
AS 
    BEGIN
			SET @EventTurnID = ISNULL(@EventTurnID, 0)

			DELETE FROM tblEventTurnJudgeScores 
				WHERE EventTurnJudgeID IN 
						(
							SELECT EventTurnJudgeID 
							FROM tblEventTurnJudge	
							WHERE EventTurnID=@EventTurnID						
						)

			DELETE FROM tblEventTurnJudgeDeductions
				WHERE EventTurnJudgeID IN 
						(
							SELECT EventTurnJudgeID 
							FROM tblEventTurnJudge	
							WHERE EventTurnID=@EventTurnID						
						)

			DELETE FROM tblEventTurnJudgeComments 
				WHERE EventTurnJudgeID IN 
						(
							SELECT EventTurnJudgeID 
							FROM tblEventTurnJudge	
							WHERE EventTurnID=@EventTurnID						
						)

			DELETE FROM tblEventTurnJudgeStartValues
				WHERE EventTurnJudgeID IN 
						(
							SELECT EventTurnJudgeID 
							FROM tblEventTurnJudge	
							WHERE EventTurnID=@EventTurnID						
						)

			DELETE FROM tblEventTurnJudge WHERE EventTurnID=@EventTurnID

			UPDATE tblEventTurns SET Completed=0 WHERE EventTurnID=@EventTurnID
			
			SET @Result = 1

			RETURN @Result

    END



-- grant execute on usp_CancelPerformance to myUser
