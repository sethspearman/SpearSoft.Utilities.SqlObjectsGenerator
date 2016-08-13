

CREATE PROCEDURE [dbo].[GetDayScore1ScoreOnly] 
	@EventTurnID INT,
	@Result MONEY OUTPUT
AS 
    BEGIN

        DECLARE @DropHiLo BIT;
        SET @DropHiLo=dbo.fnGetDropHiLoConfigOption ()
        
        -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
            SET NOCOUNT ON ;

        

        SET @Result = dbo.fnGetDayScore1ScoreOnly ( @EventTurnID, @DropHiLo )
        RETURN @Result

    END


