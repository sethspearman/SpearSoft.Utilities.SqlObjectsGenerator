

if object_id(dbo.usp_GetDiffScore) is not null
	drop procedure dbo.usp_GetDiffScore




CREATE PROCEDURE [dbo].[usp_GetDiffScore]
    @JudgingCriteriaID INT,
    @EventTurnJudgeID INT,
	--DECLARE variable to hold information on @Result, initialized by default to NULL value
	@Result MONEY OUTPUT
AS 
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

        --Copy database information into variable @Result;
        SET  @Result = dbo.fnGetDifficultyScore ( @JudgingCriteriaID, @EventTurnJudgeID ) ;

        --RETURN the value in the variable @Result as result
        --Returns NULL if no matching record is found
        SET @Result=ISNULL(@Result,0) ;
        RETURN
    END



-- grant execute on usp_GetDiffScore to myUser
