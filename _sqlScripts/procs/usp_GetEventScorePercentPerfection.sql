

if object_id(dbo.usp_GetEventScorePercentPerfection) is not null
	drop procedure dbo.usp_GetEventScorePercentPerfection




CREATE PROCEDURE [dbo].[usp_GetEventScorePercentPerfection]
    @RegistrationDivisionID INT,
    @EventDay TINYINT,
    @Day1Weight MONEY,
    @Day2Weight MONEY,
	@Result MONEY OUTPUT
AS 
    BEGIN
    
    DECLARE @DropHiLo BIT;
	SET @DropHiLo=dbo.fnGetDropHiLoConfigOption ()
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--call function to get Event score value;
        SELECT  @Result = [dbo].[fnGetEventScorePercentPerfection](@RegistrationDivisionID, @EventDay,
                                        @Day1Weight, @Day2Weight,@DropHiLo);

    END


-- grant execute on usp_GetEventScorePercentPerfection to myUser
