-- Day 9 - IDC 21days Challenge

/*
Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. 
Also show the count of patients and order by average stay descending.
*/
USE hospital;

SELECT
`service`,
AVG(TIMESTAMPDIFF(DAY,`arrival_date`,`departure_date`)) AS 'Avg No of days stay',
COUNT(`patient_id`) AS 'Count of patients'
FROM
patients
GROUP BY `service`
HAVING `Avg No of days stay` > 7
ORDER BY `Avg No of days stay` DESC;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice

-- 1. Extract the year from all patient arrival dates.
SELECT
`patient_id`, `name`, `arrival_date`,YEAR(`arrival_date`) AS 'arrival year', `departure_date`, `service`
FROM 
patients;
-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).
SELECT
*,
YEAR(`arrival_date`) AS 'arrival year'
FROM 
patients;

-- 3. Find all patients who arrived in a specific month. (lets say we need to find for June month only)
SELECT
*
FROM
patients
WHERE MONTHNAME(arrival_date) = 'June';