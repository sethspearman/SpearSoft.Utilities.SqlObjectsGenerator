

if object_id(dbo.trg_UpdatesScoresFromPivot) is not null
	drop trigger dbo.trg_UpdatesScoresFromPivot




CREATE TRIGGER [dbo].[trg_UpdatesScoresFromPivot] ON [dbo].usys_tblPivotedScoringData
    FOR UPDATE
AS      
    DECLARE @JudgingCriteriaID int;
    DECLARE @ColumnMapping VARCHAR(15);
    --***************************************************************
    SET @ColumnMapping = 'Criteria_1';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_1, Execution = i.Criteria_1_Exec, ChangedScore=d.Criteria_1
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_1 <> d.Criteria_1 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID
    --***************************************************************
    SET @ColumnMapping = 'Criteria_2';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_2, Execution = i.Criteria_2_Exec, ChangedScore=d.Criteria_2
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_2 <> d.Criteria_2 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID
    --***************************************************************
    SET @ColumnMapping = 'Criteria_3';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_3, Execution = i.Criteria_3_Exec, ChangedScore=d.Criteria_3
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_3 <> d.Criteria_3 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID
    --***************************************************************
    SET @ColumnMapping = 'Criteria_4';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_4, Execution = i.Criteria_4_Exec, ChangedScore=d.Criteria_4
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_4 <> d.Criteria_4 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID
    --***************************************************************
    SET @ColumnMapping = 'Criteria_5';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_5, Execution = i.Criteria_5_Exec, ChangedScore=d.Criteria_5
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_5 <> d.Criteria_5 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID
    --***************************************************************
    SET @ColumnMapping = 'Criteria_6';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_6, Execution = i.Criteria_6_Exec, ChangedScore=d.Criteria_6
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_6 <> d.Criteria_6 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID
    --***************************************************************
    SET @ColumnMapping = 'Criteria_7';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_7, Execution = i.Criteria_7_Exec, ChangedScore=d.Criteria_7
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_7 <> d.Criteria_7 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID
    --***************************************************************
    SET @ColumnMapping = 'Criteria_8';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_8, Execution = i.Criteria_8_Exec, ChangedScore=d.Criteria_8
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_8 <> d.Criteria_8 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID
    --***************************************************************
    SET @ColumnMapping = 'Criteria_9';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_9, Execution = i.Criteria_9_Exec, ChangedScore=d.Criteria_9
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_9 <> d.Criteria_9 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID
    --***************************************************************
    SET @ColumnMapping = 'Criteria_10';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_10, Execution = i.Criteria_10_Exec, ChangedScore=d.Criteria_10
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_10 <> d.Criteria_10 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID
    --***************************************************************
    SET @ColumnMapping = 'Criteria_11';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_11, Execution = i.Criteria_11_Exec, ChangedScore=d.Criteria_11
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_11 <> d.Criteria_11 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID
    --***************************************************************
    SET @ColumnMapping = 'Criteria_12';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_12, Execution = i.Criteria_12_Exec, ChangedScore=d.Criteria_12
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_12 <> d.Criteria_12 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID
    --***************************************************************
    SET @ColumnMapping = 'Criteria_13';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_13, Execution = i.Criteria_13_Exec, ChangedScore=d.Criteria_13
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_13 <> d.Criteria_13 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID    
    --***************************************************************
    SET @ColumnMapping = 'Criteria_14';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_14, Execution = i.Criteria_14_Exec, ChangedScore=d.Criteria_14
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_14 <> d.Criteria_14 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID    

    --***************************************************************
    SET @ColumnMapping = 'Criteria_15';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_15, Execution = i.Criteria_15_Exec, ChangedScore=d.Criteria_15
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_15 <> d.Criteria_15 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID    
    
    --***************************************************************
    SET @ColumnMapping = 'Criteria_16';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_16, Execution = i.Criteria_16_Exec, ChangedScore=d.Criteria_16
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_16 <> d.Criteria_16 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID    
    
    --***************************************************************
    SET @ColumnMapping = 'Criteria_17';
    SET @JudgingCriteriaID = 
                (
                    SELECT TOP 1 jc.JudgingCriteriaID 
                    FROM tblJudgingCriteria jc 
                    INNER JOIN tblEventTurnJudgeScores etjs 
                        ON jc.JudgingCriteriaID = etjs.JudgingCriteriaID  
                    INNER JOIN inserted i 
                        ON i.EventTurnJudgeID = etjs.EventTurnJudgeID
                    WHERE jc.PivotColumnMapping = @ColumnMapping
                )
    UPDATE tblEventTurnJudgeScores SET 
        Score = i.Criteria_17, Execution = i.Criteria_17_Exec, ChangedScore=d.Criteria_17
    FROM inserted i INNER JOIN deleted d ON i.EventTurnJudgeID = d.EventTurnJudgeID
        INNER JOIN tblEventTurnJudgeScores ON i.EventTurnJudgeID = tblEventTurnJudgeScores.EventTurnJudgeID
    WHERE i.Criteria_17 <> d.Criteria_17 AND tblEventTurnJudgeScores.JudgingCriteriaID = @JudgingCriteriaID    
    


-- grant execute on trg_UpdatesScoresFromPivot to myUser
