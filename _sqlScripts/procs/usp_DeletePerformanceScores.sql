

CREATE PROCEDURE [dbo].[usp_DeletePerformanceScores]
	@EventTurnID INT,
    @Result MONEY OUTPUT
AS 
    BEGIN
    
        SET @Result = 1 ;
		
        DECLARE @RegistrationDivisionID INT;
        
		BEGIN TRANSACTION
        --run the next 5 statements to just clear scoring data.
        BEGIN TRY
            delete from tblEventTurnJudgeScores      WHERE EventTurnJudgeID IN (SELECT EventTurnJudgeID FROM tblEventTurnJudge WHERE EventTurnID=@EventTurnID)
            delete from tblEventTurnJudgeDeductions  WHERE EventTurnJudgeID IN (SELECT EventTurnJudgeID FROM tblEventTurnJudge WHERE EventTurnID=@EventTurnID)
            delete from tblEventTurnJudgeComments    WHERE EventTurnJudgeID IN (SELECT EventTurnJudgeID FROM tblEventTurnJudge WHERE EventTurnID=@EventTurnID)
            delete from tblEventTurnJudgeStartValues WHERE EventTurnJudgeID IN (SELECT EventTurnJudgeID FROM tblEventTurnJudge WHERE EventTurnID=@EventTurnID)   
            delete from tblEventTurnJudge            WHERE EventTurnID=@EventTurnID
            
            delete from usys_tblPivotedScoringData   WHERE EventTurnID=@EventTurnID
            SET @RegistrationDivisionID = (SELECT ISNULL(RegistrationDivisionID,0) FROM tblEventTurns WHERE EventTurnID=@EventTurnID)
            delete from tblEventTurns                WHERE EventTurnID=@EventTurnID
            delete from tblRegistrationDivisions     WHERE RegistrationDivisionID=@RegistrationDivisionID
            
        END TRY
        BEGIN CATCH
			ROLLBACK TRANSACTION
            SET @Result = 0 ;
            RETURN
        END CATCH
        
        SET @Result=1 ;
        COMMIT TRANSACTION
        RETURN
        
    END


