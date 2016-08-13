

CREATE PROCEDURE [dbo].[getEventTurnJudgeCompositeScore]
	@EventTurnJudgeID INT,
	@Result MONEY OUTPUT
AS 
    BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--Calls function to get value. refer to function doc for more details
        SET @Result = ISNULL(dbo.fnGetEventTurnJudgeScore ( @EventTurnJudgeID ),0) ;
		RETURN @Result
    END


