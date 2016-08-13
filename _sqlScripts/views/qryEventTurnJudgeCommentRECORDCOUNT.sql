

if object_id(dbo.qryEventTurnJudgeCommentRECORDCOUNT) is not null
	drop view dbo.qryEventTurnJudgeCommentRECORDCOUNT




CREATE VIEW dbo.qryEventTurnJudgeCommentRECORDCOUNT
AS  SELECT  dbo.tblEventTurnJudgeScores.EventTurnJudgeID,
            dbo.tblEventTurnJudgeCommentFLAGS.EventTurnJudgeScoreID
    FROM    dbo.tblEventTurnJudgeScores
            INNER JOIN dbo.tblEventTurnJudgeCommentFLAGS ON dbo.tblEventTurnJudgeScores.EventTurnJudgeScoreID = dbo.tblEventTurnJudgeCommentFLAGS.EventTurnJudgeScoreID



-- grant execute on qryEventTurnJudgeCommentRECORDCOUNT to myUser
