

CREATE FUNCTION [dbo].[fnGetDropHiLoConfigOption] ()
RETURNS BIT
AS  BEGIN

    DECLARE @DropHiLo BIT;
	SET @DropHiLo=Cast(dbo.fnGetConfigOption('DropHiLo','True') as BIT);
    RETURN @DropHiLo
    
   END


