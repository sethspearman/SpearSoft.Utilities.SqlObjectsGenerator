

CREATE PROCEDURE [dbo].[GetHiLoEventTurnIDs]
	@EventTurnID INT,
	@HiID INT OUTPUT,
	@LoID INT OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

	--Call function to get score value.
	
			DECLARE @DeductionJudges TABLE ( JudgeID INT ) ;

			--Get the DeductionJudgeID using the getEventTurnDeductionJudgeID proc.
			INSERT  INTO @DeductionJudges
				SELECT  *
				FROM    [dbo].[fnGetEventTurnDeductionJudgeIDs](@EventTurnID) ; 
				
			DECLARE @Scores TABLE ( EventTurnJudgeID INT, CompositeScore MONEY ) 

			INSERT INTO @Scores
				SELECT EventTurnJudgeID, dbo.fnGetEventTurnJudgeScore ( etj.EventTurnJudgeID ) AS CompositeScore
					FROM dbo.tblEventTurnJudge AS etj
					WHERE   EventTurnID = @EventTurnID
                        AND JudgeID NOT IN ( 
                                            SELECT JudgeID 
                                            FROM   @DeductionJudges 
                                           ) 
                        AND JudgeID IN   (   SELECT JudgeID 
                                            FROM tblEventPanelJudges 
                                            WHERE PanelJudge=1 
                                            AND EventPanelID = dbo.fnGetEventPanelID ( @EventTurnID )
                                        );
					
				SET @HiID = (
                                SELECT TOP 1 EventTurnJudgeID 
                                FROM @Scores 
                                WHERE CompositeScore=(SELECT MAX(CompositeScore) FROM @Scores)
                            ) ;
								
				SET @LoID = (
                                SELECT TOP 1 EventTurnJudgeID 
                                FROM @Scores 
                                WHERE CompositeScore=(SELECT MIN(CompositeScore) FROM @Scores) AND EventTurnJudgeID<>@HiID
                            ) ;
				
				RETURN

    END


