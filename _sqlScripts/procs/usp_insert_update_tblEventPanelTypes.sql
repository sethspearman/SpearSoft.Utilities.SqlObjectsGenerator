

CREATE PROCEDURE dbo.usp_insert_update_tblEventPanelTypes
    @EventPanelTypeID int,	
	@Name nvarchar(50),
	@Description nvarchar(255),
    @skipUpdate bit = NULL,
    @LevelDrop0 bit = 0,
    @HideScoreSummary bit = 0
AS 
    BEGIN
   
        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS (SELECT 1 FROM tblEventPanelTypes WHERE EventPanelTypeID = @EventPanelTypeID)  

                INSERT INTO dbo.tblEventPanelTypes (
                    EventPanelTypeID,
                    Name,
                    Description,
                    LevelDrop0,
                    HideScoreSummary ) 
                    VALUES (
                    @EventPanelTypeID,
                    @Name,
                    @Description,
                    @LevelDrop0,
                    @HideScoreSummary)

        ELSE --INSERT
            IF @skipUpdate=0 --UPDATE
                UPDATE dbo.tblEventPanelTypes SET
                        Name = @Name,
                        Description = @Description,
                        LevelDrop0=@LevelDrop0,
                        HideScoreSummary = @HideScoreSummary
                    WHERE
                        EventPanelTypeID = @EventPanelTypeID
                
    END

