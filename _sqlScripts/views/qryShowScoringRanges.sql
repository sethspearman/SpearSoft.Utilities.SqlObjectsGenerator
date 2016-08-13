

CREATE VIEW dbo.qryShowScoringRanges
AS

	SELECT	jc.CriteriaName
		,jc.[Order]
		,CASE jc.IncludeExecution WHEN 1 THEN 'True' WHEN 0 THEN 'False' END AS IncludeExecution
		,jcms.LevelID
		,l.[Name]
		,Case jcms.ToggleValue WHEN -1 THEN 'LOW' WHEN 0 THEN 'MED' WHEN 1 THEN 'HI' End ExecutionValue
		,jcms.ToggleValue
		,cast(cast(jcms.MinValue as decimal(3,1))as nvarchar(10)) + ' - ' + cast(cast(jcms.MaxValue as decimal(3,1)) as nvarchar(10)) as ScoringRange
		,cast(jcms.DefaultValue as decimal(3,1)) AS DefaultValue
		,LEFT(sct.ScoringCriteriaType,5) AS ScoreSheet
	FROM tblJudgingCriteria jc
	INNER JOIN tblJudgingCriteriaMaxScores jcms
		ON jc.JudgingCriteriaID = jcms.JudgingCriteriaID
	INNER JOIN tblLevels l
		on jcms.LevelID = l.[Level]
	INNER JOIN tblScoringCriteriaTypes sct
		ON jc.ScoringCriteriaTypeID = sct.ScoringCriteriaTypeID
			

