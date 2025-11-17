-- Day 13 - IDC 21days Challenge

/*
Create a comprehensive report showing patient_id, patient name, age, service, and the total number of staff members 
available in their service. Only include patients from services that have more than 5 staff members. 
Order by number of staff descending, then by patient name.
*/
USE hospital;

SELECT
p.`patient_id`,p.`name`,p.`age`,p.`service`, COUNT(s.`staff_id`) AS 'total_staff'
FROM
patients AS p
INNER JOIN
staff AS s
USING(service)
GROUP BY p.`patient_id`,p.`name`,p.`age`,p.`service`
HAVING COUNT(s.`staff_id`) >5
ORDER BY `total_staff` DESC, `name` ASC;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice
-- 1. Join patients and staff based on their common service field (show patient and staff who work in same service).
SELECT
s.`service`,s.`staff_name`,p.`patient_id`,p.`name`
FROM
patients AS p
INNER JOIN
staff AS s
USING(service)
ORDER BY `service`, `staff_name`; -- I ordered it sothat we can see for a service and its respective staff who are patients there

-- 2. Join services_weekly with staff to show weekly service data with staff information.
SELECT 
w.`week`, w.`month`, w.`available_beds`, w.`patients_request`, w.`patients_admitted`, 
w.`patients_refused`, w.`patient_satisfaction`, w.`staff_morale`, w.`event`, 
s.`staff_id`, s.`staff_name`, s.`role`,s.`service`
FROM
services_weekly AS w
INNER JOIN
staff AS s
USING(service);

-- 3. Create a report showing patient information along with staff assigned to their service.
SELECT
p.`patient_id`,p.`name`, p.`age`, p.`arrival_date`, p.`departure_date`, p.`service`, p.`satisfaction`, s.`staff_name`
FROM
patients AS p
INNER JOIN
staff AS s
USING(service);