

CREATE FUNCTION [dbo].[fnGetEventTurnJudgeDeduction] ( @EventTurnJudgeID INT )
RETURNS money
AS BEGIN

    DECLARE @Deduction money ;
    
	--Get Deductions from Deductions judge
    SELECT  @Deduction = SUM(etjd.Score)
    FROM    dbo.tblEventTurnJudgeDeductions AS etjd
    WHERE   etjd.EventTurnJudgeID = @EventTurnJudgeID   
	
    SET @Deduction = ISNULL(@Deduction,0)
	--Final calculation  of 
    RETURN -@Deduction ;
   END


