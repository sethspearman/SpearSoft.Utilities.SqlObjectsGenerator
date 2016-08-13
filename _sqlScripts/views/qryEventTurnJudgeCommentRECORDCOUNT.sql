

CREATE VIEW dbo.qryEventTurnJudgeCommentRECORDCOUNT
AS  SELECT  dbo.tblEventTurnJudgeScores.EventTurnJudgeID,
            dbo.tblEventTurnJudgeCommentFLAGS.EventTurnJudgeScoreID
    FROM    dbo.tblEventTurnJudgeScores
            INNER JOIN dbo.tblEventTurnJudgeCommentFLAGS ON dbo.tblEventTurnJudgeScores.EventTurnJudgeScoreID = dbo.tblEventTurnJudgeCommentFLAGS.EventTurnJudgeScoreID


