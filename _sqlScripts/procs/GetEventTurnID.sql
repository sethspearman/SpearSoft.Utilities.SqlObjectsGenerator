

CREATE PROCEDURE [dbo].[GetEventTurnID]
    @RegistrationDivisionID INT,
    @EventDay TINYINT,
	@Result INT OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;
	
	-- use function to get eventturnid information
        SET  @Result=[dbo].[fnGetEventTurnID](@RegistrationDivisionID, @EventDay) ;
		Return @Result
	
    END


