-- Day 6 - IDC 21days Challenge

/*
For each hospital service, calculate the total number of patients admitted, total patients refused, and the admission rate (percentage of requests that were admitted). 
Order by admission rate descending.
*/
USE hospital;

SELECT
service,
SUM(`patients_admitted`) AS 'Total_patients_admitted',
SUM(`patients_refused`) AS 'Total_patients_refused',
ROUND((SUM(`patients_admitted`) / SUM(`patients_request`))*100,2) AS 'Admission_rate'
FROM
services_weekly
GROUP BY `service`
ORDER BY Admission_rate DESC;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice
-- 1. Count the number of patients by each service.
SELECT
`service`,COUNT(`patient_id`) AS 'Count_of_patients'
FROM
patients
GROUP BY `service`;

-- 2. Calculate the average age of patients grouped by service.
SELECT
`service`,
ROUND(AVG(`age`),2) AS 'avg_age_of_patients'
FROM
patients
GROUP BY `service`;

-- 3. Find the total number of staff members per role.
SELECT
`role`, COUNT(`staff_id`) AS 'count_of_staff'
FROM
staff
GROUP BY `role`;
