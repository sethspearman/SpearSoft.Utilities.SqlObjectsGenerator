
 
CREATE	VIEW [dbo].[qryGetTabularScoringAVGSData] 
AS
	SELECT    
		 [EventID]
		,[Day1or2]
        ,[EventTurnID]   
		,[Stunts]
		,[Pyramids]
		,[Tosses/Dismounts]
		,[Standing Tumbling]
		,[Running Tumbling]
		,[Jumps]
		,[Motions/Dance]
		,[Formations/Transitions]
		,[Performance]
		,[Skills Creativity]
		,[Routine Creativity]

	FROM 
		(
		SELECT 
			 r.EventID as EventID
			,et.Day1or2 as Day1or2
            ,et.EventTurnID as EventTurnID
			,jc.CriteriaName as CriteriaName
			,etjs.CalculatedScore as Score
			FROM tblEventTurns et
            INNER JOIN tblRegistrationDivisions rd
                ON et.RegistrationDivisionID = rd.RegistrationDivisionID
            INNER JOIN tblRegistrations r
                on rd.RegistrationID = r.RegistrationID
            INNER JOIN tblEventTurnJudge etj
                ON et.EventTurnID = etj.EventTurnID
			INNER JOIN tblEventTurnJudgeScores etjs
				ON etj.EventTurnJudgeID = etjs.EventTurnJudgeID
			INNER JOIN  tblJudgingCriteria jc
				ON etjs.JudgingCriteriaID = jc.JudgingCriteriaID
		) ps
		PIVOT
		(
			AVG(Score)
			FOR CriteriaName IN
			(
				 [Stunts]
				,[Pyramids]
				,[Tosses/Dismounts]
				,[Standing Tumbling]
				,[Running Tumbling]
				,[Jumps]
				,[Motions/Dance]
				,[Formations/Transitions]
				,[Performance]
				,[Skills Creativity]
				,[Routine Creativity]                
			)
		) as pvt  
	    

