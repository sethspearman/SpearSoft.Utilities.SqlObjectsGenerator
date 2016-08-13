

if object_id(dbo.GetDayScore2DeductionOnly) is not null
	drop procedure dbo.GetDayScore2DeductionOnly





CREATE PROCEDURE [dbo].[GetDayScore2DeductionOnly]
    @RegistrationDivisionID INT,
    @EventDay TINYINT,
	@Result MONEY OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--DECLARE variable to hold information on EventTurnID, initialized by default to NULL value
        DECLARE @EventTurnID INT ;

        SET @EventTurnID = dbo.fnGetEventTurnID(@RegistrationDivisionID, @EventDay) ;

        EXEC [dbo].[GetDayScore1DeductionOnly] @EventTurnID=@EventTurnID,@Result=@Result OUTPUT ;
		SET @Result = ISNULL(@Result,0)
		RETURN

    END



-- grant execute on GetDayScore2DeductionOnly to myUser
