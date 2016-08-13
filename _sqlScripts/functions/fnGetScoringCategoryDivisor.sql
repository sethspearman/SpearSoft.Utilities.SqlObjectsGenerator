

CREATE FUNCTION [dbo].[fnGetScoringCategoryDivisor] ( @ScoringCategoryID INT, @LevelID int)
RETURNS INT 
AS BEGIN

    DECLARE @return INT ;
    
    SELECT @return = Divisor FROM tblScoringCategoryDivisors WHERE ScoringCategoryID=@ScoringCategoryID AND LevelID=@LevelID
    
	RETURN ISNULL(@return,-1)

   END


