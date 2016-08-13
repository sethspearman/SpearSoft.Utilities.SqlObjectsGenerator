


CREATE PROCEDURE [dbo].[GetDayScore1DeductionOnly] 
	@EventTurnID INT,
	@Result MONEY OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON ;

    DECLARE @Deductions MONEY ;
          
	-- Get average composite score from judges who are deductions judges
    SELECT  @Deductions = dbo.fnGetEventTurnDeduction ( @EventTurnID )  ;

	-- Return 0 if null else return calculated deductions.
    SET @Result=ISNULL(@Deductions, 0)
    RETURN @Result

    END


