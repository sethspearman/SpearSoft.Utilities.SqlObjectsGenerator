

if object_id(dbo.getEventTurnJudgeID) is not null
	drop procedure dbo.getEventTurnJudgeID





CREATE PROCEDURE [dbo].[getEventTurnJudgeID]
    @EventTurnID INT,
    @JudgeID INT,
	@Result INT OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--DECLARE variable to hold information on EventTurnJudgeID, initialized by default to NULL value
        DECLARE @EventTurnJudgeID INT ;

	--Copy database information into variable @EventTurnJudgeID;
	--Returns 0 if no matching record is found
        SELECT  @EventTurnJudgeID = etj.EventTurnJudgeID
        FROM    dbo.tblEventTurnJudge AS etj
        WHERE   etj.EventTurnID = @EventTurnID
                AND etj.JudgeID = @JudgeID

        SET  @Result = ISNULL(@EventTurnJudgeID, 0)
		RETURN @Result
    END



-- grant execute on getEventTurnJudgeID to myUser
