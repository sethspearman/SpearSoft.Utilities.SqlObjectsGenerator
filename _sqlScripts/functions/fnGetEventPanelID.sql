

CREATE FUNCTION [dbo].[fnGetEventPanelID]
    (
      @EventTurnID INT
    )
RETURNS INT
AS BEGIN

	--DECLARE variable to hold information on EventTurnID, initialized by default to NULL value
    DECLARE @EventPanelID INT ;

            SELECT @EventPanelID = et.EventPanelID
            FROM tblEventTurns et 
			WHERE et.EventTurnID=@EventTurnID 

	--Return eventturn id or 0 if null
    RETURN ISNULL(@EventPanelID, 0) ;
	
   END


