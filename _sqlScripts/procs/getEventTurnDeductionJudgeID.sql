

CREATE PROCEDURE [dbo].[getEventTurnDeductionJudgeID] 
	@EventTurnID INT,
	@Result INT OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--Call function to get value. this functionality is used in multiple places and so embedded into a function
        SELECT  @Result=JudgeID
        FROM    [dbo].[fnGetEventTurnDeductionJudgeIDs](@EventTurnID) ;

		RETURN @Result
    END


