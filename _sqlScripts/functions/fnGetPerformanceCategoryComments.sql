

CREATE FUNCTION [dbo].[fnGetPerformanceCategoryComments] ( @EventTurnID int, @ScoringCategoryID int )
RETURNS nvarchar(MAX)
AS 
BEGIN

	DECLARE @retval nvarchar(MAX) ;
	SET @retval = ''

	IF dbo.fnGetConfigOption ('SHOW_COMMENTS_ON_MASTER_REPORT','false') = 'false'
		SET @retval = Null ;
	ELSE
		BEGIN
	    
			DECLARE @CRLF char(2) ;
			SET @CRLF = CHAR(13) + CHAR(10) ;
            SET @retval = 'JUDGE COMMENTS:  ' + @CRLF ;
			SELECT @retval = @retval + etjc.Comments + @CRLF
			FROM tblEventTurnJudgeComments etjc
			WHERE EventTurnJudgeID IN  (SELECT EventTurnJudgeID 
										FROM tblEventTurnJudge 
										WHERE EventTurnID = @EventTurnID)
				AND ScoringCategoryID = @ScoringCategoryID ; 
		END
	RETURN @retval 
END  


