

CREATE PROCEDURE dbo.usp_insert_update_tblScoringCategoryDivisors
	@ScoringCategoryDivisorID int,
    @ScoringCategoryID int,
	@LevelID int,
	@Divisor tinyint,
    @skipUpdate bit = NULL
AS 
    BEGIN
   
        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS (SELECT 1 FROM tblScoringCategoryDivisors WHERE ScoringCategoryDivisorID = @ScoringCategoryDivisorID)  

                INSERT INTO dbo.tblScoringCategoryDivisors (
                    ScoringCategoryDivisorID,
                    ScoringCategoryID,
                    LevelID,
                    Divisor ) 
                    VALUES (
                    @ScoringCategoryDivisorID,
                    @ScoringCategoryID,
                    @LevelID,
                    @Divisor )

        ELSE --INSERT
            IF @skipUpdate=0 --UPDATE
                UPDATE dbo.tblScoringCategoryDivisors SET
                        ScoringCategoryID = @ScoringCategoryID,
                        LevelID = @LevelID,
                        Divisor = @Divisor
                    WHERE
                        ScoringCategoryDivisorID = @ScoringCategoryDivisorID
                
    END

