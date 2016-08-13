

if object_id(dbo.usp_GetDecrementedLevel) is not null
	drop procedure dbo.usp_GetDecrementedLevel




CREATE PROCEDURE [dbo].[usp_GetDecrementedLevel]
    @ScoringCriteriaTypeID INT, 
    @CurrentSortOrder TINYINT,
    @DoIncrement BIT,
	@SortOrder INT OUTPUT,
    @ResultID INT OUTPUT
AS 
    BEGIN
    
        IF @DoIncrement=0  --DECREMENT...FIND THE NEXT LOWEST LEVEL
            SELECT TOP 1    @ResultID = ISNULL(sctl.LevelID,0),
                            @SortOrder = ISNULL(l.SortOrder,0)
            FROM tblScoringCriteriaTypeLevels sctl 
                INNER JOIN tblLevels l ON sctl.LevelID = l.[Level]
            WHERE ScoringCriteriaTypeID = @ScoringCriteriaTypeID 
                AND l.[SortOrder]<@CurrentSortOrder
                AND l.IsActive=1
            ORDER BY l.SortOrder DESC
        ELSE  --INCREMENT --FIND THE NEXT HIGHEST LEVEL
            SELECT TOP 1    @ResultID = ISNULL(sctl.LevelID,0),
                            @SortOrder = ISNULL(l.SortOrder,0)
            FROM tblScoringCriteriaTypeLevels sctl 
                INNER JOIN tblLevels l ON sctl.LevelID = l.[Level]
            WHERE ScoringCriteriaTypeID = @ScoringCriteriaTypeID 
                AND l.[SortOrder]>@CurrentSortOrder
                AND l.IsActive=1
            ORDER BY l.SortOrder ASC        

    IF EXISTS(SELECT 1 FROM tblEventPanelTypes WHERE LevelDrop0=1 AND EventPanelTypeID=@ScoringCriteriaTypeID)
        SET @ResultID = 0  ;        
            
        IF @ResultID Is Null
			SET @ResultID = -1  ;

		If @SortOrder Is Null
			SET @SortOrder = -1 ;
	
        RETURN
        
    END



-- grant execute on usp_GetDecrementedLevel to myUser
