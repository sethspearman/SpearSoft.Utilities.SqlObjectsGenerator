

CREATE FUNCTION [dbo].[Fngetjudgingcriteriascoringrange] (@JudgingCriteriaID INT,
                                                          @LevelID           INT,
                                                          @ToggleValue       SMALLINT,
                                                          @WhatToReturn      VARCHAR(21) --MIN, MAX, DEFAULT, OR STRING.
)
RETURNS VARCHAR(21)
AS
  BEGIN
      DECLARE @result NVARCHAR(21);

      SET @result = ''

      IF @WhatToReturn = 'MIN'
        SELECT @result = Isnull(CAST(JCMS.MinValue AS VARCHAR(21)), '')
        FROM   tblJudgingCriteriaMaxScores JCMS
        WHERE  JudgingCriteriaID = @JudgingCriteriaID
               AND LevelID = @LevelID
               AND ToggleValue = @ToggleValue;

      IF @WhatToReturn = 'MAX'
        SELECT @result = Isnull(CAST(JCMS.MaxValue AS VARCHAR(21)), '')
        FROM   tblJudgingCriteriaMaxScores JCMS
        WHERE  JudgingCriteriaID = @JudgingCriteriaID
               AND LevelID = @LevelID
               AND ToggleValue = @ToggleValue;

      IF @WhatToReturn = 'DEFAULT'
        SELECT @result = Isnull(CAST(JCMS.DefaultValue AS VARCHAR(21)), '')
        FROM   tblJudgingCriteriaMaxScores JCMS
        WHERE  JudgingCriteriaID = @JudgingCriteriaID
               AND LevelID = @LevelID
               AND ToggleValue = @ToggleValue;

      IF @WhatToReturn = 'STRING'
        SELECT @result = Isnull(CAST(JCMS.MinValue AS VARCHAR(21)), '') + ' - ' + Isnull(CAST(JCMS.MaxValue AS VARCHAR(21)), '')
        FROM   tblJudgingCriteriaMaxScores JCMS
        WHERE  JudgingCriteriaID = @JudgingCriteriaID
               AND LevelID = @LevelID
               AND ToggleValue = @ToggleValue;

      RETURN @result
  END


