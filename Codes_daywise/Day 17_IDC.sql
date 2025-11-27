-- Day 17 - IDC 21days Challenge

/*
Create a report showing each service with: service name, total patients admitted, the difference between their total admissions 
and the average admissions across all services, 
and a rank indicator ('Above Average', 'Average', 'Below Average'). 
Order by total patients admitted descending.
*/

SELECT
`service`, `total patients admitted`, `Differe b/w total and avg`,
CASE
WHEN `total patients admitted`>`Overall_avg_patients_admitted` THEN 'Above Average'
WHEN `total patients admitted`=`Overall_avg_patients_admitted` THEN 'Average'
WHEN `total patients admitted`<`Overall_avg_patients_admitted` THEN 'Below Average'
END AS 'Indicator' 
FROM
(
SELECT `service`,
SUM(`patients_admitted`) AS 'total patients admitted',
( SELECT SUM(`patients_admitted`)/COUNT(DISTINCT `service`) FROM services_weekly ) AS 'Overall_avg_patients_admitted' ,
( SUM(`patients_admitted`) - (SELECT SUM(`patients_admitted`)/COUNT(DISTINCT `service`) FROM services_weekly) ) AS 'Differe b/w total and avg'
FROM services_weekly
GROUP BY `service`
) AS t
ORDER BY `total patients admitted` DESC;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice   

-- 1. Show each patient with their service's average satisfaction as an additional column.
SELECT 
* 
FROM patients AS p
LEFT JOIN
(
SELECT `service`, ROUND(AVG(`satisfaction`),2) AS 'Avg_satisfaction'
FROM patients
GROUP BY `service`
order by service
) AS t
ON p.`service`= t.`service`; 

-- 2. Create a derived table of service statistics and show how many total patients in each service.
SELECT 
    s.`service`,
    SUM(s.`available_beds`) AS 'Total_available_beds',
    SUM(s.`patients_request`) AS 'Total_patients_request',
    SUM(s.`patients_admitted`) AS 'Total_patients_admitted',
    SUM(s.`patients_refused`) AS 'Total_patients_refused',
    AVG(s.`patient_satisfaction`) AS 'Avg_patient_satisfaction',
    AVG(s.`staff_morale`) AS 'Avg_staff_morale',
    MAX(t.`Total_patients`) AS 'Total_patients'
FROM
    services_weekly AS s
    LEFT JOIN
    (SELECT `service`, COUNT(`patient_id`) AS 'Total_patients' FROM patients GROUP BY `service`)AS t
    USING (`service`)
    GROUP BY s.`service`;

-- 3. Display staff with their service's total patient count as a calculated field.

SELECT S.*, t.`Total patients`
FROM 
staff AS s
LEFT JOIN
(SELECT 
`service`,COUNT(`patient_id`) AS 'Total patients'
FROM patients
GROUP BY `service`) AS t
USING(`service`);