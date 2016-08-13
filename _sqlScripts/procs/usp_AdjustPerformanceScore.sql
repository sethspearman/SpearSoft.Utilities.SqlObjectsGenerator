

CREATE PROCEDURE [dbo].[usp_AdjustPerformanceScore] @EventTurnID       INT,
                                                    @JudgingCriteriaID INT
AS
  BEGIN
      DECLARE @categoryEventTurnJudgeID INT;
      DECLARE @levelID INT;
      DECLARE @OLD_VALUES TABLE (
        EventTurnJudgeScoreID INT,
        MinValue              MONEY,
        MaxValue              MONEY,
        Score                 MONEY,
        MaxExec               MONEY,
        MinExec               MONEY,
        Execution             MONEY);

      --first grab the old value into a temp table which will be used in the update statement
      INSERT INTO @OLD_VALUES
                  (EventTurnJudgeScoreID,
                   MinValue,
                   MaxValue,
                   Score,
                   MaxExec,
                   MinExec,
                   execution)
      SELECT EventTurnJudgeScoreID,
             MinValue,
             MaxValue,
             Score,
             MaxExec,
             MinExec,
             execution
      FROM   tblEventTurnJudgeScores
      WHERE  JudgingCriteriaID = @JudgingCriteriaID
             AND EventTurnJudgeID IN (SELECT etj.EventTurnJudgeID
                                      FROM   tblEventTurnJudge etj
                                      WHERE  etj.EventTurnID = @EventTurnID)

      --update the ranges
      --first get the event turn judge id of the category judge
      --this should return only one record anyway but just in case use top 1
      SELECT TOP 1 @categoryEventTurnJudgeID = etjsv.EventTurnJudgeID,
                   @levelID = etjsv.LevelID
      FROM   dbo.tblEventTurnJudgeStartValues etjsv
      WHERE  JudgingCriteriaID = @JudgingCriteriaID
             AND etjsv.EventTurnJudgeID IN (SELECT etj.EventTurnJudgeID
                                            FROM   tblEventTurnJudge etj
                                            WHERE  etj.EventTurnID = @EventTurnID)

      EXEC usp_UpdateEventTurnJudgeScoreRangesOnly
        @categoryEventTurnJudgeID,
        @judgingCriteriaID,
        @levelID

      --at this point the ranges are updated with the new values.  MinValue and MaxValue and DefaultValue
      --but not the scores....use a update statement for the score.
      UPDATE tblEventTurnJudgeScores
      SET    Score = dbo.fnGetNewEventTurnJudgeScore (old.MinValue, old.MaxValue, old.Score, etjs.MinValue, etjs.MaxValue)
      FROM   tblEventTurnJudgeScores etjs
             INNER JOIN @OLD_VALUES old
               ON etjs.EventTurnJudgeScoreID = old.EventTurnJudgeScoreID

      --now do the same thing for the execution score...but only if it has changed.
      IF (SELECT TOP 1 etjs.MinExec - old.MinExec AS DIFFERENCE
          FROM   tblEventTurnJudgeScores etjs
                 INNER JOIN @OLD_VALUES old
                   ON etjs.EventTurnJudgeScoreID = old.EventTurnJudgeScoreID) <> 0
        UPDATE tblEventTurnJudgeScores
        SET    Execution = dbo.fnGetNewEventTurnJudgeScore (old.MinExec, old.MaxExec, old.Execution, etjs.MinExec, etjs.MaxExec)
        FROM   tblEventTurnJudgeScores etjs
               INNER JOIN @OLD_VALUES old
                 ON etjs.EventTurnJudgeScoreID = old.EventTurnJudgeScoreID
  END


