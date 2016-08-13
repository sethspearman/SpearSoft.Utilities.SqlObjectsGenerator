

CREATE FUNCTION [dbo].[fnGetEventScore]
    (
      @RegistrationDivisionID INT,
      @EventDay TINYINT,
      @Day1Weight MONEY,
      @Day2Weight MONEY,
	  @DropHiLo BIT
    )
RETURNS MONEY
AS BEGIN

	--DECLARE variable to hold information on EventTurnID, initialized by default to NULL value
    DECLARE @EventTurnID INT ;
	
    DECLARE @FinalScore MONEY ;
    DECLARE @TempScore MONEY ;
    DECLARE @OneDayEvent bit ;

    SET @OneDayEvent = 
        (
            SELECT e.OneDay 
            FROM tblEvents e 
                INNER JOIN tblRegistrations r ON e.EventID = r.EventID
                INNER JOIN tblRegistrationDivisions rd ON r.RegistrationID = rd.RegistrationID
            WHERE 
                rd.RegistrationDivisionID = @RegistrationDivisionID
        )
        

        
	--IF both @Day1Weight=@Day2Weight=0.0 then it means use default values from table usysGlobalParams.
    IF ( @Day1Weight = 0.0
         AND @Day2Weight = 0.0
       ) 
        SELECT  @Day1Weight = Day1Weight,
                @Day2Weight = Day2Weight
        FROM    dbo.usysGlobalParams
        WHERE   ParamId = 1

    IF @OneDayEvent = 1 
        SET @Day1Weight = 1
	
	--if day =1 then get event turn for that day and use it to calkculate final score
    IF ( @EventDay >= 1 ) -- Day 1
        BEGIN
            SELECT  @EventTurnID = dbo.fnGetEventTurnID(@RegistrationDivisionID,1)
            SELECT  @TempScore = [dbo].[fnGetDayScore1](@EventTurnID, @DropHiLo) ;
            SET @FinalScore = @TempScore * @Day1Weight ;
        END

	-- if day =2 then get event turn for that day and use it to calculate final score
	-- if day is too add to final score fron day1

    IF ( @EventDay >= 2 ) -- Day 2
        BEGIN
            SELECT  @EventTurnID = dbo.fnGetEventTurnID(@RegistrationDivisionID,2)
            SELECT  @TempScore = [dbo].[fnGetDayScore1](@EventTurnID, @DropHiLo) ;
            SET @FinalScore = @FinalScore + ( @TempScore * @Day2Weight ) ;
        END
	
	-- return final score or 0 if null
    RETURN ISNULL(@FinalScore, 0) ;
   END


