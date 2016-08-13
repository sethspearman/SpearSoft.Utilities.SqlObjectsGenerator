

if object_id(dbo.SetEventPanelRound) is not null
	drop procedure dbo.SetEventPanelRound




CREATE PROCEDURE [dbo].[SetEventPanelRound]
    @EventPanelID INT,
    @CurrentRound TINYINT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--Call function to set status...update for existing otherwise insert.

		IF EXISTS(SELECT 1 FROM usysEventPanelsCurrentRound WHERE EventPanelID=@EventPanelID)
			UPDATE usysEventPanelsCurrentRound SET CurrentRound=@CurrentRound WHERE EventPanelID=@EventPanelID
		ELSE
			INSERT INTO usysEventPanelsCurrentRound (EventPanelID,CurrentRound) VALUES (@EventPanelID,@CurrentRound) 

    END



-- grant execute on SetEventPanelRound to myUser
