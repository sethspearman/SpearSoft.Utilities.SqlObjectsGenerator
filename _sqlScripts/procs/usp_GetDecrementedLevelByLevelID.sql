

CREATE PROCEDURE [dbo].[usp_GetDecrementedLevelByLevelID]
    @ScoringCriteriaTypeID INT, 
    @LevelID INT,
    @DoIncrement BIT,
    @ResultID INT OUTPUT
AS 
    BEGIN
        IF @DoIncrement=0  --DECREMENT...FIND THE NEXT LOWEST LEVEL
            SELECT TOP 1    @ResultID = ISNULL(sctl.LevelID,0)
            FROM tblScoringCriteriaTypeLevels sctl 
                INNER JOIN tblLevels l ON sctl.LevelID = l.[Level]
            WHERE ScoringCriteriaTypeID = @ScoringCriteriaTypeID AND
                l.[Level]<@LevelID
            ORDER BY l.SortOrder DESC
        ELSE  --INCREMENT --FIND THE NEXT HIGHEST LEVEL
            SELECT TOP 1    @ResultID = ISNULL(sctl.LevelID,0)
            FROM tblScoringCriteriaTypeLevels sctl 
                INNER JOIN tblLevels l ON sctl.LevelID = l.[Level]
            WHERE ScoringCriteriaTypeID = @ScoringCriteriaTypeID AND
                l.[Level]>@LevelID
            ORDER BY l.SortOrder ASC
		
        RETURN
        
    END


