

CREATE PROCEDURE [dbo].[usp_GetDayScore1PercentPerfection] 
	@EventTurnID INT,
	@Result MONEY OUTPUT
AS 
    BEGIN

	DECLARE @DropHiLo BIT;
    DECLARE @AvgScore MONEY ;
    
	SET @DropHiLo=dbo.fnGetDropHiLoConfigOption ()
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

        SET @AvgScore = dbo.fnGetDayScorePercentPerfection ( @EventTurnID, @DropHiLo )

		SET @Result = ISNULL(@AvgScore,0) ;
        RETURN @Result

    END


