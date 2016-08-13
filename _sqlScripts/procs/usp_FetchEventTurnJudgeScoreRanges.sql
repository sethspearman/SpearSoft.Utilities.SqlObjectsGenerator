

CREATE PROCEDURE [dbo].[usp_FetchEventTurnJudgeScoreRanges]
    @EventTurnJudgeID INT,
    @JudgingCriteriaID INT,
	@LevelID INT,
    @MaxValue MONEY OUTPUT,
	@MinValue MONEY OUTPUT, 
	@DefaultValue MONEY OUTPUT, 
	@MaxExec MONEY OUTPUT,
	@MinExec MONEY OUTPUT,
	@DefaultExec MONEY OUTPUT
AS 
    BEGIN

        DECLARE @DifficultyToggle smallint, @ExecutionToggle smallint ;
        DECLARE @EventTurnID int ; 

        SET NOCOUNT ON ;
        
        SET @EventTurnID = (SELECT TOP 1 etj.EventTurnID FROM tblEventTurnJudge etj WHERE EventTurnJudgeID=@EventTurnJudgeID)
        
        SELECT @DifficultyToggle=etjsv.DifficultyToggle,
                @ExecutionToggle=etjsv.ExecutionToggle
            FROM tblEventTurnJudgeStartValues etjsv
            WHERE etjsv.EventTurnJudgeID=@EventTurnJudgeID 
                AND JudgingCriteriaID=@JudgingCriteriaID
        
		SELECT @MaxValue=jcms.MaxValue,
				@MinValue=jcms.MinValue,
				@DefaultValue=jcms.DefaultValue,
                @MaxExec=jcms.ExecutionTopRange,
                @MinExec=jcms.ExecutionBottomRange,
				@DefaultExec=jcms.ExecutionDefaultValue                
            FROM tblJudgingCriteriaMaxScores jcms
            WHERE jcms.JudgingCriteriaID=@JudgingCriteriaID 
                AND jcms.LevelID=@LevelID
                AND jcms.ToggleValue=@DifficultyToggle
                
    END


