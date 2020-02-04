USE History

-- show the events in order of the difference between the
-- name and the description

SELECT
	EventName,
	Description,
	dbo.fnExtraText(EventName,Description) AS 'Extra text'
FROM
	tblEvent
ORDER BY
	'Extra text' DESC
