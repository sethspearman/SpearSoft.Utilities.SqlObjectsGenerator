

if object_id(dbo.usp_ValidateScoresNotNull) is not null
	drop procedure dbo.usp_ValidateScoresNotNull




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



-- grant execute on usp_ValidateScoresNotNull to myUser
