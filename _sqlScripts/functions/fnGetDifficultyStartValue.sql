

CREATE FUNCTION [dbo].[fnGetDifficultyStartValue]
    (
      @EventTurnJudgeID INT,
      @JudgingCriteriaID INT,
      @JudgeID INT
    )
RETURNS SMALLINT
AS BEGIN

    DECLARE @EventTurnID INT ;
    DECLARE @RegistrationDivisionID INT ; 
    DECLARE @StartValue SMALLINT ;
    DECLARE @Day1Or2 TINYINT ;
    
    DECLARE @HiddenJudgingCriteria BIT ;
    
    SELECT  @EventTurnID = et.EventTurnID,
            @Day1Or2 = et.Day1or2,
            @RegistrationDivisionID=et.RegistrationDivisionID
    FROM tblEventTurns et
        INNER JOIN tblEventTurnJudge etj 
            ON et.EventTurnID = etj.EventTurnID
    WHERE etj.EventTurnJudgeID=@EventTurnJudgeID
    
    SET @HiddenJudgingCriteria = (SELECT HideFromJudges FROM tblJudgingCriteria WHERE JudgingCriteriaID=@JudgingCriteriaID)
    
    IF @Day1Or2 = 1 AND @HiddenJudgingCriteria = 0
        SET @StartValue = Null
    ELSE IF @Day1Or2 = 1 AND @HiddenJudgingCriteria = 1
        SET @StartValue = 1
    ELSE
        BEGIN
            SET @EventTurnID = dbo.fnGetEventTurnID (@RegistrationDivisionID,1)
            
            SELECT @StartValue  = etjsv.DifficultyToggle
            FROM tblEventTurnJudge etj
                INNER JOIN tblEventTurnJudgeStartValues etjsv
                    ON etj.EventTurnJudgeID = etjsv.EventTurnJudgeID
            WHERE etj.EventTurnID = @EventTurnID 
                AND etj.JudgeID = @JudgeID
                AND etjsv.JudgingCriteriaID = @JudgingCriteriaID
        END
    
    RETURN @StartValue ;
	
   END


