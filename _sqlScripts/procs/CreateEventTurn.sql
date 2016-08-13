

CREATE PROCEDURE [dbo].[CreateEventTurn]
    @EventTurnID INT,
    @JudgeID INT,
    @JudgeTypeID INT,
    @EventDay TINYINT,
    @ErrMessage VARCHAR(1000) = '' OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;
        
        DECLARE @ScoringCriteriaTypeID INT ;
        DECLARE @EventTurnJudgeID INT ;
        DECLARE @LevelID INT ;
        DECLARE @EventPanelID INT ; 
        DECLARE @EventPanelTypeID INT ;
        
        SET @EventPanelID = dbo.fnGetEventPanelID (@EventTurnID) ;
            --Step-1 : Check to see if the 1 or more records exists for the current EventTurnID and JudgeID in tblEventTurnJudge.If Not then insert into tblEventTurnJudge
            BEGIN TRY 
                -- Check to see if the 1 or more records exists for the current EventTurnID and JudgeID in tblEventTurnJudge.	
                IF NOT EXISTS ( SELECT  1
                                FROM    dbo.tblEventTurnJudge
                                WHERE   EventTurnID = @EventTurnID
                                        AND JudgeID = @JudgeID ) 
                    BEGIN
                        -- If Not then insert into tblEventTurnJudge
                        INSERT  INTO dbo.tblEventTurnJudge ( EventTurnID, JudgeID )
                        VALUES  (
                                  @EventTurnID,
                                  @JudgeID
                                ) ;
                    END

                --Step-2 : Get the EventTurnJudgeID by Selecting EventTurnID and JudgeID in that table.  (This gets the ID of the record that maybe was just created.)	
                SELECT  @EventTurnJudgeID = etj.EventTurnJudgeID
                FROM    dbo.tblEventTurnJudge AS etj
                WHERE   etj.EventTurnID = @EventTurnID
                        AND etj.JudgeID = @JudgeID
        
            END TRY 
            BEGIN CATCH
                SET @EventTurnJudgeID = 0 ;
            END CATCH
        
            IF ( ISNULL(@EventTurnJudgeID, 0) = 0 ) 
                BEGIN
                    --there was a problem.  could not create.
                    SET @ErrMessage = 'Could not create event turn.' ;
                    RETURN ;
                END

            BEGIN TRY
                SELECT  @LevelID = td.[Level],
                    @EventPanelTypeID = td.EventPanelTypeID
                FROM    dbo.tblDivisions AS td
                        INNER JOIN dbo.tblRegistrationDivisions AS tr ON td.DivisionID = tr.DivisionID
                        INNER JOIN dbo.tblEventTurns AS et ON tr.RegistrationDivisionID = et.RegistrationDivisionID
                WHERE   EventTurnID = @EventTurnID 
                                             
                SET @ScoringCriteriaTypeID = @JudgeTypeID 
                
                --next code block runs for scoring (non-deduction) judge
                IF ( @JudgeTypeID NOT IN (Select JudgeTypeID FROM tblJudgeTypes WHERE Deduction = 1) ) -- IN ('Deduction','Dance Deduction','Deductions','Dance Deductions','DanceDeductions','Cheer Deduction','Cheer Deductions','CheerDeductions')) ) 
                    BEGIN                    
                        IF NOT EXISTS (		SELECT  1
                                            FROM    tblEventTurnJudgeScores
                                            WHERE   EventTurnJudgeID = @EventTurnJudgeID ) 
                            AND EXISTS (	SELECT 1 FROM tblEventPanelJudges 
                                            WHERE EventPanelID = @EventPanelID 
                                                AND JudgeID=@JudgeID 
                                                AND PanelJudge=1 )	
                            BEGIN
                                --TODO:  for category scoring do not insert 0 into *Values columns...lookup and insert now.
                                INSERT  INTO tblEventTurnJudgeScores
                                        (
                                          JudgingCriteriaID,
                                          EventTurnJudgeID,
                                          IncludeExecution,
                                          GroupingName,
                                          Score,
                                          Execution,
                                          MaxValue,
                                          MinValue,
                                          DefaultValue,
                                          MaxExec,
                                          MinExec,
                                          DefaultExec
                                        )   --HIDE FROM JUDGES FIELD ADDED FOR 8.1 RELEASE.  BY HIDING THE VALUE BUT ALLOWING SOMETHING TO GO INTO THERE IT WILL ALLOW JUDGES TO VALIDATE I THINK.
                                        SELECT  jc.JudgingCriteriaID,
                                                @EventTurnJudgeID AS EventTurnJudgeID,
                                                jc.IncludeExecution,
                                                jc.GroupingName,
                                                CASE WHEN HideFromJudges = 1 THEN -1 ELSE NULL END as Score,
                                                CASE WHEN HideFromJudges = 1 THEN 0 ELSE NULL END as Execution,
                                                0 as MaxValue,
                                                0 as MinValue,
                                                0 as DefaultValue,
                                                0 as MaxExec,
                                                0 as MinExec,
                                                0 as DefaultExec
                                        FROM    tblJudgingCriteria AS jc
                                        -- ADDED FOR 10.0 RELEASE
                                        WHERE   jc.ScoringCriteriaTypeID = @ScoringCriteriaTypeID
                                            AND jc.JudgingCriteriaID IN 
                                                (SELECT JudgingCriteriaID
                                                    FROM tblEventPanelJudgeCategories epjc
                                                    WHERE jc.JudgingCriteriaID = epjc.JudgingCriteriaID
                                                        AND epjc.JudgeID = @JudgeID
                                                        AND epjc.EventPanelID = @EventPanelID
                                                )
                                            --ADDED FOR FIRST 11.0 RELEASE   (09-04-2013) 
                                            --THIS CLAUSE PREVENTS A JUDGING CRITERIA WITH A 0 MAX VALUE FROM BEING INSERTED INTO THE SCORING TABLE
                                            AND jc.JudgingCriteriaID IN 
                                                (SELECT DISTINCT JudgingCriteriaID
                                                    FROM tblJudgingCriteriaMaxScores jcms
                                                    WHERE jc.JudgingCriteriaID = jcms.JudgingCriteriaID
                                                        AND jcms.MaxValue <> 0
                                                        AND jcms.LevelId=@LevelId
                                                )                                                
                                        ORDER BY jc.[Order]
                                        
                                --insert the category comments for this judge.
                                IF NOT EXISTS ( SELECT 1 
                                                    FROM tblEventTurnJudgeComments
                                                    WHERE EventTurnJudgeID=@EventTurnJudgeID )
                                    BEGIN
                                        INSERT INTO tblEventTurnJudgeComments
                                                (
                                                    EventTurnJudgeID,
                                                    ScoringCategoryID
                                                )
                                                SELECT DISTINCT @EventTurnJudgeID AS EventTurnJudgeID,
                                                        jc.ScoringCategoryID
                                                FROM tblEventTurnJudgeScores etjs
                                                    INNER JOIN tblJudgingCriteria jc
                                                        on etjs.JudgingCriteriaID = jc.JudgingCriteriaID
                                                WHERE EventTurnJudgeID=@EventTurnJudgeID
                                    END                                             
                            END
                    END
                ELSE --if judgetype is Deduction insert values into tblEventTurnJudgeDeductions
                    BEGIN
                        IF NOT EXISTS ( SELECT  1
                                        FROM    tblEventTurnJudgeDeductions
                                        WHERE   EventTurnJudgeID = @EventTurnJudgeID ) 
                            BEGIN
                                INSERT  INTO tblEventTurnJudgeDeductions
                                        (
                                          DeductionID,
                                          EventTurnJudgeID,
                                          NumOccurrences,
                                          SafetyIssue 
                                        )
                                        SELECT  tds.DeductionID,
                                                @EventTurnJudgeID AS EventTurnJudgeID,
                                                0 AS NumOccurrences,
                                                0 AS SafetyIssue
                                        FROM    tblDeductionSystem AS tds
                                        WHERE   ( CASE @EventDay
                                                    WHEN 1 THEN tds.Day1
                                                    WHEN 2 THEN tds.Day2
                                                  END = 1 )
                                                AND tds.ScoringCriteriaTypeID = @ScoringCriteriaTypeID
                                        ORDER BY tds.[Order]
                            END
                    END
            END TRY
            BEGIN CATCH
                SET @ErrMessage = 'Could not create EventTurnJudge Deductions/Scoring' ;
                RETURN ;
            END CATCH
        
            --Step-4 : Insert into tblEventTurnJudgeStartValues if any matching exist in tblJudgeCommentsMASTER.
            IF NOT EXISTS ( SELECT  1
                            FROM    tblEventTurnJudgeStartValues
                            WHERE   EventTurnJudgeID = @EventTurnJudgeID ) 
                BEGIN
                
                    SET @EventPanelID=(
                                        SELECT TOP 1 et.EventPanelID 
                                            FROM tblEventTurns et
                                                inner join tblEventTurnJudge etj ON et.EventTurnID=etj.EventTurnID
                                            WHERE 
                                                etj.EventTurnJudgeID=@EventTurnJudgeID
                                      )
                    INSERT  INTO tblEventTurnJudgeStartValues
                            (
                                EventTurnJudgeID,
                                JudgingCriteriaID,
                                DifficultyToggle,
                                ExecutionToggle,
                                LevelID,
                                LockedIn
                            )
                            SELECT  @EventTurnJudgeID AS EventTurnJudgeID,
                                    epcj.JudgingCriteriaID,
                                    dbo.fnGetDifficultyStartValue(@EventTurnJudgeID, jc.JudgingCriteriaID, @JudgeID) AS DifficultyToggle,
                                    dbo.fnGetExecutionStartValue(@EventTurnJudgeID, jc.JudgingCriteriaID, @JudgeID) AS ExecutionToggle,
                                    dbo.fnGetLevelStartValue(@EventTurnJudgeID, jc.JudgingCriteriaID, @JudgeID, @LevelID) AS LevelID,
                                    jc.HideFromJudges
                            FROM    tblEventPanelCategoryJudges AS epcj
                                        INNER JOIN tblJudgingCriteria jc 
                                            ON epcj.JudgingCriteriaID=jc.JudgingCriteriaID
                                        INNER JOIN tblEventPanels ep
											ON epcj.EventPanelID=ep.EventPanelID
                            WHERE   epcj.JudgeID=@JudgeID
                                    AND epcj.EventPanelID=@EventPanelID
                                    AND ep.EventPanelTypeID=@EventPanelTypeID
                                    --ADDED FOR FIRST 11.0 RELEASE   (09-04-2013) 
                                    --THIS CLAUSE PREVENTS A JUDGING CRITERIA WITH A 0 MAX VALUE FROM BEING INSERTED INTO THE SCORING CATEGORIES TABLE
                                    AND epcj.JudgingCriteriaID IN 
                                        (SELECT DISTINCT JudgingCriteriaID
                                            FROM tblJudgingCriteriaMaxScores jcms
                                            WHERE epcj.JudgingCriteriaID = jcms.JudgingCriteriaID
                                                AND jcms.MaxValue <> 0
                                                AND jcms.LevelId=@LevelId
                                        )                                     
                            ORDER BY jc.[Order]
                            
                            IF dbo.fnIsWorlds(@EventTurnID)=1
                                UPDATE tblEventTurnJudgeStartValues SET DifficultyToggle=0, ExecutionToggle=0, LockedIn=0 WHERE EventTurnJudgeID=@EventTurnJudgeID 
                END

    END


