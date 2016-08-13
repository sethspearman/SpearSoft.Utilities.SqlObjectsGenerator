

CREATE VIEW dbo.qryGetEventTurnJudgeScores
AS  
    SELECT dbo.fnGetLevelMaxValue2 (dbo.fnGetLevelID (Null,et.EventTurnID,Null),Null, et.EventTurnID ) as MaxValue 
        ,dbo.fnGetEventTurnJudgeRawScore ( etj.EventTurnJudgeID, Null) as RawScore
        ,dbo.fnGetEventTurnJudgeScore ( etj.EventTurnJudgeID ) as AdjustedScore
        ,et.EventTurnID
		,etj.EventTurnJudgeID
		,j.JudgeID
		,j.LastName
    FROM tblEventTurnJudge etj
		INNER JOIN tblEventTurns et ON etj.EventTurnID = et.EventTurnID
		INNER JOIN tblJudges j ON etj.JudgeID = j.JudgeID


