

CREATE FUNCTION [dbo].[fnGetDayScore1RawScoreOnly] ( @EventTurnID INT, @DropHiLo bit)
RETURNS MONEY
AS  BEGIN
 
    DECLARE @DeductionJudges TABLE ( JudgeID INT ) ;
    DECLARE @PerformanceScore MONEY ;
    DECLARE @LevelID int ;
    
    DECLARE @PerformanceScoreDecimal DECIMAL(9,4) ;
    
    SELECT @LevelID = dbo.fnGetLevelID ( Null, @EventTurnID, Null ) ;
    
	--Get the DeductionJudgeID using the getEventTurnDeductionJudgeID proc.
    INSERT  INTO @DeductionJudges
            SELECT  *
            FROM    [dbo].[fnGetEventTurnDeductionJudgeIDs](@EventTurnID) ; 
                            
            --create an in memory CTE for use by procedure...

    SET @PerformanceScoreDecimal = 
    (
        SELECT Sum(CategoryScore) FROM 
            (
                SELECT sc.ScoringCategoryID
                    ,(SUM(jcavgs.TotalCriteriaSCore)) CategoryScore
                FROM
                    (	SELECT 
                         PERF_SCORES.JudgingCriteriaID
                        ,PERF_SCORES.ScoringCategoryID
                        ,AVG(cast(PERF_SCORES.SCORE AS DECIMAL(9,6))) AvgDifficultScore
                        ,AVG(CAST(PERF_SCORES.EXECUTION AS DECIMAL(9,6))) AvgTechniqueScore
                        ,(AVG(cast(PERF_SCORES.SCORE AS DECIMAL(9,6))) + AVG(CAST(PERF_SCORES.EXECUTION AS DECIMAL(9,6)))) TotalCriteriaScore
                        FROM 
                            (
                                SELECT etjs.JudgingCriteriaID JudgingCriteriaID
                                    ,jcho.JudgingCriteriaID OuterID
                                    ,jc.ScoringCategoryID ScoringCategoryID
                                    ,etjs.SCORE Score
                                    ,etjs.EXECUTION Execution
                                    ,etjs.CalculatedScore CalculatedScore
                                    ,ROW_NUMBER() OVER (PARTITION BY jcho.ID ORDER BY etjs.Score DESC) HiRow
                                FROM tblEventTurnJudgeScores etjs
                                    INNER JOIN tblJudgingCriteria jc ON etjs.JudgingCriteriaID = jc.JudgingCriteriaID
                                    LEFT JOIN tblJudgingCriteriaHighestOf jcho ON etjs.JudgingCriteriaID=jcho.JudgingCriteriaID
                                WHERE EventTurnJudgeID  IN
                                    (SELECT EventTurnJudgeID FROM tblEventTurnJudge etj 
                                        WHERE etj.EventTurnID = @EventTurnID
                                            AND JudgeID IN 
                                            (
                                                SELECT DISTINCT JudgeID
                                                FROM tblEventPanelJudgeCategories epjc
                                                WHERE epjc.EventPanelID = dbo.fnGetEventPanelID(@EventTurnID)
                                            )        
                                    )
                            )  PERF_SCORES                           
                        WHERE PERF_SCORES.OuterID Is Null OR PERF_SCORES.HiRow=1
                        GROUP BY PERF_SCORES.JudgingCriteriaID, PERF_SCORES.ScoringCategoryID
                    ) jcavgs
                    INNER JOIN tblScoringCategories sc ON jcavgs.ScoringCategoryID = sc.ScoringCategoryID
                GROUP BY sc.ScoringCategoryID
            ) 
        As ComputedScore
    ) 
        
    SET @PerformanceScore = CAST(ROUND(@PerformanceScoreDecimal,6) AS MONEY) ;
    RETURN @PerformanceScore ;
    END


