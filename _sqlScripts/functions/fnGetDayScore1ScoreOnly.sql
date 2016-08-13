

CREATE FUNCTION [dbo].[fnGetDayScore1ScoreOnly] ( @EventTurnID INT, @DropHiLo bit)
RETURNS MONEY
AS  BEGIN
    /*
        FOR NOW JUST CALL INTO THE RAW SCORE FUNCTION.  If later the definition of final score changes (to % Perfection for example) then you will not have to create a new one.  Also is lower impact to keep this one in tact.
        */    

    RETURN dbo.fnGetDayScore1RawScoreOnly ( @EventTurnID, @DropHiLo) ;
    END


