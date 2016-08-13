

CREATE PROCEDURE [dbo].[GetDayScore2RawScore]
    @RegistrationDivisionID INT,
    @EventDay TINYINT,
	@Result MONEY OUTPUT
AS 
    BEGIN

	DECLARE @DropHiLo BIT;
	SET @DropHiLo=dbo.fnGetDropHiLoConfigOption ()
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--DECLARE variable to hold information on EventTurnID, initialized by default to NULL value
        DECLARE @EventTurnID INT ;

	-- Get the evn turn id for the given parameters
        SET  @EventTurnID = dbo.fnGetEventTurnID(@RegistrationDivisionID,
                                                    @EventDay) ;

	--use the eventturn id to call  GetDayScore1ScoreOnly stored proc to get the score only value.
        EXEC dbo.GetDayScore1RawScore @EventTurnID, @Result = @Result OUTPUT ;
		SET @RESULT=ISNULL(@Result,0)
		RETURN
		
    END


