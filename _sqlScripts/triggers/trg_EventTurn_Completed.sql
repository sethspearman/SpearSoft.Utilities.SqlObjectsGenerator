


CREATE TRIGGER [dbo].[trg_EventTurn_Completed] ON [dbo].[tblEventTurns]
    FOR UPDATE
AS
    DECLARE @Completed bit;
    DECLARE @EventTurnID int;
    DECLARE @Day1or2 tinyint;
    
    SET @EventTurnID=0
    SET @Completed=(SELECT TOP 1 Completed FROM inserted)
    
    IF @Completed = 1  --IF PERFORMANCE COMPLETED THEN INSERT.
        BEGIN
            SET @EventTurnID=(SELECT TOP 1 EventTurnID FROM inserted)
            SET @Day1or2=(SELECT TOP 1 Day1or2 FROM inserted)

            IF NOT EXISTS (SELECT 1 FROM tblScoringQueue WHERE EventTurnID=@EventTurnID)  
                INSERT tblScoringQueue (Completed,EventTurnID,Day1or2) VALUES (0,@EventTurnID,@Day1or2);
            ELSE  --this should not happen but just in case
                UPDATE tblScoringQueue SET Completed = 0 WHERE EventTurnID=@EventTurnID
        END 
    IF @Completed = 0
        BEGIN
            --THIS SHOULD BE RARE...BUT SEE IF THE OLD VALUE WAS TRUE
            IF EXISTS (SELECT 1 FROM deleted WHERE Completed = 1)
                BEGIN
                    SET @EventTurnID=(SELECT TOP 1 EventTurnID FROM inserted)
                    SET @Day1or2=(SELECT TOP 1 Day1or2 FROM inserted)
                    --if so then reset the flag on tblScoringQueue
                    IF NOT EXISTS (SELECT 1 FROM tblScoringQueue WHERE EventTurnID=@EventTurnID)  --this should never happen but just in case  (someone global deletes for example)
                        INSERT tblScoringQueue (Completed,EventTurnID,Day1or2) VALUES (0,@EventTurnID,@Day1or2);
                    ELSE
                        UPDATE tblScoringQueue SET Completed = 0 WHERE EventTurnID=@EventTurnID
                END
        END 

