

CREATE PROCEDURE [dbo].[usp_GetDay1EventTurnID] 
	@Day2EventTurnID INT,
	@Result INT OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;
        
        DECLARE @RegistrationDivisionID INT ;
        
        SET @RegistrationDivisionID = ISNULL((SELECT RegistrationDivisionID FROM tblEventTurns WHERE EventTurnID = @Day2EventTurnID),0)
        SET @Result = (SELECT EventTurnID FROM tblEventTurns WHERE RegistrationDivisionID=@RegistrationDivisionID AND Day1or2 = 1)
		RETURN @Result
    END


