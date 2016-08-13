

if object_id(dbo.usp_GetScoresheetLevelMaxValue) is not null
	drop procedure dbo.usp_GetScoresheetLevelMaxValue




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



-- grant execute on usp_GetScoresheetLevelMaxValue to myUser
