

CREATE PROCEDURE [dbo].[GetDayScore1RawScore] 
	@EventTurnID INT,
	@Result MONEY OUTPUT
AS 
    BEGIN

	DECLARE @DropHiLo BIT;
    DECLARE @AvgScore MONEY ;
    
	SET @DropHiLo=dbo.fnGetDropHiLoConfigOption ()
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

        SET @AvgScore = dbo.fnGetDayScore1RawScoreOnly ( @EventTurnID, @DropHiLo )

		SET @Result = @AvgScore ;
        RETURN @Result

    END


