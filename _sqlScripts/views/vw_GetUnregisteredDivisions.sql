

if object_id(dbo.vw_GetUnregisteredDivisions) is not null
	drop view dbo.vw_GetUnregisteredDivisions




CREATE	VIEW [dbo].[vw_GetUnregisteredDivisions] 
AS
SELECT DISTINCT rd.DivisionID
	,d.DivisionName
	,r.EventID
	,d.EventPanelTypeID
FROM tblRegistrations r
INNER JOIN tblRegistrationDivisions rd ON r.RegistrationID = rd.RegistrationID
INNER JOIN tblDivisions d ON rd.DivisionID = d.DivisionID
INNER JOIN tblEventTurns et ON et.RegistrationDivisionID=rd.RegistrationDivisionID
WHERE NOT EXISTS (
		SELECT 1
		FROM tblRegistrations r2
		INNER JOIN tblRegistrationDivisions rd2 ON r2.RegistrationID = rd2.RegistrationID
		WHERE r2.EventID = r.EventID
			AND rd2.DivisionID = rd.DivisionID
		)


-- grant execute on vw_GetUnregisteredDivisions to myUser
