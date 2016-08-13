

CREATE PROCEDURE [dbo].[usp_insert_update_scoring_cat_divisors]
    @ScoringCategoryID INT,
    @LevelID INT,
    @Divisor tinyint,
    @skipUpdate bit = NULL
AS 
    BEGIN
   
        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS (SELECT 1 FROM tblScoringCategoryDivisors WHERE ScoringCategoryID=@ScoringCategoryID AND LevelID=@LevelID) 
            INSERT INTO tblScoringCategoryDivisors (ScoringCategoryID, LevelID, Divisor) VALUES (@ScoringCategoryID, @LevelID, @Divisor)        
        ELSE --INSERT
            IF @skipUpdate=0 --UPDATE
                UPDATE tblScoringCategoryDivisors SET Divisor=@Divisor WHERE ScoringCategoryID=@ScoringCategoryID AND LevelID=@LevelID
                
    END

