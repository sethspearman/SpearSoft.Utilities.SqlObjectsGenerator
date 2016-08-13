

CREATE FUNCTION [dbo].[fnGetDayScore1] ( @EventTurnID INT, @DropHiLo BIT )
RETURNS MONEY
AS BEGIN

    DECLARE @Score MONEY ;
    DECLARE @Deductions MONEY ;
                
    SELECT @Score = dbo.fnGetDayScore1RawScoreOnly ( @EventTurnID, @DropHiLo ) 

	--Get Deductions from Deductions judge
    SELECT  @Deductions = dbo.fnGetEventTurnDeduction ( @EventTurnID ) ;
    
	--Final calculation  of 
    RETURN ISNULL(@Score,0) + ISNULL(@Deductions, 0) ;
   END


