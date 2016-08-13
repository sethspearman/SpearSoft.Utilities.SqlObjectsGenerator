

CREATE PROCEDURE dbo.usp_insert_update_tblDeductionSystem
	@DeductionID int,
    @ScoringCriteriaTypeID int,
	@DeductionName nvarchar(50),
	@Deduction money,
	@Definition nvarchar,
	@Order int,
	@SafetyIssue bit,
	@Day1 bit,
	@Day2 bit,
	@skipUpdate bit = NULL
AS 
    BEGIN
   
        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS (SELECT 1 FROM tblDeductionSystem WHERE DeductionID = @DeductionID)  

                INSERT INTO dbo.tblDeductionSystem (
                    DeductionID,
                    ScoringCriteriaTypeID,
                    DeductionName,
                    Deduction,
                    Definition,
                    [Order],
                    SafetyIssue,
                    Day1,
                    Day2 )
                    VALUES (
                    @DeductionID,
                    @ScoringCriteriaTypeID,
                    @DeductionName,
                    @Deduction,
                    @Definition,
                    @Order,
                    @SafetyIssue,
                    @Day1,
                    @Day2 )

        ELSE --INSERT
            IF @skipUpdate=0 --UPDATE
                UPDATE dbo.tblDeductionSystem SET
                        ScoringCriteriaTypeID = @ScoringCriteriaTypeID,
                        DeductionName = @DeductionName,
                        Deduction = @Deduction,
                        Definition = @Definition,
                        [Order] = @Order,
                        SafetyIssue = @SafetyIssue,
                        Day1 = @Day1,
                        Day2 = @Day2
                        
                    WHERE
                        DeductionID = @DeductionID
                
    END

