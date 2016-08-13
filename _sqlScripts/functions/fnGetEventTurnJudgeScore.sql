

CREATE FUNCTION [dbo].[fnGetEventTurnJudgeScore] ( @EventTurnJudgeID INT )
RETURNS money
AS BEGIN

    DECLARE @SumScore money ;
	DECLARE @LevelID int ;
    DECLARE @LevelMaxValue MONEY ;  
    DECLARE @EventTurnID int ;
    
    SET @EventTurnID = (SELECT EventTurnID FROM tblEventTurnJudge WHERE EventTurnJudgeID=@EventTurnJudgeID)
       
    SELECT @LevelID = dbo.fnGetLevelID (Null, Null, @EventTurnJudgeID)

    SELECT @LevelMaxValue = dbo.fnGetLevelMaxValue2 ( @LevelID, Null, @EventTurnID )
    IF @LevelMaxValue=0
        RETURN 0
        
    SET @SumScore = dbo.fnGetEventTurnJudgeRawScore ( @EventTurnJudgeID, @LevelID ) ;
	--Final calculation  of 
    RETURN (@SumScore/@LevelMaxValue) * 100 ;
   END


