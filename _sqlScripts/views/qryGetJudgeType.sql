

if object_id(dbo.qryGetJudgeType) is not null
	drop view dbo.qryGetJudgeType




CREATE VIEW dbo.qryGetJudgeType
AS  SELECT  dbo.tblEventTurns.EventTurnID,
            dbo.tblEventPanelJudges.JudgeID,
            dbo.tblEventPanelJudges.JudgeType
    FROM    dbo.tblEventPanels
            INNER JOIN dbo.tblEventTurns ON dbo.tblEventPanels.EventPanelID = dbo.tblEventTurns.EventPanelID
            INNER JOIN dbo.tblEventPanelJudges ON dbo.tblEventPanels.EventPanelID = dbo.tblEventPanelJudges.EventPanelID



-- grant execute on qryGetJudgeType to myUser
