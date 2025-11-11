-- Day 9 - IDC 21days Challenge

/*
Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. 
Also show the count of patients and order by average stay descending.
*/
USE hospital;
DESCRIBE patients;

-- If in above describe command the date columns data type is not in DATE / DATETIME type, then use Section 2 or else use Section 1

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Section 1

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
`patient_id`, `name`, TIMESTAMPDIFF(DAY,`arrival_date`, `departure_date`) AS 'No of days stay'
FROM 
patients;

-- 3. Find all patients who arrived in a specific month. (lets say we need to find for June month only)
SELECT
*
FROM
patients
WHERE MONTHNAME(arrival_date) = 'June';


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Section 2

SELECT
`service`,
AVG(TIMESTAMPDIFF(DAY,STR_TO_DATE(`arrival_date`,'%Y-%m-%d'),STR_TO_DATE(`departure_date`,'%Y-%m-%d'))) AS 'Avg No of days stay',
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
`patient_id`, `name`, `arrival_date`,YEAR(STR_TO_DATE(`arrival_date`,'%Y-%m-%d')) AS 'arrival year', `departure_date`, `service`
FROM 
patients;

-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).

SELECT
`patient_id`, `name`, TIMESTAMPDIFF(DAY,STR_TO_DATE(`arrival_date`,'%Y-%m-%d'), STR_TO_DATE(`departure_date`,'%Y-%m-%d')) AS 'No of days stay'
FROM 
patients;

-- 3. Find all patients who arrived in a specific month. (lets say we need to find for June month only)
SELECT
*
FROM
patients
WHERE MONTHNAME(STR_TO_DATE(`arrival_date`,'%Y-%m-%d')) = 'June';