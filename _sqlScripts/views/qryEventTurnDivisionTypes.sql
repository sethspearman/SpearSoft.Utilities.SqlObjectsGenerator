

CREATE VIEW dbo.qryEventTurnDivisionTypes
AS  SELECT  dbo.tblEventTurns.EventTurnID,
            dbo.tblDivisions.EventPanelTypeID
    FROM    dbo.tblDivisions
            INNER JOIN dbo.tblRegistrationDivisions ON dbo.tblDivisions.DivisionID = dbo.tblRegistrationDivisions.DivisionID
            INNER JOIN dbo.tblEventTurns ON dbo.tblRegistrationDivisions.RegistrationDivisionID = dbo.tblEventTurns.RegistrationDivisionID


