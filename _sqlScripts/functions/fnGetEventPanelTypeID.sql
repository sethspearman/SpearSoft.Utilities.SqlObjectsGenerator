

CREATE FUNCTION [dbo].[fnGetEventPanelTypeID]
    (
      @EventTurnID INT
    )
RETURNS INT
AS BEGIN

	--DECLARE variable to hold information on EventTurnID, initialized by default to NULL value
    DECLARE @EventPanelTypeID INT ;

            SELECT @EventPanelTypeID = d.EventPanelTypeID
            FROM tblEventTurns et 
                inner join tblRegistrationDivisions rd 
                    ON et.RegistrationDivisionID=rd.RegistrationDivisionID
                inner join tblDivisions d
                    on d.DivisionID=rd.DivisionID
			WHERE et.EventTurnID=@EventTurnID 

	--Return eventturn id or 0 if null
    RETURN ISNULL(@EventPanelTypeID, 0) ;
	
   END


