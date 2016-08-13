

CREATE PROCEDURE [dbo].[GetEventPanelRound]
    @EventPanelID INT,
	@Result TINYINT OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--Call function to get score value.
        --SELECT  @Result = [dbo].[fnGetEventPanelRound](@RegistrationDivisionID, @EventDay, @DropHiLo) ; 
		SET  @Result = ISNull((SELECT TOP 1 CurrentRound FROM usysEventPanelsCurrentRound WHERE EventPanelID=@EventPanelID),0); 

    END


