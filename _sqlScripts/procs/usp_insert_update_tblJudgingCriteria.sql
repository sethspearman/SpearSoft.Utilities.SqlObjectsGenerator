

if object_id(dbo.usp_insert_update_tblJudgingCriteria) is not null
	drop procedure dbo.usp_insert_update_tblJudgingCriteria




CREATE PROCEDURE dbo.usp_insert_update_tblJudgingCriteria
	@JudgingCriteriaID int,
    @ScoringCriteriaTypeID int,
	@CriteriaName nvarchar(50),
	@MaxValue money,
	@Cheer bit,
	@Dance bit,
	@Order int,
	@CopyToDay2 bit,
	@IncludeExecution bit,
	@GroupingName nvarchar(50),
	@ScoringCategoryID int,
	@CategoryName nvarchar(50),
	@ScoreFormula nvarchar(1000),
	@PercentOfTotal money,
	@HideFromJudges bit,
	@PivotColumnMapping varchar(15),
	@Abbreviation varchar(10),
    @skipUpdate bit = NULL
AS 
    BEGIN
   
        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS (SELECT 1 FROM tblJudgingCriteria WHERE JudgingCriteriaID = @JudgingCriteriaID)  

                INSERT INTO dbo.tblJudgingCriteria (
                    JudgingCriteriaID,
                    ScoringCriteriaTypeID,
                    CriteriaName,
                    MaxValue,
                    Cheer,
                    Dance,
                    [Order],
                    CopyToDay2,
                    IncludeExecution,
                    GroupingName,
                    ScoringCategoryID,
                    CategoryName,
                    ScoreFormula,
                    PercentOfTotal,
                    HideFromJudges,
                    PivotColumnMapping,
                    Abbreviation
                ) VALUES (
                    @JudgingCriteriaID,
                    @ScoringCriteriaTypeID,
                    @CriteriaName,
                    @MaxValue,
                    @Cheer,
                    @Dance,
                    @Order,
                    @CopyToDay2,
                    @IncludeExecution,
                    @GroupingName,
                    @ScoringCategoryID,
                    @CategoryName,
                    @ScoreFormula,
                    @PercentOfTotal,
                    @HideFromJudges,
                    @PivotColumnMapping,
                    @Abbreviation
                )

        ELSE --INSERT
            IF @skipUpdate=0 --UPDATE
                UPDATE dbo.tblJudgingCriteria SET
                        ScoringCriteriaTypeID = @ScoringCriteriaTypeID,
                        CriteriaName = @CriteriaName,
                        MaxValue = @MaxValue,
                        Cheer = @Cheer,
                        Dance = @Dance,
                        [Order] = @Order,
                        CopyToDay2 = @CopyToDay2,
                        IncludeExecution = @IncludeExecution,
                        GroupingName = @GroupingName,
                        ScoringCategoryID = @ScoringCategoryID,
                        CategoryName = @CategoryName,
                        ScoreFormula = @ScoreFormula,
                        PercentOfTotal = @PercentOfTotal,
                        HideFromJudges = @HideFromJudges,
                        PivotColumnMapping = @PivotColumnMapping,
                        Abbreviation = @Abbreviation
                    WHERE
                        JudgingCriteriaID = @JudgingCriteriaID
                
    END


-- grant execute on usp_insert_update_tblJudgingCriteria to myUser
