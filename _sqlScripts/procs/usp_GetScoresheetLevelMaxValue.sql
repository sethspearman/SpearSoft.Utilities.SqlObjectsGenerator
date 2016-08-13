

CREATE PROCEDURE [dbo].[usp_GetScoresheetLevelMaxValue]
    @LevelID INT,
    @EventTurnID INT,
	--DECLARE variable to hold information on @Result, initialized by default to NULL value
	@Result MONEY OUTPUT
AS 
    BEGIN
        
        SELECT @Result = dbo.fnGetLevelMaxValue2 ( @LevelID, Null, @EventTurnID )
        RETURN
    
    END


