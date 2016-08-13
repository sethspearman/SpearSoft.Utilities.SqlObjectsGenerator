
 
CREATE	VIEW [dbo].[qryGetTabularScoringRanges] 
AS
	
SELECT ScoreSheetName
       ,ScoringCriteriaTypeID
       ,CriteriaName
       ,[Order]
       ,ToggleName
       ,ToggleValue
       ,IncludeExecution
       ,[Level 1]
       ,[Level 2]
       ,[Level 3]
       ,[Level 4.2] AS [Level 4_2]
       ,[Level 4 ADV]
       ,[Level 4 ELT]
       ,[Level 4]
       ,[Level 5 ADV]
       ,[Level 5 ELT]
       ,[Level 5]
       ,[Level 6]
FROM   (SELECT sct.ScoringCriteriaType                                                        ScoreSheetName
               ,sct.ScoringCriteriaTypeID
               ,jc.CriteriaName
               ,CASE jcms.ToggleValue
                  WHEN -1 THEN 'Lo'
                  WHEN 0 THEN 'Med'
                  WHEN 1 THEN 'HI'
                END                                                                           ToggleName
               ,jcms.ToggleValue
               ,jc.IncludeExecution
               ,jc.[Order]
               ,CAST(jcms.MinValue AS VARCHAR(6)) + ' - ' + CAST(jcms.MaxValue AS VARCHAR(6)) ScoringRange
               ,l.Name                                                                        LevelName
        FROM   tblJudgingCriteria jc
               INNER JOIN tblJudgingCriteriaMaxScores jcms
                 ON jc.JudgingCriteriaID = jcms.JudgingCriteriaID
               INNER JOIN tblLevels l
                 ON jcms.LevelID = l.[Level]
               INNER JOIN tblScoringCriteriaTypes sct
                 ON jc.ScoringCriteriaTypeID = sct.ScoringCriteriaTypeID
        WHERE  l.[Level] > 0) ps 
               PIVOT 
               ( 
                    MIN(ScoringRange) 
                    FOR LevelName IN 
                    ( 
                         [Level 1]
                        ,[Level 2]
                        ,[Level 3]
                        ,[Level 4.2]
                        ,[Level 4 ADV]
                        ,[Level 4 ELT]
                        ,[Level 4]
                        ,[Level 5 ADV]
                        ,[Level 5 ELT]
                        ,[Level 5]
                        ,[Level 6] 
                    ) 
                ) AS pvt 

    
   

