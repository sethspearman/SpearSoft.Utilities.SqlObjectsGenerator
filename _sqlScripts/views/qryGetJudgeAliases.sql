

if object_id(dbo.qryGetJudgeAliases) is not null
	drop view dbo.qryGetJudgeAliases




CREATE VIEW dbo.qryGetJudgeAliases
AS  

    SELECT  et.EventTurnID,
            epj.JudgeID,
            dbo.fnGetJudgeAliasForReport(et.EventTurnID, epj.JudgeID) JudgeAlias
    FROM    tblEventTurns et
        INNER JOIN tblEventPanelJudges epj ON et.EventPanelID = epj.EventPanelID
            


-- grant execute on qryGetJudgeAliases to myUser
