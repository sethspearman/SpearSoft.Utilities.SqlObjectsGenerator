


CREATE PROCEDURE [dbo].[usp_GetEventTurnJudgeRawScore]
    @EventTurnJudgeID INT,
	@Result MONEY OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

        SET  @Result = ISNULL(dbo.fnGetEventTurnJudgeRawScore ( @EventTurnJudgeID, Null ),0 ) ;
		RETURN @Result
    END


