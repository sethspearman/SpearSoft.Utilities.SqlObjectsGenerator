

CREATE PROCEDURE [dbo].[usp_ValidateScoresNotNull]
    @EventTurnJudgeID INT,
    @HasNulls BIT OUTPUT
AS 
    BEGIN
        IF EXISTS (SELECT 1 FROM tblEventTurnJudgeScores WHERE EventTurnJudgeID = @EventTurnJudgeID AND ((Score Is Null) OR (Execution Is Null)) )
            SET @HasNulls = 1 ;
        ELSE
            SET @HasNulls = 0 ;
    END


