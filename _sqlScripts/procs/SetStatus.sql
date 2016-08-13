

if object_id(dbo.SetStatus) is not null
	drop procedure dbo.SetStatus




CREATE PROCEDURE [dbo].[SetStatus]
    @PanelID INT,
    @Key nvarchar(100),
	@Value nvarchar(100)
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--Call function to set status...update for existing otherwise insert.

		IF EXISTS(SELECT 1 FROM usysStatus WHERE PanelID=@PanelID AND [Key]=@Key)
			UPDATE usysStatus SET [Value]=@Value WHERE PanelID=@PanelID AND [Key]=@Key
		ELSE
			INSERT INTO usysStatus (PanelID,[Key],[Value]) VALUES (@PanelID,@Key,@Value) 

    END



-- grant execute on SetStatus to myUser
