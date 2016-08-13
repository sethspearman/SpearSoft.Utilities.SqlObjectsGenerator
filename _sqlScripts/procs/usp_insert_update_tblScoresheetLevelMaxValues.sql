

CREATE PROCEDURE dbo.usp_insert_update_tblScoresheetLevelMaxValues
     @EventPanelTypeID int
    ,@LevelID int
    ,@MaxValue money
    ,@skipUpdate bit = NULL
AS 
    BEGIN
   
        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS (SELECT 1 FROM tblScoresheetLevelMaxValues WHERE EventPanelTypeID = @EventPanelTypeID AND LevelID = @LevelID)  

                INSERT INTO dbo.tblScoresheetLevelMaxValues (
                    EventPanelTypeID,
                    LevelID,
                    MaxValue ) 
                    VALUES (
                    @EventPanelTypeID,
                    @LevelID,
                    @MaxValue )

        ELSE --INSERT
            IF @skipUpdate=0 --UPDATE
                UPDATE dbo.tblScoresheetLevelMaxValues SET
                        MaxValue = @MaxValue
                    WHERE EventPanelTypeID = @EventPanelTypeID
                        AND LevelID = @LevelID
                
    END

