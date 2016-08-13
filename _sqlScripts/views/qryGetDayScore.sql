

if object_id(dbo.qryGetDayScore) is not null
	drop view dbo.qryGetDayScore




CREATE VIEW dbo.qryGetDayScore
AS  SELECT  dbo.tblEventTurns.EventTurnID,
            dbo.tblEventTurnJudge.CompositeScore,
            dbo.tblEventTurnJudge.JudgeID
    FROM    dbo.tblEventPanels
            INNER JOIN dbo.tblEventTurns ON dbo.tblEventPanels.EventPanelID = dbo.tblEventTurns.EventPanelID
            INNER JOIN dbo.tblEventTurnJudge ON dbo.tblEventTurns.EventTurnID = dbo.tblEventTurnJudge.EventTurnID



-- grant execute on qryGetDayScore to myUser
