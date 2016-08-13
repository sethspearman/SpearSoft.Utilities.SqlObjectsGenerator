

CREATE VIEW dbo.qryGetJudgeAliases
AS  

    SELECT  et.EventTurnID,
            epj.JudgeID,
            dbo.fnGetJudgeAliasForReport(et.EventTurnID, epj.JudgeID) JudgeAlias
    FROM    tblEventTurns et
        INNER JOIN tblEventPanelJudges epj ON et.EventPanelID = epj.EventPanelID
            

