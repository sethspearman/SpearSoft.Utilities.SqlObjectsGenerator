

CREATE VIEW dbo.qryGetGrandChampions
AS  SELECT  td.DivisionID,
            trd.RegistrationDivisionID,
            sc.ScoringCriteriaType AS DivisionType,
            dbo.fnGetDayScore2(trd.RegistrationDivisionID, 1,0) AS Day1Score,
            dbo.fnGetDayScore2(trd.RegistrationDivisionID, 2,0) AS Day2Score,
            dbo.fnGetEventScore(trd.RegistrationDivisionID, 2, 0.0, 0.0,0) AS EventScore,
            tr.EventID
    FROM    dbo.tblDivisions AS td
            INNER JOIN dbo.tblRegistrationDivisions AS trd ON td.DivisionID = trd.DivisionID
            INNER JOIN dbo.tblScoringCriteriaTypes AS sc ON td.ScoringCriteriaTypeID = sc.ScoringCriteriaTypeID
            INNER JOIN dbo.tblRegistrations AS tr ON trd.RegistrationID = tr.RegistrationID
            INNER JOIN dbo.tblCustomers AS cs ON tr.CustomerNumber = cs.CustomerNumber
    WHERE   ( td.ScoringCriteriaTypeID = 2 )


