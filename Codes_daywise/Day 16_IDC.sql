-- Day 16 - IDC 21days Challenge

/*
Find all patients who were admitted to 
services that had at least one week where patients were refused 
AND the average patient satisfaction for that service was below the overall hospital average satisfaction. 
Show patient_id, name, service, and their personal satisfaction score.
*/

SELECT 
`patient_id`, `name`, `service`, `satisfaction`
FROM patients
WHERE `satisfaction` > (SELECT AVG(`satisfaction`) FROM patients)
	AND `service` IN (SELECT DISTINCT `service` FROM services_weekly WHERE`patients_refused` > 0);
    
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice    
-- 1. Find patients who are in services with above-average staff count.

SELECT 
*
FROM patients
WHERE `service` IN
	( -- This subquery will give the SERVICE where count of staff_id > avg_staff_count, (here is only ICU)
	SELECT 
	`service`
	FROM staff
	GROUP BY `service`
	HAVING COUNT(`staff_id`) >(-- this sub query will return the overall avg of counts which we get from servicewise
								SELECT AVG(`staff count`) AS 'avg_staff_count'
								FROM( -- This subquery will return servicewise staff count
									SELECT 
									`service`,COUNT(`staff_id`) AS 'staff count'
									FROM staff
									GROUP BY `service`
									)AS t
							)
		);

-- 2. List staff who work in services that had any week with patient satisfaction below 70.

SELECT * FROM staff
WHERE `service` IN
(
SELECT DISTINCT `service` FROM patients
WHERE `satisfaction` < 70
);

-- 3. Show patients from services where total admitted patients exceed 1000.
SELECT * FROM patients
WHERE `service` IN (
SELECT `service` FROM services_weekly
GROUP BY `service`
HAVING SUM(`patients_admitted`) > 1000);
