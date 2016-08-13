

CREATE PROCEDURE [dbo].[getScore]
    @JudgingCriteriaID INT,
    @EventTurnJudgeID INT,
	--DECLARE variable to hold information on @Result, initialized by default to NULL value
	@Result MONEY OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--Copy database information into variable @Result;
        SELECT  @Result = cast(etjs.CalculatedScore as numeric(9,4))
        FROM    dbo.tblEventTurnJudgeScores AS etjs
        WHERE   etjs.JudgingCriteriaID = @JudgingCriteriaID
                AND etjs.EventTurnJudgeID = @EventTurnJudgeID

	--RETURN the value in the variable @Result as result
	--Returns NULL if no matching record is found
        SET @Result=ISNULL(@Result,0) ;
		RETURN
    END


