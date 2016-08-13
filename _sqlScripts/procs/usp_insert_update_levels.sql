

if object_id(dbo.usp_insert_update_levels) is not null
	drop procedure dbo.usp_insert_update_levels




CREATE PROCEDURE [dbo].[usp_insert_update_levels]
    @Name NVARCHAR(20),
    @Description NVARCHAR(255),
    @Level INT,
    @MaxValue MONEY,
    @SortOrder INT,
    @IsActive bit,
    @skipUpdate bit = NULL
AS 
    BEGIN
   
        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS (SELECT 1 FROM tblLevels WHERE [Level]=@Level) 
            INSERT INTO tblLevels (Name, Description, [Level], MaxValue, SortOrder, IsActive) VALUES (@Name, @Description, @Level, @MaxValue, @SortOrder, @IsActive)        
        ELSE --INSERT
            IF @skipUpdate=0 --UPDATE
                UPDATE tblLevels SET Name=@Name,Description=@Description, MaxValue=@MaxValue, SortOrder=@SortOrder, IsActive=@IsActive WHERE [Level]=@Level

    END


-- grant execute on usp_insert_update_levels to myUser
