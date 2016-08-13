

CREATE FUNCTION [dbo].[fnGetScoringRangeString] ( @JudgingCriteriaID int, @LevelID int, @ToggleValue smallint )
RETURNS varchar(20)
AS BEGIN

    DECLARE @return varchar(20) ;
    
    DECLARE @startRange varchar(10) ;
    DECLARE @stopRange varchar(10) ;
    DECLARE @separator varchar(10) ;
    

    
    SELECT TOP 1 @startRange = CAST(ISNULL(jcms.MinValue,'') AS VARCHAR(10))
        ,@stopRange = CAST(ISNULL(jcms.MaxValue,'') AS VARCHAR(10)) 
    FROM tblJudgingCriteriaMaxScores jcms
    WHERE jcms.JudgingCriteriaID = @JudgingCriteriaID
        AND jcms.LevelID = @LevelID
        AND jcms.ToggleValue = @ToggleValue
    
    SET @separator = CASE WHEN @startRange='' OR @stopRange='' THEN '' ELSE ' - ' END ;    

    IF @separator=''
        SET @return = Null
    ELSE
        SET @return = @startRange + @separator + @stopRange

	return ISNULL(@return,'') --if you ever want to return something otherthan an empty string this is where you would do it.

   END


