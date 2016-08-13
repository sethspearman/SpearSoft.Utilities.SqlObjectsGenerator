

CREATE PROCEDURE [dbo].[usp_GetReportLabels]
    @EventTurnID INT
AS 
    BEGIN
        SELECT jc.PivotColumnMapping
            ,jc.Abbreviation
            ,jc.[ORDER]
        FROM tblJudgingCriteria jc
        WHERE jc.ScoringCriteriaTypeID = (
                SELECT TOP 1 jc2.ScoringCriteriaTypeID
                FROM tblEventTurnJudge etj
                INNER JOIN tblEventTurnJudgeScores etjs ON etj.EventTurnJudgeID = etjs.EventTurnJudgeID
                INNER JOIN tblJudgingCriteria jc2 ON jc2.JudgingCriteriaID = etjs.JudgingCriteriaID
                WHERE etj.EventTurnID = @EventTurnID
                )
        ORDER BY jc.[ORDER]
    END

