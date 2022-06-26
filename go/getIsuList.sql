WITH con AS (
	SELECT 
		`latest_time`, 
		`is_sitting`, 
		`condition`, 
		`message`, 
		`created_at`,
		isu_condition.jia_isu_uuid
	FROM isu_condition
	JOIN (
		SELECT jia_isu_uuid, max(timestamp) as latest_time from isu_condition
		group by jia_isu_uuid
	) newcon
	on isu_condition.jia_isu_uuid = newcon.jia_isu_uuid
	where isu_condition.timestamp = newcon.latest_time
)

SELECT 
	id, 
	isu.jia_isu_uuid, 
	isu.name, 
	isu.character,
	latest_time as timestamp,
	is_sitting,
	`condition`,
	`message`,
	c.created_at,
	updated_at
FROM isu
LEFT OUTER JOIN con as c
ON isu.jia_isu_uuid = c.jia_isu_uuid
WHERE jia_user_id = ?
ORDER BY id DESC