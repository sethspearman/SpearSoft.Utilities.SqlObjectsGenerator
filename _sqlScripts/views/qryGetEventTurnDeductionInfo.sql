

if object_id(dbo.qryGetEventTurnDeductionInfo) is not null
	drop view dbo.qryGetEventTurnDeductionInfo




CREATE VIEW dbo.qryGetEventTurnDeductionInfo
AS  

SELECT  dbo.tblEventTurns.EventTurnID,
            dbo.tblEventTurnJudge.JudgeID,
            dbo.tblEventTurnJudgeDeductions.EventTurnJudgeID
    FROM    dbo.tblEventTurns
            INNER JOIN dbo.tblEventTurnJudge ON dbo.tblEventTurns.EventTurnID = dbo.tblEventTurnJudge.EventTurnID
            INNER JOIN dbo.tblEventTurnJudgeDeductions ON dbo.tblEventTurnJudge.EventTurnJudgeID = dbo.tblEventTurnJudgeDeductions.EventTurnJudgeID



-- grant execute on qryGetEventTurnDeductionInfo to myUser
