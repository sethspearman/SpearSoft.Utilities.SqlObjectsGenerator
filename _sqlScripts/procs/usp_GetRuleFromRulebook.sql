

if object_id(dbo.usp_GetRuleFromRulebook) is not null
	drop procedure dbo.usp_GetRuleFromRulebook




CREATE PROCEDURE [dbo].[usp_GetRuleFromRulebook] 
     @LevelID VARCHAR(3)
	,@Category VARCHAR(25)
	,@RuleNum VARCHAR(2)
	,@Subset1 VARCHAR(2) = '*'
	,@Subset2 VARCHAR(2) = '*'
    ,@Warning BIT = 0
	,@Result VARCHAR(5000) = '' OUTPUT
AS
BEGIN
	DECLARE @CRLF VARCHAR(5);
	SET @CRLF = CHAR(13) + CHAR(10);

	DECLARE @SEPARATOR VARCHAR(5);
	SET @SEPARATOR = ' | ';

	DECLARE @RuleID INT;
	SET @RuleID = (
			SELECT MAX(RuleID)
			FROM tblRuleBook
			WHERE LevelID = @LevelID
				AND Category = @Category
				AND RuleNum = @RuleNum
				AND Subset1 = @Subset1
				AND Subset2 = @Subset2
			)
	SET @Result = @LevelID + @SEPARATOR + @Category + @SEPARATOR + @RuleNum
    SET @Result = @Result + CASE WHEN @Subset1='*' THEN '' ELSE @SEPARATOR + @Subset1 END  
    SET @Result = @Result + CASE WHEN @Subset2='*' THEN '' ELSE @SEPARATOR + @Subset2 END 
    SET @Result = @Result + @CRLF
    SET @Result = @Result + CASE WHEN @Warning=1 THEN 'WARNING:  ' ELSE '' END 
    
	SELECT @Result = COALESCE(@Result + @CRLF + @CRLF, '') + [Rule]
	FROM tblRuleBook
	WHERE LevelID = @LevelID
		AND Category = @Category
		AND RuleNum = @RuleNum
		AND Subset1 = @Subset1
		AND RuleID <= @RuleID
        
    SET @Result = @Result + @CRLF
    
END


-- grant execute on usp_GetRuleFromRulebook to myUser
