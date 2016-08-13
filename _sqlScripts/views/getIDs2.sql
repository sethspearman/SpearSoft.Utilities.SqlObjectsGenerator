

if object_id(dbo.getIDs2) is not null
	drop view dbo.getIDs2



create view getIDs2
as

	select ep.EventPanelID, et.eventturnid,rd.registrationdivisionid,rd.TeamName, et.completed ,c.TeamSchoolName, c.CustomerNumber, d.divisionid,
			d.divisionname,d.EventPanelTypeID, dbo.fnGetEventTurnDeduction (et.EventTurnID) as Deduction,et.Day1or2, e.EventID, e.EventName
	from tblEventTurns et
		inner join tblRegistrationDivisions rd
			on et.registrationdivisionid=rd.registrationdivisionid
		inner join tblregistrations r
			on rd.registrationid=r.registrationid
		inner join tblCustomers c
			on r.CustomerNumber=c.CustomerNumber
		inner join tblDivisions d
			on rd.divisionid=d.divisionid
		inner join tblEventPanels ep
			on ep.EventPanelID = et.EventPanelID
		inner join tblEvents e
			on ep.EventID = e.EventID
	--show all performances but show the completed column so you can filter it out if you want.
	--where et.eventturnid in (select eventturnid from tbleventturns where completed=1)





-- grant execute on getIDs2 to myUser
