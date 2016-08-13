

CREATE FUNCTION [dbo].[fnGetEventScorePercentPerfection] (       
                        @RegistrationDivisionID INT,
                        @EventDay TINYINT,
                        @Day1Weight MONEY,
                        @Day2Weight MONEY,
                        @DropHiLo BIT)
RETURNS MONEY
AS  BEGIN
 
    DECLARE @Score decimal(9,5) ;
   	DECLARE @LevelID int ;
    DECLARE @LevelMaxValue MONEY ;   
       
    DECLARE @EventTurnID INT;
    
    SET @EventTurnID = dbo.fnGetEventTurnID(@RegistrationDivisionID,@EventDay)
       
    SELECT @LevelID = dbo.fnGetLevelID (Null, @EventTurnID, Null)

    SELECT @LevelMaxValue = dbo.fnGetLevelMaxValue2 ( @LevelID, Null, @EventTurnID )
    IF @LevelMaxValue=0
        RETURN 0
        
    SET @Score = dbo.fnGetEventScore (  @RegistrationDivisionID, @EventDay,@Day1Weight,@Day2Weight,@DropHiLo );
    SET @Score = (@Score/@LevelMaxValue) * 100
    
	--Final calculation  of 
    RETURN CAST(@Score  AS MONEY) ;
    END


