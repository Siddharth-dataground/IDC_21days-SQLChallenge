-- Day 7 - IDC 21days Challenge

/*
Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80. 
Show service name, total refused, and average satisfaction.
*/
USE hospital;

SELECT
`service`,
SUM(`patients_refused`) AS 'Total_patients_refused',
AVG(`patient_satisfaction`) AS 'Avg_patient_satisfaction'
FROM
services_weekly
GROUP BY `service`
HAVING `Total_patients_refused` >100 AND `Avg_patient_satisfaction` <80;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice

-- 1. Find services that have admitted more than 500 patients in total.
SELECT
`service`,
SUM(`patients_admitted`) AS 'Total_patients_admitted'
FROM
services_weekly
GROUP BY `service`
HAVING `Total_patients_admitted` >500;

-- 2. Show services where average patient satisfaction is below 75.
SELECT
`service`,
AVG(`patient_satisfaction`) AS 'Avg_patient_satisfaction'
FROM
services_weekly
GROUP BY `service`
HAVING `Avg_patient_satisfaction` < 75;

-- 3. List weeks where total staff presence across all services was less than 50.
SELECT
`week`,
SUM(`present`) AS 'presence'
FROM
staff_schedule
GROUP BY `week`
HAVING `presence` < 50;
