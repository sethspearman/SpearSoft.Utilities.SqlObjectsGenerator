

CREATE FUNCTION [dbo].[fnGetConfigOption] ( @OptionName nvarchar(100), @ReturnIfNull nvarchar(100))
RETURNS nvarchar(100)
AS  BEGIN
 
    DECLARE @OptionValue nvarchar(100);
	SET @OptionValue=IsNull((SELECT TOP 1 OptionValue FROM usystblOptions WHERE OptionName=@OptionName),@ReturnIfNull);
    RETURN @OptionValue
    
   END


