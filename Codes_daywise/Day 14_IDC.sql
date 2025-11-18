-- Day 14 - IDC 21days Challenge

/*
Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) 
and the count of weeks they were present (from staff_schedule). 
Include staff members even if they have no schedule records. 
Order by weeks present descending.
*/
USE hospital;

SELECT
s.`staff_id`, s.`staff_name`, s.`role`, s.`service`, COUNT(sc.`week`) AS 'No of weeks present'
FROM
staff AS s
LEFT JOIN 
staff_schedule AS sc
ON s.`staff_id` = sc.`staff_id`
WHERE sc.`present` = 1 OR sc.`present` IS NULL 
GROUP BY s.`staff_id`, s.`staff_name`, s.`role`, s.`service`
ORDER BY `No of weeks present` DESC;



-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice
-- 1. Show all staff members and their schedule information (including those with no schedule entries).

SELECT
s.`staff_id`, s.`staff_name`, s.`role`, s.`service`, sc.`week`,sc.`present`
FROM
staff AS s
LEFT JOIN 
staff_schedule AS sc
USING(`staff_id`);

-- 2. List all services from services_weekly and their corresponding staff (show services even if no staff assigned).
SELECT
w.`week`, w.`month`, w.`available_beds`, w.`patients_request`, w.`patients_admitted`, w.`patients_refused`, 
w.`patient_satisfaction`, w.`staff_morale`, w.`event`, s.`staff_id`, s.`staff_name`, s.`role`,w.`service`
FROM
services_weekly AS w
LEFT JOIN 
staff AS s
USING(`service`);


-- 3. Display all patients and their service's weekly statistics (if available).
SELECT
p.`patient_id`,p.`name`,p.`age`,p.`service`,w.`week`, w.`month`, w.`available_beds`, w.`patients_request`, w.`patients_admitted`, w.`patients_refused`, 
w.`patient_satisfaction`, w.`staff_morale`, w.`event`
FROM 
patients AS p
LEFT JOIN
services_weekly AS w
USING(`service`)
ORDER BY p.`patient_id`,w.`week`;
