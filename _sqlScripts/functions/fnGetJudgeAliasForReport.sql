

CREATE FUNCTION [dbo].[fnGetJudgeAliasForReport]
    (
      @EventTurnID INT,
      @JudgeID INT
    )
RETURNS NVARCHAR(15)
AS BEGIN

	--DECLARE variable to hold information on EventTurnID, initialized by default to NULL value
    DECLARE @EventPanelID INT ;
    DECLARE @EventPanelJudgeID INT ;
    DECLARE @JudgeAlias nvarchar(15) ; 
    DECLARE @LoopCounter int ;
    DECLARE @iNextRowId int ;
    DECLARE @iCurrentRowId int ;
    DECLARE @iLoopControl int ;
	DECLARE @DeductionJudgeID int ; 
    DECLARE @DeductionJudges table (JudgeID int) ;

    SET @EventPanelID = dbo.fnGetEventPanelID (@EventTurnID) ;
    SET @JudgeAlias =  'Deduction Judge'
    
    SET @EventPanelJudgeID = (SELECT TOP 1 EventPanelJudgeID FROM tblEventPanelJudges WHERE EventPanelID = @EventPanelID AND JudgeID=@JudgeID)
    
    SELECT @DeductionJudgeID = epj.JudgeID 
            FROM    tblEventTurns et
				INNER JOIN tblEventPanelJudges epj ON et.EventPanelID = epj.EventPanelID
				INNER JOIN tblJudgeTypes jt ON epj.JudgeTypeID = jt.JudgeTypeID
        WHERE et.EventTurnID=@EventTurnID 
            AND jt.Deduction=1  ;

    --INSERT INTO @PANEL
    
    SET @iLoopControl = 1 ;
	SET @LoopCounter = 1 ;
    
    SELECT @iNextRowId = MIN(EventPanelJudgeID)   --1050
        FROM tblEventPanelJudges
        WHERE EventPanelID=@EventPanelID
			AND JudgeID <> @DeductionJudgeID
        
        
-- Make sure the table has data.

    IF ISNULL(@iNextRowId,0) = 0
        BEGIN
			RETURN @JudgeAlias
        END        
        
    SELECT       @iCurrentRowId   = EventPanelJudgeID --1050
        FROM tblEventPanelJudges
        WHERE EventPanelID=@EventPanelID
            AND EventPanelJudgeID = @iNextRowID
            

    IF @iCurrentRowId = @EventPanelJudgeID --true
        BEGIN
            SET @JudgeAlias =  'Judge ' + cast(@LoopCounter as nvarchar(10))
			RETURN @JudgeAlias
        END    
        
    WHILE @iLoopControl = 1
       BEGIN
         -- This is where you perform your detailed row-by-row
         -- processing.    
         -- Reset looping variables.           
            SELECT   @iNextRowId = NULL ;
			SELECT @LoopCounter = @LoopCounter + 1          
            -- get the next iRowId
            SELECT @iNextRowID   = Min(EventPanelJudgeID) --1051
                FROM tblEventPanelJudges                         
                WHERE EventPanelID=@EventPanelID
					AND JudgeID <> @DeductionJudgeID
                    AND EventPanelJudgeID > @iCurrentRowId
                               

            -- did we get a valid next row id?
            IF ISNULL(@iNextRowId,0) = 0
                BEGIN
                    BREAK
                END         
                
            -- get the next row.
            SELECT  @iCurrentRowId =   EventPanelJudgeID
                FROM tblEventPanelJudges                         
                WHERE EventPanelID=@EventPanelID
                    AND EventPanelJudgeID = @iNextRowID
                    
                
            IF @iCurrentRowId = @EventPanelJudgeID
                BEGIN
                    SET @JudgeAlias =  'Judge ' + cast(@LoopCounter as nvarchar(10))
					BREAK
                END                        

        END            
            
	--Return eventturn id or 0 if null
    RETURN ISNULL(@JudgeAlias, 0) ;
	
   END


