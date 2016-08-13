

CREATE FUNCTION [dbo].[fnGetLevelMaxValue2] ( @LevelID int, @EventPanelTypeID int, @EventTurnID int )
RETURNS money
AS BEGIN

    DECLARE @return money ;
    
    IF @EventPanelTypeID Is Null
        SET @EventPanelTypeID = 
                                (
                                    SELECT ep.EventPanelTypeID 
                                    FROM tblEventTurns et 
                                    INNER JOIN tblEventPanels ep 
                                        ON et.EventPanelID = ep.EventPanelID
                                    WHERE et.EventTurnID = @EventTurnID
                                )
        

    SELECT @return = sclmv.MaxValue 
    FROM tblScoresheetLevelMaxValues sclmv 
    WHERE sclmv.LevelID=@LevelID 
        AND sclmv.EventPanelTypeID = @EventPanelTypeID

	return ISNULL(@return,0)

   END


