

CREATE VIEW dbo.qryGetDayScore
AS  SELECT  dbo.tblEventTurns.EventTurnID,
            dbo.tblEventTurnJudge.CompositeScore,
            dbo.tblEventTurnJudge.JudgeID
    FROM    dbo.tblEventPanels
            INNER JOIN dbo.tblEventTurns ON dbo.tblEventPanels.EventPanelID = dbo.tblEventTurns.EventPanelID
            INNER JOIN dbo.tblEventTurnJudge ON dbo.tblEventTurns.EventTurnID = dbo.tblEventTurnJudge.EventTurnID


