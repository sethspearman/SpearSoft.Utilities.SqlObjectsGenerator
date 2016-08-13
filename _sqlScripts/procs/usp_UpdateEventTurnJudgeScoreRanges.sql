

CREATE PROCEDURE [dbo].[usp_UpdateEventTurnJudgeScoreRanges]
    @EventTurnJudgeID INT,
    @JudgingCriteriaID INT,
	@LevelID INT
AS 
    BEGIN
        DECLARE @MaxValue MONEY, @MinValue MONEY,@DefaultValue MONEY ; 
		DECLARE @MaxExec MONEY,@MinExec MONEY,@DefaultExec MONEY ;
        DECLARE @DifficultyToggle smallint, @ExecutionToggle smallint ;
        DECLARE @EventTurnID int ; 
        DECLARE @IncludeExecution bit ; 
		DECLARE @OverrideToZero bit ;
        DECLARE @Score MONEY, @Execution MONEY ;

        SET NOCOUNT ON ;
        
        SET @EventTurnID = (SELECT TOP 1 etj.EventTurnID FROM tblEventTurnJudge etj WHERE EventTurnJudgeID=@EventTurnJudgeID)
        
        SET @IncludeExecution = (SELECT IncludeExecution FROM tblJudgingCriteria WHERE JudgingCriteriaID=@JudgingCriteriaID)

        SELECT @DifficultyToggle=etjsv.DifficultyToggle,
                @ExecutionToggle=etjsv.ExecutionToggle,
				@OverrideToZero=etjsv.OverrideToZero
            FROM tblEventTurnJudgeStartValues etjsv
            WHERE etjsv.EventTurnJudgeID=@EventTurnJudgeID 
                AND JudgingCriteriaID=@JudgingCriteriaID
        
		SELECT @MaxValue=jcms.MaxValue,
				@MinValue=jcms.MinValue,
				@DefaultValue=jcms.DefaultValue,
                @Score = Null
            FROM tblJudgingCriteriaMaxScores jcms
            WHERE jcms.JudgingCriteriaID=@JudgingCriteriaID 
                AND jcms.LevelID=@LevelID
                AND jcms.ToggleValue=@DifficultyToggle
    IF @IncludeExecution = 1 AND @MaxValue<>0
        SELECT @MaxExec=jcms.ExecutionTopRange,
                @MinExec=jcms.ExecutionBottomRange,
				@DefaultExec=jcms.ExecutionDefaultValue,
                @Execution=Null
            FROM tblJudgingCriteriaMaxScores jcms
            WHERE jcms.JudgingCriteriaID=@JudgingCriteriaID 
                AND jcms.LevelID=@LevelID
                AND jcms.ToggleValue=@ExecutionToggle
    ELSE
        BEGIN
            SET @MaxExec = 0 ;
            SET @MinExec = 0 ;
            SET @DefaultExec = 0 ;
            SET @Execution = 0 ;
        END 

	IF @OverrideToZero = 1
		BEGIN
			SET @MaxValue = 0
			SET @MinValue = 0
			SET @DefaultValue = 0
            SET @MaxExec = 0 ;
            SET @MinExec = 0 ;
            SET @DefaultExec = 0 ;
            SET @Execution = 0 ;
            SET @Score = 0
		END
        
        --got all of the values.  now run the update.  
        UPDATE tblEventTurnJudgeScores
            SET MaxValue=@MaxValue, 
                MinValue=@MinValue, 
                DefaultValue=@DefaultValue,
                Score=@Score,
                MaxExec=@MaxExec, 
                MinExec=@MinExec, 
                DefaultExec=@DefaultExec,
                Execution=@Execution,
                OverrideToZero=@OverrideToZero
            WHERE EventTurnJudgeID IN 
						(
							SELECT EventTurnJudgeID 
								FROM tblEventTurnJudge 
								WHERE EventTurnID=@EventTurnID
						) 
                AND JudgingCriteriaID=@JudgingCriteriaID
            
    END


