

CREATE FUNCTION [dbo].[fnGetEventTurnDeduction] ( @EventTurnID INT )
RETURNS money
AS BEGIN

    DECLARE @EventTurnJudgeDeductionID INT ;
    DECLARE @DeductionJudges TABLE ( JudgeID INT ) ;
    DECLARE @Deductions MONEY ;
    
	--Get the DeductionJudgeID using the getEventTurnDeductionJudgeID proc.
    INSERT  INTO @DeductionJudges
            SELECT  *
            FROM    [dbo].[fnGetEventTurnDeductionJudgeIDs](@EventTurnID) ; 
        
    SELECT @EventTurnJudgeDeductionID = etj.EventTurnJudgeID 
        FROM tblEventTurnJudge etj 
        WHERE EventTurnID=@EventTurnID 
            AND JudgeID IN (SELECT TOP 1 JudgeID FROM @DeductionJudges) ;
           
    SELECT  @Deductions = dbo.fnGetEventTurnJudgeDeduction ( @EventTurnJudgeDeductionID )  ;
	--Final calculation  of 
    RETURN @Deductions ;
   END


