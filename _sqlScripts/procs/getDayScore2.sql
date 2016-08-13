

if object_id(dbo.getDayScore2) is not null
	drop procedure dbo.getDayScore2




CREATE PROCEDURE [dbo].[getDayScore2]
    @RegistrationDivisionID INT,
    @EventDay TINYINT,
	@Result MONEY OUTPUT
AS 
    BEGIN

	DECLARE @DropHiLo BIT;
	SET @DropHiLo=dbo.fnGetDropHiLoConfigOption ()

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--Call function to get score value.
        SELECT  @Result = ISNULL([dbo].[fnGetDayScore1](dbo.fnGetEventTurnID(@RegistrationDivisionID, @EventDay), @DropHiLo),0) ; 

    END



-- grant execute on getDayScore2 to myUser
