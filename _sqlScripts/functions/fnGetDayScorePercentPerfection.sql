

CREATE FUNCTION [dbo].[fnGetDayScorePercentPerfection] ( @EventTurnID INT, @DropHiLo bit)
RETURNS MONEY
AS  BEGIN
 
    DECLARE @Score decimal(9,5) ;
   	DECLARE @LevelID int ;
    DECLARE @LevelMaxValue MONEY ;   
       
    SELECT @LevelID = dbo.fnGetLevelID (Null, @EventTurnID, Null)

    SELECT @LevelMaxValue = dbo.fnGetLevelMaxValue2 ( @LevelID, Null, @EventTurnID )
    IF @LevelMaxValue=0
        RETURN 0
    
    SET @Score = dbo.fnGetDayScore1( @EventTurnID, @DropHiLo )  ;
    SET @Score = (@Score/@LevelMaxValue) * 100
    
	--Final calculation  of 
    RETURN CAST(@Score AS MONEY) ;
    END


