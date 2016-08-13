

CREATE PROCEDURE usp_GetJudgingCriteriaScoringRangeValues 
                     @JudgingCriteriaID INT,
                     @LevelID INT,
                     @ToggleValue SMALLINT,
                     @MinValue MONEY OUTPUT,
                     @MaxValue MONEY OUTPUT,
                     @DefaultValue MONEY OUTPUT,
                     @Difference MONEY OUTPUT,  --RETURNS THE DIFFERENCE BETWEEN MIN AND MAX
                     @RangeString VARCHAR(21) OUTPUT,  --RETURNS THE STRING DIFFERENCE
                     @IncludeExecution BIT OUTPUT
                     
AS
  BEGIN
    SELECT  @MinValue           =   ISNULL(JCMS.MinValue,0),
            @MaxValue           =   ISNULL(JCMS.MaxValue,0),
            @DefaultValue       =   ISNULL(JCMS.DefaultValue,0),
            @Difference         =   ISNULL(JCMS.MaxValue,0) - ISNULL(JCMS.MinValue,0),
            @RangeString        =   ISNULL(CAST(JCMS.MinValue AS VARCHAR(21)), '') + ' - ' + ISNULL(CAST(JCMS.MaxValue AS VARCHAR(21)), ''),
            @IncludeExecution   =   JC.IncludeExecution
    FROM tblJudgingCriteria JC
        INNER JOIN tblJudgingCriteriaMaxScores JCMS
            ON JC.JudgingCriteriaID = JCMS.JudgingCriteriaID
    WHERE  JCMS.JudgingCriteriaID = @JudgingCriteriaID
       AND JCMS.LevelID = @LevelID
       AND JCMS.ToggleValue = @ToggleValue;
  END


