
 
CREATE	VIEW [dbo].[qryGetTabularScoringDataNCADanceOpen] 
AS
	SELECT [JudgeAlias]
		,[JudgeName]
		,[EventTurnID]
		,[EventTurnJudgeID]
        ,[RawScore]        
        ,[Routine Execution]
        ,[Technical Skills]
        ,[Choreography]
        ,[Uniformity]
        ,[Staging]
        ,[Degree of Difficulty]
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
                     [Routine Execution]
                    ,[Technical Skills]
                    ,[Choreography]
                    ,[Uniformity]
                    ,[Staging]
                    ,[Degree of Difficulty]
                    ,[Performance Impression]
                    ,[Collegiate Image]           
			)
		) as pvt      
   
