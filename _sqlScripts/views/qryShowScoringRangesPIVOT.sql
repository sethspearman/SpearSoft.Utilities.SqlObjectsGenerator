

CREATE VIEW dbo.qryShowScoringRangesPIVOT
AS
	SELECT CriteriaName, [Order],LevelID, [Name] as LevelName, ScoreSheet
				, [LOW] AS LowScoringRange
				, [MED] AS MedScoringRange
				, [HI]  AS HiScoringRange

	FROM (	SELECT CriteriaName, [Order],LevelID, [Name],ExecutionValue, ScoringRange, ScoreSheet
			FROM qryShowScoringRanges ) ps
	PIVOT
		(
			MAX(ScoringRange)
			FOR ExecutionValue IN
			(
				[LOW],[MED],[HI]
			)
		) AS PVT

