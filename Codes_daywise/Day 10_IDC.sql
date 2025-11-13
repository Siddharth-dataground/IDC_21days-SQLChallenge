-- Day 10 - IDC 21days Challenge

/*
Create a service performance report showing service name, total patients admitted, 
and a performance category based on the following: 
'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.
*/
USE hospital;

SELECT
`service`,
SUM(`patients_admitted`) AS 'Total patients admitted',
ROUND(AVG(`patient_satisfaction`),2) AS 'Average satisfaction',
CASE
WHEN AVG(`patient_satisfaction`) >=85 THEN 'Excellent'
WHEN AVG(`patient_satisfaction`) >=75 AND  AVG(`patient_satisfaction`) <85 THEN 'Good'
WHEN AVG(`patient_satisfaction`) >=65 AND  AVG(`patient_satisfaction`) <75 THEN 'Fair'
ELSE
'Needs Improvement'
END AS 'Performance category'
FROM
services_weekly
GROUP BY `service`
ORDER BY `Average satisfaction` DESC;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice

-- 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
-- If satisfaction >= 80 its High, satisfaction >=60 Medium and rest Low
SELECT 
`patient_id`, `name`,`satisfaction`,
CASE
WHEN `satisfaction` >=80 AND `satisfaction`<100 THEN 'High'
WHEN `satisfaction` >=60 AND `satisfaction`<80 THEN 'Medium'
ELSE 'Low' 
END AS 'Satisfaction level'
FROM 
patients;

-- 2. Label staff roles as 'Medical' or 'Support' based on role type.
-- doctor, nurse = Medical, nursing_assistant = Support
SELECT 
*,
CASE
WHEN `role` IN ('doctor','nurse') THEN 'Medical'
WHEN `role` = 'nursing_assistant' THEN 'Support'
END AS 'Role Type'
FROM 
staff;

-- 3. Create age groups for patients (0-18, 19-40, 41-65, 65+).

SELECT
`patient_id`,`name`,`age`,
CASE
WHEN `age`>=65 THEN 'Old'
WHEN `age`<65 AND `age`>=41 THEN 'Elder'
WHEN `age`<41 AND `age`>=19 THEN 'Young'
ELSE 'Child'
END AS 'age group'
FROM
patients;


SELECT * FROM services_weekly;