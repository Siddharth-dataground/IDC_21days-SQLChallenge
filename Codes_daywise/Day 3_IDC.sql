-- Day 3 - IDC 21days Challenge

/*
Retrieve the top 5 weeks with the highest patient refusals across all services, 
showing week, service, patients_refused, and patients_request. Sort by patients_refused in descending order.
*/
USE hospital;

SELECT
`week`, 
GROUP_CONCAT(`service` SEPARATOR ' , ') AS 'Services_across_week', 
SUM(`patients_refused`) AS 'Total_Patients_Refused', SUM(`patients_request`) AS 'Total_Patients_Request'
FROM 
services_weekly
GROUP BY `week`
ORDER BY SUM(`patients_refused`) DESC
LIMIT 5;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice

-- 1. List all patients sorted by age in descending order.
SELECT
*
FROM
patients
ORDER BY `age` DESC;

-- 2. Show all services_weekly data sorted by week number ascending and patients_request descending.
SELECT
*
FROM 
services_weekly
ORDER BY `week` ASC, `patients_request` DESC;

-- 3. Display staff members sorted alphabetically by their names.
SELECT
*
FROM 
staff
ORDER BY `staff_name`; -- In this it will order by default in ASC order. So first A then B and so on...
