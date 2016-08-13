
 
CREATE PROCEDURE [dbo].[rsp_PerformanceScoreSummaryReport] 
    @EventTurnID INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    
    SELECT * FROM qryGetTabularScoringData
        WHERE EventTurnID = @EventTurnID
        ORDER BY JudgeAlias

END

