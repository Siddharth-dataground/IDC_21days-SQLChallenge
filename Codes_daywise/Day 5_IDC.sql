-- Day 5 - IDC 21days Challenge

/*
Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks. 
Round the average satisfaction to 2 decimal places.
*/
USE hospital;

SELECT
SUM(`patients_admitted`) AS 'total_number_of_patients_admitted',
SUM(`patients_refused`)AS 'total_patients_refused',
ROUND(AVG(`patient_satisfaction`),2) AS 'the average patient satisfaction'
FROM
services_weekly;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice
-- 1. Count the total number of patients in the hospital.
SELECT
COUNT(`patient_id`) AS 'Total_number_of_patients'
FROM
patients;

-- 2. Calculate the average satisfaction score of all patients.
SELECT
ROUND(AVG(`satisfaction`),2) AS 'average_satisfaction_score'
FROM
patients;

-- 3. Find the minimum and maximum age of patients.
SELECT
MIN(`age`) AS 'min_age', MAX(`age`) AS 'max_age'
FROM
patients;

