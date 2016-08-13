

if object_id(dbo.usp_insert_update_tblScoringCategories) is not null
	drop procedure dbo.usp_insert_update_tblScoringCategories




CREATE PROCEDURE dbo.usp_insert_update_tblScoringCategories
	@ScoringCategoryID int,
	@ScoringCriteriaTypeID int,
	@ScoringCategoryName nvarchar(50),
	@PercentOfTotal money,
	@PortionOfTen int,
    @skipUpdate bit = NULL
AS 
    BEGIN
   
        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS (SELECT 1 FROM tblScoringCategories WHERE ScoringCategoryID = @ScoringCategoryID)  

                INSERT INTO dbo.tblScoringCategories (
                    ScoringCategoryID,
                    ScoringCriteriaTypeID,
                    ScoringCategoryName,
                    PercentOfTotal,
                    PortionOfTen ) 
                    VALUES (
                    @ScoringCategoryID,
                    @ScoringCriteriaTypeID,
                    @ScoringCategoryName,
                    @PercentOfTotal,
                    @PortionOfTen )

        ELSE --INSERT
            IF @skipUpdate=0 --UPDATE
                UPDATE dbo.tblScoringCategories SET
                        ScoringCriteriaTypeID = @ScoringCriteriaTypeID,
                        ScoringCategoryName = @ScoringCategoryName,
                        PercentOfTotal = @PercentOfTotal,
                        PortionOfTen = @PortionOfTen
                    WHERE
                        ScoringCategoryID = @ScoringCategoryID
                
    END


-- grant execute on usp_insert_update_tblScoringCategories to myUser
