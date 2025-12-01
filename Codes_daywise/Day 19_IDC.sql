-- Day 19 - IDC 21days Challenge

/*
For each service, rank the weeks by patient satisfaction score (highest first). 
Show service, week, patient_satisfaction, patients_admitted, and the rank. 
Include only the top 3 weeks per service.
*/

SELECT * FROM
(
SELECT
`service`,`week`,`patient_satisfaction`, `patients_admitted`,
DENSE_RANK() OVER(PARTITION BY `service` ORDER BY`patient_satisfaction` DESC)  AS 'Rank'
FROM services_weekly
) AS t WHERE `Rank` <= 3;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice   

-- 1. Rank patients by satisfaction score within each service.
SELECT 
`service`,`name`,`satisfaction`, 
DENSE_RANK() OVER(PARTITION BY `service` ORDER BY `satisfaction` DESC)  AS 'Rank'
FROM patients;
-- 2. Assign row numbers to staff ordered by their name.
SELECT *,ROW_NUMBER() OVER(ORDER BY `staff_name` ASC) AS 'Row number'  FROM staff;

-- 3. Rank services by total patients admitted.
SELECT 
* , RANK() OVER(ORDER BY `Total_patient_admitted` DESC) AS 'Rank'
FROM
(SELECT 
`service`, SUM(`patients_admitted`) AS 'Total_patient_admitted' 
FROM services_weekly
GROUP BY `service`) AS t;