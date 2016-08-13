

CREATE FUNCTION [dbo].[fnGetEventTurnDeductionJudgeIDs] ( @EventTurnID INT )
RETURNS TABLE
AS RETURN
    (	
	--Returns 0 if no matching record is found
      SELECT TOP 1
                JudgeID
      FROM      ( SELECT    etj.JudgeID,
                            1 AS ORD
                  FROM      tblEventTurnJudge AS etj
                            INNER JOIN tblEventTurnJudgeDeductions AS etjd ON etj.EventTurnJudgeID = etjd.EventTurnJudgeID
                  WHERE     etj.EventTurnID = @EventTurnID
                  UNION
                  SELECT    0 AS JudgeID,
                            0 AS ORD
                ) AS T
      ORDER BY  T.ORD DESC
    )


