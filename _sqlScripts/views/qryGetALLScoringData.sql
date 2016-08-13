

if object_id(dbo.qryGetALLScoringData) is not null
	drop view dbo.qryGetALLScoringData



 
CREATE	VIEW [dbo].[qryGetALLScoringData] 
AS
    SELECT dbo.fnGetJudgeAliasForReport(etj.EventTurnID, etj.JudgeID) as JudgeAlias
        ,j.FirstName + ' ' + j.LastName as JudgeName
		,j.JudgeID as JudgeID
        ,r.EventID as EventID
        ,d.DivisionID as DivisionID
        ,d.DivisionName as DivisionName
        ,c.TeamSchoolName + CASE ISNULL(rd.TeamName,'') WHEN '' THEN '' WHEN '<UNKNOWN TEAM NAME>' THEN '' ELSE '-' + rd.TeamName END AS TeamName
        ,et.Day1or2 as Day1Or2
        ,c.TeamSchoolName + CASE ISNULL(rd.TeamName,'') WHEN '' THEN '' WHEN '<UNKNOWN TEAM NAME>' THEN '' ELSE '-' + rd.TeamName END + cast(etj.EventTurnID as nvarchar(6)) as SORTORDER
        ,etj.EventTurnID as EventTurnID
        ,etj.EventTurnJudgeID
        ,jc.JudgingCriteriaID as JudgingCriteriaID
        ,jc.CriteriaName as CriteriaName
        ,etjs.Score as Score
        ,etjs.Execution as ExecutionScore
        ,etjs.CalculatedScore as CalcScore
        ,dbo.fnGetEventTurnJudgeRawScore (etj.EventTurnJudgeID, Null)           as JudgeRawScore
        ,dbo.fnGetEventTurnJudgeScore   (etj.EventTurnJudgeID)                  as JudgeCalculatedScore
        ,dbo.fnGetExecutionScore (jc.JudgingCriteriaID,etj.EventTurnJudgeID)    as JudgeExecutionScore
        --,dbo.fnGetEventTurnDeduction ( et.EventTurnID )                         as EventTurnDeduction
        FROM tblEventTurns et
        INNER JOIN tblEventTurnJudge etj
            ON et.EventTurnID = etj.EventTurnID
        INNER JOIN tblRegistrationDivisions rd
            ON rd.RegistrationDivisionID = et.RegistrationDivisionID
        INNER JOIN tblRegistrations r
            ON r.RegistrationID = rd.RegistrationID 
        INNER JOIN tblDivisions d
            ON d.DivisionID = rd.DivisionID
        INNER JOIN tblCustomers c
            ON c.CustomerNumber = r.CustomerNumber
        INNER JOIN tblEventTurnJudgeScores etjs
            ON etj.EventTurnJudgeID = etjs.EventTurnJudgeID
        INNER JOIN  tblJudgingCriteria jc
            ON etjs.JudgingCriteriaID = jc.JudgingCriteriaID
        INNER JOIN tblJudges j
            ON etj.JudgeID=j.JudgeID
        INNER JOIN tblScoringCategories sc
            ON jc.ScoringCategoryID=sc.ScoringCategoryID


-- grant execute on qryGetALLScoringData to myUser
