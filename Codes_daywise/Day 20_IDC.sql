-- Day 20 - IDC 21days Challenge

/*
Create a trend analysis showing for each service and week: 
week number, patients_admitted, running total of patients admitted (cumulative), 
3-week moving average of patient satisfaction (current week and 2 prior weeks), 
and the difference between current week admissions and the service average. 
Filter for weeks 10-20 only.
*/

SELECT 
`service`, `week`, `patients_admitted`, 
`AVG_patients_admitted_service`,
(`patients_admitted` - `AVG_patients_admitted_service`) AS 'Diff',
`running total of patients admitted`, `3-week moving avg of patient satisfaction`
FROM
(SELECT 
`service`,`week` ,
-- Total patients admitted
`patients_admitted`,
SUM(`patients_admitted`) 
	OVER (PARTITION BY `service` ORDER BY `service`, `week`) AS 'running total of patients admitted',
AVG(`patient_satisfaction`) 
	OVER (PARTITION BY `service` ORDER BY `service`, `week` ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS '3-week moving avg of patient satisfaction'
FROM services_weekly 
WHERE `week` BETWEEN 10 AND 20) AS t1
LEFT JOIN
(
SELECT
`service`,
AVG(`patients_admitted`) AS 'AVG_patients_admitted_service'
FROM services_weekly 
GROUP BY `service`) AS t2
USING(`service`);

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice   

-- 1. Calculate running total of patients admitted by week for each service.
SELECT 
`service`,`week` ,
`patients_admitted`,
SUM(`patients_admitted`) 
	OVER (PARTITION BY `service` ORDER BY `service`, `week`) AS 'running total of patients admitted'
FROM services_weekly ;

-- 2. Find the moving average of patient satisfaction over 4-week periods.

SELECT 
`service`,`week` ,
`patient_satisfaction`,
ROUND(AVG(`patient_satisfaction`)
	OVER (PARTITION BY `service` ORDER BY `service`, `week` ROWS BETWEEN 3 PRECEDING AND CURRENT ROW),2) AS 'avg_satisfaction'
FROM services_weekly ;

-- 3. Show cumulative patient refusals by week across all services.

SELECT
*, SUM(`patients refusal`) OVER (ORDER BY `week`) AS 'cum_sum' 
FROM
(
SELECT 
`week`,
SUM(`patients_refused`) AS 'patients refusal'
FROM services_weekly
GROUP BY `week`) AS t;


