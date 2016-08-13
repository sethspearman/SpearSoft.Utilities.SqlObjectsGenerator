

if object_id(dbo.usp_insert_update_tblJudgingCriteriaMaxScores) is not null
	drop procedure dbo.usp_insert_update_tblJudgingCriteriaMaxScores




CREATE PROCEDURE dbo.usp_insert_update_tblJudgingCriteriaMaxScores
	@JudgingCriteriaMaxScoreID int,
	@LevelID int,
	@JudgingCriteriaID int,
	@MaxValue money,
	@ToggleValue smallint,
	@DefaultValue money,
	@MinValue money,
    @skipUpdate bit = NULL,   
    @ExecBottomRange money = -1,    
    @ExecTopRange money = -1,
    @ExecDefaultVal money = -1

AS 
    BEGIN
   
        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS (SELECT 1 FROM tblJudgingCriteriaMaxScores WHERE JudgingCriteriaMaxScoreID = @JudgingCriteriaMaxScoreID)  

                INSERT INTO dbo.tblJudgingCriteriaMaxScores (
                    JudgingCriteriaMaxScoreID,
                    LevelID,
                    JudgingCriteriaID,
                    MaxValue,
                    ToggleValue,
                    DefaultValue,
                    MinValue,
                    ExecutionBottomRange,
                    ExecutionTopRange,
                    ExecutionDefaultValue                    
                    ) 
                    VALUES (
                    @JudgingCriteriaMaxScoreID,
                    @LevelID,
                    @JudgingCriteriaID,
                    @MaxValue,
                    @ToggleValue,
                    @DefaultValue,
                    @MinValue,
                    CASE WHEN @ExecBottomRange=-1 AND @ToggleValue=-1 THEN .10 WHEN @ExecBottomRange=-1 AND @ToggleValue=0 THEN .3  WHEN @ExecBottomRange= -1 AND @ToggleValue=1 THEN .6   ELSE @ExecBottomRange END,
                    CASE WHEN @ExecTopRange=-1 AND @ToggleValue=-1 THEN .30 WHEN @ExecTopRange=-1 AND @ToggleValue=0 THEN .6  WHEN @ExecTopRange= -1 AND @ToggleValue=1 THEN 1 ELSE @ExecTopRange END,
                    CASE WHEN @ExecDefaultVal=-1 AND @ToggleValue=-1 THEN .20 WHEN @ExecDefaultVal=-1 AND @ToggleValue=0 THEN .5  WHEN @ExecDefaultVal= -1 AND @ToggleValue=1 THEN .8 ELSE @ExecDefaultVal END
                    )

        ELSE --INSERT
            IF @skipUpdate=0 --UPDATE
                UPDATE dbo.tblJudgingCriteriaMaxScores SET
                        LevelID = @LevelID,
                        JudgingCriteriaID = @JudgingCriteriaID,
                        MaxValue = @MaxValue,
                        ToggleValue = @ToggleValue,
                        DefaultValue = @DefaultValue,
                        MinValue = @MinValue,
                        ExecutionBottomRange = CASE WHEN @ExecBottomRange=-1 THEN ExecutionBottomRange ELSE @ExecBottomRange END,   --TEST FOR TOP RANGE BECAUSE BOTTOM RANGE MIGHT ACTUALLY BE 0
                        ExecutionTopRange = CASE WHEN @ExecTopRange=-1 THEN ExecutionTopRange ELSE @ExecTopRange END,
                        ExecutionDefaultValue = CASE WHEN @ExecDefaultVal=-1 THEN ExecutionDefaultValue ELSE @ExecDefaultVal END                        
                    WHERE
                        JudgingCriteriaMaxScoreID = @JudgingCriteriaMaxScoreID
                
    END


-- grant execute on usp_insert_update_tblJudgingCriteriaMaxScores to myUser
