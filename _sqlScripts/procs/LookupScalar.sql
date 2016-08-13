

if object_id(dbo.LookupScalar) is not null
	drop procedure dbo.LookupScalar




CREATE PROCEDURE [dbo].[LookupScalar]
    @FieldName VARCHAR(200),
    @TableName VARCHAR(200),
    @WhereClause VARCHAR(1000) = ''
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;
	
	--declare large memoery space to hold sql string in memory
        DECLARE @Sql VARCHAR(2000) ;
	
	--prepare sql string for execution
        SET @Sql = 'SELECT TOP 1 ' + @FieldName + ' FROM ' + @TableName
            + ' WHERE 1 = 1 ' ;
        IF ( LEN(LTRIM(RTRIM(( @WhereClause )))) > 0 ) 
            SET @Sql = @Sql + ' AND ' + @WhereClause

	--excuet the sql query and return result
        EXEC (@Sql) ;
	
    END



-- grant execute on LookupScalar to myUser
