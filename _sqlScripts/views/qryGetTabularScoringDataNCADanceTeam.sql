

if object_id(dbo.qryGetTabularScoringDataNCADanceTeam) is not null
	drop view dbo.qryGetTabularScoringDataNCADanceTeam



 
CREATE	VIEW [dbo].[qryGetTabularScoringDataNCADanceTeam] 
AS
	SELECT [JudgeAlias]
		,[JudgeName]
		,[EventTurnID]
		,[EventTurnJudgeID]
        ,[RawScore]        
        ,[Jazz Technique]
        ,[Jazz Choreography]
        ,[Pom Technique]
        ,[Pom Choreography]
        ,[Hip Hop Technique]
        ,[Hip Hop Choreography]
        ,[Leaps and Turns]
        ,[Staging]
        ,[Degree of Difficulty]
        ,[Uniformity]
        ,[Performance Impression]
        ,[Collegiate Image]

	FROM 
		(
		SELECT dbo.fnGetJudgeAliasForReport(etj.EventTurnID, etj.JudgeID) as JudgeAlias
			,j.FirstName + ' ' + j.LastName as JudgeName
			,etj.EventTurnID as EventTurnID
			,etj.EventTurnJudgeID
			,jc.CriteriaName as CriteriaName
			,etjs.CalculatedScore as Score
            ,dbo.fnGetEventTurnJudgeRawScore (etj.EventTurnJudgeID, Null) as RawScore
			FROM tblEventTurnJudge etj
			INNER JOIN tblEventTurnJudgeScores etjs
				ON etj.EventTurnJudgeID = etjs.EventTurnJudgeID
			INNER JOIN  tblJudgingCriteria jc
				ON etjs.JudgingCriteriaID = jc.JudgingCriteriaID
			INNER JOIN tblJudges j
				ON etj.JudgeID=j.JudgeID
            INNER JOIN tblScoringCategories sc
                ON jc.ScoringCategoryID=sc.ScoringCategoryID
			WHERE etj.EventTurnID=etj.EventTurnID
		) ps
		PIVOT
		(
			SUM(Score)
			FOR CriteriaName IN
			(
            
                 [Jazz Technique]
                ,[Jazz Choreography]
                ,[Pom Technique]
                ,[Pom Choreography]
                ,[Hip Hop Technique]
                ,[Hip Hop Choreography]
                ,[Leaps and Turns]
                ,[Staging]
                ,[Degree of Difficulty]
                ,[Uniformity]
                ,[Performance Impression]
                ,[Collegiate Image]  
                
			)
		) as pvt      
   


-- grant execute on qryGetTabularScoringDataNCADanceTeam to myUser
