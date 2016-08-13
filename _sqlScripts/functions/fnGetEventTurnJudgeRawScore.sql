

CREATE FUNCTION [dbo].[fnGetEventTurnJudgeRawScore] ( @EventTurnJudgeID int, @LevelID int )
RETURNS money
AS BEGIN

    DECLARE @SumScore money ;
    SET @SumScore=-1  --not part of original function.
    /*
     --although I think it will shcnage...I am commenting out this code for now and defaulting the fn to return 0+
     --for 2012-13 the concept of JudgeScore goes away.  And I need to remove object references to tblScoringCategoryDivisors so I can drop the table.  
     --even if this comes back some day I think that table is gone for good.
    DECLARE @GetLevelID INT ; 
    DECLARE @EventTurnID INT ;
    DECLARE @LevelMaxValue MONEY ; 
    
    SET @GetLevelID = dbo.fnGetLevelID(@LevelID,null,@EventTurnJudgeID)
    SET @EventTurnID = (SELECT TOP 1 EventTurnID FROM tblEventTurnJudge WHERE EventTurnJudgeID = @EventTurnJudgeID)
    SET @LevelMaxValue = dbo.fnGetLevelMaxValue2(@GetLevelID, Null, @EventTurnID)
    
    SET @SumScore = 
		(
			SELECT Sum(CategoryScore) FROM 
				(
					SELECT round((((cast(SUM(etjs.CalculatedScore) as decimal(9,4)))/max(scd.Divisor))),5) * (@LevelMaxValue  *  max(sc.PercentOfTotal)) as CategoryScore
					FROM tblEventTurnJudgeScores etjs 
						INNER JOIN tblJudgingCriteria jc ON  jc.JudgingCriteriaID = etjs.JudgingCriteriaID
						INNER JOIN tblScoringCategories sc ON jc.ScoringCategoryID = sc.ScoringCategoryID
                        INNER JOIN tblScoringCategoryDivisors scd ON sc.ScoringCategoryID = scd.ScoringCategoryID
					WHERE etjs.EventTurnJudgeID = @EventTurnJudgeID AND scd.LevelID = @GetLevelID
                    GROUP BY jc.ScoringCategoryID
				) 
			As ComputedScore
		)
	
    SET @SumScore = ISNULL(@SumScore,0)
	--Final calculation  of */
    RETURN @SumScore ;
   END


