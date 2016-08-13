

CREATE PROCEDURE [dbo].[usp_UpdateInsertScoringRange]
    @JudgingCriteriaID INT,
    @LevelID INT,
    @ToggleValue smallint,
    @MinValue MONEY,
    @MaxValue MONEY,
    @DefaultValue MONEY
    
AS 
    BEGIN

        IF EXISTS   (
                        SELECT 1 
                        FROM tblJudgingCriteriaMaxScores 
                        WHERE JudgingCriteriaID=@JudgingCriteriaID 
                            AND LevelID=@LevelID 
                            AND ToggleValue=@ToggleValue
                    )
            UPDATE tblJudgingCriteriaMaxScores 
            SET MinValue = @MinValue, MaxValue=@MaxValue, DefaultValue=@DefaultValue  
            WHERE JudgingCriteriaID=@JudgingCriteriaID 
                AND LevelID=@LevelID 
                AND ToggleValue=@ToggleValue
        ELSE
            INSERT INTO tblJudgingCriteriaMaxScores 
                    (
                        JudgingCriteriaID,
                        LevelID,
                        ToggleValue,
                        MinValue,
                        MaxValue,
                        DefaultValue
                    )
                VALUES
                    (
                        @JudgingCriteriaID,
                        @LevelID,
                        @ToggleValue,
                        @MinValue,
                        @MaxValue,
                        @DefaultValue                 
                    )
    
    
    END

