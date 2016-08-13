

CREATE FUNCTION [dbo].[fnGetEventTurnID]
    (
      @RegistrationDivisionID INT,
      @EventDay TINYINT
    )
RETURNS INT
AS BEGIN

	--DECLARE variable to hold information on EventTurnID, initialized by default to NULL value
    DECLARE @EventTurnID INT ;

	-- Get eventturn id from database into temp variable @EventTurnID.
    SELECT  @EventTurnID = ets.EventTurnID
    FROM    dbo.tblEventTurns AS ets
    WHERE   RegistrationDivisionID = @RegistrationDivisionID
            AND Day1or2 = @EventDay ;


	--Return eventturn id or 0 if null
    RETURN ISNULL(@EventTurnID, 0) ;
	
   END


