

CREATE PROCEDURE dbo.usp_insert_update_tblJudgeTypes
	@JudgeTypeID int,
	@JudgeType nvarchar(50),
	@CategoryScoring bit,
	@Non_Cheer bit,
	@Deduction bit,
    @skipUpdate bit = NULL
AS 
    BEGIN
   
        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS (SELECT 1 FROM tblJudgeTypes WHERE JudgeTypeID = @JudgeTypeID)  

                INSERT INTO dbo.tblJudgeTypes (
                    JudgeTypeID,
                    JudgeType,
                    CategoryScoring,
                    Non_Cheer,
                    Deduction ) 
                    VALUES (
                    @JudgeTypeID,
                    @JudgeType,
                    @CategoryScoring,
                    @Non_Cheer,
                    @Deduction )

        ELSE --INSERT
            IF @skipUpdate=0 --UPDATE
                UPDATE dbo.tblJudgeTypes SET
                        JudgeType = @JudgeType,
                        CategoryScoring = @CategoryScoring,
                        Non_Cheer = @Non_Cheer,
                        Deduction = @Deduction
                    WHERE
                        JudgeTypeID = @JudgeTypeID
                
    END

