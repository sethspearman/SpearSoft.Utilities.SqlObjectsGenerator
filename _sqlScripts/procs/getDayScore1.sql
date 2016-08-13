

CREATE PROCEDURE [dbo].[getDayScore1]
	@EventTurnID INT,
	@Result MONEY OUTPUT
AS 
    BEGIN
	
	DECLARE @DropHiLo BIT;
	SET @DropHiLo=dbo.fnGetDropHiLoConfigOption ()
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--Calls function to get value. refer to function doc for more details
        SET @Result = ISNULL([dbo].[fnGetDayScore1](@EventTurnID, @DropHiLo),0) 
    END


