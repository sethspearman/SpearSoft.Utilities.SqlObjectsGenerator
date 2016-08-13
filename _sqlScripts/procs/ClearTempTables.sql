

CREATE PROCEDURE [dbo].[ClearTempTables]
    @password nvarchar(50)
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;

		if @password='ALLOWDELETE'
			BEGIN
				DELETE FROM usysScoring
				DELETE FROM usysStatus
				DELETE FROM usysScoringValidation
			END
    END


