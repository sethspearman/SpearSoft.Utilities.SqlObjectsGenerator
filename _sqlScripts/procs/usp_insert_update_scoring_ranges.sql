

CREATE PROCEDURE [dbo].[usp_insert_update_scoring_ranges]
    @JudgingCriteriaID INT,
    @LevelID INT,
    @ToggleValue smallint,
    @MinValue MONEY,
    @MaxValue MONEY,
    @DefaultValue MONEY,
    @skipUpdate bit = NULL
    
AS 
    BEGIN

        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS   ( SELECT 1 FROM tblJudgingCriteriaMaxScores WHERE JudgingCriteriaID=@JudgingCriteriaID AND LevelID=@LevelID AND ToggleValue=@ToggleValue )
            INSERT INTO tblJudgingCriteriaMaxScores ( JudgingCriteriaID, LevelID, ToggleValue, MinValue, MaxValue, DefaultValue )
                VALUES ( @JudgingCriteriaID, @LevelID, @ToggleValue, @MinValue, @MaxValue, @DefaultValue )
        ELSE
            IF @skipUpdate=0 --UPDATE
                UPDATE tblJudgingCriteriaMaxScores SET MinValue = @MinValue, MaxValue=@MaxValue, DefaultValue=@DefaultValue 
                    WHERE JudgingCriteriaID=@JudgingCriteriaID AND LevelID=@LevelID AND ToggleValue=@ToggleValue       
    END

