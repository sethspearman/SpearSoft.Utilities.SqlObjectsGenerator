

if object_id(dbo.GetStatus) is not null
	drop procedure dbo.GetStatus




CREATE PROCEDURE [dbo].[GetStatus]
    @PanelID INT,
    @Key nvarchar(100),
	@Result nvarchar(100) OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--Call function to get score value.
        --SELECT  @Result = [dbo].[fnGetStatus](@RegistrationDivisionID, @EventDay, @DropHiLo) ; 
		SET  @Result = ISNull((SELECT TOP 1 [Value] FROM usysStatus WHERE PanelID=@PanelID AND [Key]=@Key),''); 

    END



-- grant execute on GetStatus to myUser
