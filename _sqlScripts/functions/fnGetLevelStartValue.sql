

CREATE FUNCTION [dbo].[fnGetLevelStartValue]
    (
      @EventTurnJudgeID INT,
      @JudgingCriteriaID INT,
      @JudgeID INT,
      @LevelID INT
    )
RETURNS SMALLINT
AS BEGIN

    DECLARE @EventTurnID INT ;
    DECLARE @RegistrationDivisionID INT ; 
    DECLARE @result INT ;
    DECLARE @Day1Or2 TINYINT ;
    
    SELECT  @EventTurnID = et.EventTurnID,
            @Day1Or2 = et.Day1or2,
            @RegistrationDivisionID=et.RegistrationDivisionID
    FROM tblEventTurns et
        INNER JOIN tblEventTurnJudge etj 
            ON et.EventTurnID = etj.EventTurnID
    WHERE etj.EventTurnJudgeID=@EventTurnJudgeID
    
    IF @Day1Or2 = 1
        SET @result = @LevelID
    ELSE
        BEGIN
            SET @EventTurnID = dbo.fnGetEventTurnID (@RegistrationDivisionID,1)
        
            SELECT @result  = etjsv.LevelID
            FROM tblEventTurnJudge etj
                INNER JOIN tblEventTurnJudgeStartValues etjsv
                    ON etj.EventTurnJudgeID = etjsv.EventTurnJudgeID
            WHERE etj.EventTurnID = @EventTurnID 
                AND etj.JudgeID = @JudgeID
                AND etjsv.JudgingCriteriaID = @JudgingCriteriaID
        END
    
    RETURN ISNull(@result,@LevelID) ;
	
   END


