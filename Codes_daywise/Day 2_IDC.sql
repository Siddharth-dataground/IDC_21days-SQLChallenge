-- Day 2 - IDC 21days Challenge

-- Find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score.
USE hospital;

SELECT
`patient_id`,`name`,`age`,`satisfaction`
FROM
patients
WHERE
`service` = 'surgery' AND `satisfaction`<70;

-- Take one step forward, so that we can further see which age group wise satisfaction levels


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice

-- 1. Find all patients who are older than 60 years.
SELECT
*
FROM
patients
WHERE `age`>60;

-- 2. Retrieve all staff members who work in the 'Emergency' service.
SELECT
*
FROM
patients
WHERE `service`='emergency';

-- 3. List all weeks where more than 100 patients requested admission in any service.
SELECT
DISTINCT `week` -- I use distinct function so that if any week repeat then it will come once
FROM 
services_weekly
WHERE patients_request >100;
