

CREATE FUNCTION [dbo].[fnGetLevelID] ( @LevelID int, @EventTurnID int, @EventTurnJudgeID int )
RETURNS int
AS BEGIN

    DECLARE @return int ;

	SET @LevelID = ISNULL(@LevelID,-1)

	IF @LevelID = -1 
		BEGIN
			SET @EventTurnID = ISNULL(@EventTurnID,0)
			IF @EventTurnID = 0
				SELECT @EventTurnID = ISNULL(( SELECT TOP 1 EventTurnID FROM tblEventTurnJudge WHERE EventTurnJudgeID=ISNULL(@EventTurnJudgeID,0) ),0)

				SELECT @LevelID = ISNULL(d.[Level],-1) FROM tblDivisions d 
                    INNER JOIN tblRegistrationDivisions rd ON d.DivisionID=rd.DivisionID 
                    INNER JOIN tblEventTurns et ON rd.RegistrationDivisionID=et.RegistrationDivisionID
                WHERE et.EventTurnID=@EventTurnID
		END

	SET @return = @LevelID
	return @return

   END


