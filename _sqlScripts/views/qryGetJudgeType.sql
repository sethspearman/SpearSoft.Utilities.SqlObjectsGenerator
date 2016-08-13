

CREATE VIEW dbo.qryGetJudgeType
AS  SELECT  dbo.tblEventTurns.EventTurnID,
            dbo.tblEventPanelJudges.JudgeID,
            dbo.tblEventPanelJudges.JudgeType
    FROM    dbo.tblEventPanels
            INNER JOIN dbo.tblEventTurns ON dbo.tblEventPanels.EventPanelID = dbo.tblEventTurns.EventPanelID
            INNER JOIN dbo.tblEventPanelJudges ON dbo.tblEventPanels.EventPanelID = dbo.tblEventPanelJudges.EventPanelID


