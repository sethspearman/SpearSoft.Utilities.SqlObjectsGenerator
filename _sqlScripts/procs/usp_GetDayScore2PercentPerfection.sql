

CREATE PROCEDURE [dbo].[usp_GetDayScore2PercentPerfection]
    @RegistrationDivisionID INT,
    @EventDay TINYINT,
	@Result MONEY OUTPUT
AS 
    BEGIN

	DECLARE @DropHiLo BIT;
	SET @DropHiLo=dbo.fnGetDropHiLoConfigOption()

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--Call function to get score value.
      SET  @Result = [dbo].[fnGetDayScorePercentPerfection](dbo.fnGetEventTurnID(@RegistrationDivisionID, @EventDay), @DropHiLo) ; 
	  SET  @Result = ISNULL(@Result, 0 )	
      RETURN @Result
    END


