

CREATE PROCEDURE [dbo].[FillProgramChampionsTable]
    @EventID INT,
    @MinSmallTeams INT,
    @MinLargeTeams INT,
    @ErrMessage VARCHAR(1000) = '' OUTPUT
AS 
    BEGIN
	
	DECLARE @DropHiLo BIT;
	SET @DropHiLo=dbo.fnGetDropHiLoConfigOption ();	
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;
	
	--Step-1 : Delete from usysProgramChampions.
        DELETE  FROM dbo.usysProgramChampions ;

	--Get customers with gym size (select only customers with size >= @MinSmallTeams)
        SELECT  cs.CustomerNumber,
                CASE WHEN COUNT(trd.RegistrationDivisionID) >= @MinLargeTeams
                     THEN 'Large'
                     ELSE 'Small'
                END AS LargeOrSmallGym
        INTO    #customers
        FROM    tblCustomers AS cs
                INNER JOIN tblRegistrations AS tr ON cs.CustomerNumber = tr.CustomerNumber
                INNER JOIN tblRegistrationDivisions AS trd ON tr.RegistrationID = trd.RegistrationID
                INNER JOIN tblDivisions AS td ON td.DivisionID = trd.DivisionID
        WHERE   tr.EventID = @EventID
                AND td.EventPanelTypeID = 1
        GROUP BY cs.CustomerNumber
        HAVING  COUNT(trd.RegistrationDivisionID) >= @MinSmallTeams ;

	-- FIND for each customer all score
        SELECT  cs.CustomerNumber,
                dbo.fnGetEventScore(trd.RegistrationDivisionID, CAST((SELECT OptionValue FROM usystblOptions WHERE OptionName='CurrentDay') as tinyint), 0.0, 0.0,@DropHiLo) AS Score,
                dbo.fnGetDayScore1(dbo.fnGetEventTurnID (trd.RegistrationDivisionID, 2),@DropHiLo) AS Day2Score,
                cst.LargeOrSmallGym
        INTO    #probablechamps
        FROM    tblCustomers AS cs
                INNER JOIN #customers AS cst ON cs.CustomerNumber = cst.CustomerNumber
                INNER JOIN tblRegistrations AS tr ON cs.CustomerNumber = tr.CustomerNumber
                INNER JOIN tblRegistrationDivisions AS trd ON tr.RegistrationID = trd.RegistrationID
                INNER JOIN tblDivisions AS td ON trd.DivisionID = td.DivisionID
        WHERE   tr.EventID = @EventID
                AND td.EventPanelTypeID=1
	
	-- Insert only TOP 3 scores for each customer and insert into usysProgramChampions table
        INSERT  INTO usysProgramChampions
                (
                  CustomerNumber,
                  Score,
                  Day2Score,
                  LargeOrSmallGym 
                )
                SELECT  CustomerNumber,
                        Score,
                        Day2Score,
                        LargeOrSmallGym
                FROM    ( SELECT    *,
                                    ROW_NUMBER() OVER ( PARTITION BY CustomerNumber ORDER BY Score DESC, Day2Score DESC ) AS Row
                          FROM      #probablechamps
                        ) AS A
                WHERE   A.Row <= 3

        DROP TABLE #customers ;
        DROP TABLE #probablechamps ;
    END


