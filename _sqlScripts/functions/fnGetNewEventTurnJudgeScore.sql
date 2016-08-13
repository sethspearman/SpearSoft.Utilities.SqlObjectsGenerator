

CREATE FUNCTION [dbo].[fnGetNewEventTurnJudgeScore] (@oldMinValue MONEY,
                                                     @oldMaxValue MONEY,
                                                     @curScore    MONEY,
                                                     @curMinValue MONEY,
                                                     @curMaxValue MONEY)
RETURNS MONEY
AS
  BEGIN
      DECLARE @newScore MONEY;
      DECLARE @maxRange MONEY;
      DECLARE @distanceToMax MONEY;
      DECLARE @percentOfMax MONEY;

      IF ( @curMaxValue - @curMinValue ) = 0   --if the set to 0s button was clicked then return 0
        RETURN 0

      SET @maxRange = @oldMaxValue - @oldMinValue;

      IF @maxRange = 0 --PREVENTS A DIVIDE BY ZERO ERROR.  THIS SHOULDN'T HAPPEN
        RETURN 0

      SET @distanceToMax = @curScore - @oldMinValue;
      SET @percentOfMax = @distanceToMax / @maxRange;
      SET @newScore = ROUND(@curMinValue + ( ( @curMaxValue - @curMinValue ) * @percentOfMax ),1);

      RETURN ISNULL(@newScore,0)
  END


