

CREATE PROCEDURE [dbo].[getJudgeType]
    @EventTurnID INT,
    @JudgeID INT,
	@Result nvarchar(50) OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--DECLARE variable to hold information on JudgeType, initialized by default to NULL value
        DECLARE @JudgeType VARCHAR(50) ;

	--Copy database information into variable @JudgeType;
        SELECT  @JudgeType = epj.JudgeType
        FROM    tblEventTurns AS et
                INNER JOIN tblEventPanels AS ep ON et.EventPanelID = ep.EventPanelID
                                                   AND et.EventTurnID = @EventTurnID
                INNER JOIN tblEventPanelJudges AS epj ON ep.EventPanelID = epj.EventPanelID
                                                         AND epj.JudgeID = @JudgeID ;

	--RETURN the value in the variable @JudgeType as result
	--Returns NULL if no matching record is found
		SET @Result = @JudgeType ;
		RETURN
    END


