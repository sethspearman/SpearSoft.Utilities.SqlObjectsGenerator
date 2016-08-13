

CREATE PROCEDURE [dbo].[usp_IsDeductionJudge]
    @EventTurnID INT,
    @JudgeID INT,
	@IsDeductionJudge bit OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;
        
            SET @IsDeductionJudge = 
                (
                    SELECT jt.Deduction 
                        FROM tblEventTurns et
                            INNER JOIN tblEventPanelJudges epj
                                ON et.EventPanelID=epj.EventPanelID
                            INNER JOIN tblJudgeTypes jt
                                ON epj.JudgeTypeID=jt.JudgeTypeID
                        WHERE epj.JudgeID=@JudgeID 
                            AND et.EventTurnID=@EventTurnID
                )
              
        SET @IsDeductionJudge=ISNULL(@IsDeductionJudge,0)

    END


