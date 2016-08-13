

if object_id(dbo.rsp_PerformanceScoreSummaryReport) is not null
	drop procedure dbo.rsp_PerformanceScoreSummaryReport



 
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


-- grant execute on rsp_PerformanceScoreSummaryReport to myUser
