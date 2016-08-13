

if object_id(dbo.usp_insert_update_divisions) is not null
	drop procedure dbo.usp_insert_update_divisions




CREATE PROCEDURE [dbo].[usp_insert_update_divisions]
    @DivisionID INT,
    @DivisionName NVARCHAR(50),
    @LevelID INT,
    @DivisionCode NVARCHAR(50),
    @EventPanelTypeID INT,
    @skipUpdate bit = NULL
AS 
    BEGIN
   
        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS (SELECT 1 FROM tblDivisions WHERE DivisionID=@DivisionID) 
            INSERT INTO tblDivisions (DivisionID, DivisionName, [Level], DivisionCode, EventPanelTypeID) VALUES (@DivisionID, @DivisionName,@LevelID,@DivisionCode,@EventPanelTypeID)        
        ELSE --INSERT
            IF @skipUpdate=0 --UPDATE
                UPDATE tblDivisions SET DivisionName=@DivisionName,[Level]=@LevelID, DivisionCode=@DivisionCode, EventPanelTypeID=@EventPanelTypeID WHERE DivisionID=@DivisionID
                
    END


-- grant execute on usp_insert_update_divisions to myUser
