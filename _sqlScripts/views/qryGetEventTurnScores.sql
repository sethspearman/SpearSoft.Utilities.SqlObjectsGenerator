

if object_id(dbo.qryGetEventTurnScores) is not null
	drop view dbo.qryGetEventTurnScores




CREATE VIEW dbo.qryGetEventTurnScores
AS  
    SELECT dbo.fnGetLevelMaxValue2 (dbo.fnGetLevelID (Null,et.EventTurnID,Null),Null, et.EventTurnID ) as MaxValue 
        ,dbo.fnGetDayScore1RawScoreOnly ( et.EventTurnID, dbo.fnGetDropHiLoConfigOption()) as RawScore
        ,dbo.fnGetDayScore1ScoreOnly ( et.EventTurnID, dbo.fnGetDropHiLoConfigOption()) as AdjustedScore
        ,dbo.fnGetDayScorePercentPerfection (et.EventTurnID, dbo.fnGetDropHiLoConfigOption()) as PercentPerfection
        ,dbo.fnGetEventTurnDeduction ( et.EventTurnID ) as Deduction
        ,dbo.fnGetDayScore1 ( et.EventTurnID, dbo.fnGetDropHiLoConfigOption()) as CompositeScore
        ,dbo.fnGetEventScore    (
                                    et.RegistrationDivisionID
                                    ,CAST(dbo.fnGetConfigOption('CurrentDay','2') as tinyint)
                                    ,CAST(dbo.fnGetConfigOption('Day1Weight','.4') as MONEY)
                                    ,CAST(dbo.fnGetConfigOption('Day2Weight','.6') as MONEY)
                                    ,dbo.fnGetDropHiLoConfigOption()
                                ) as EventScore
        ,et.EventTurnID
    FROM tblEventTurns et



-- grant execute on qryGetEventTurnScores to myUser
