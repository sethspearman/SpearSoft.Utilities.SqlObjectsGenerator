

CREATE FUNCTION [dbo].[fnIsWorlds] ( @EventTurnID INT )
RETURNS BIT
AS  BEGIN
    
    DECLARE @IsWorlds BIT ;
    
    SELECT @IsWorlds = e.IsWorlds
    FROM tblEventTurns et 
        INNER JOIN tblRegistrationDivisions rd ON et.RegistrationDivisionID = rd.RegistrationDivisionID
        INNER JOIN tblRegistrations r ON rd.RegistrationID = r.RegistrationID
        INNER JOIN tblEvents e ON r.EventID = e.EventID
    WHERE et.EventTurnID = @EventTurnID

    RETURN @IsWorlds ;
    END


