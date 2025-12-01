-- Day 21 - IDC 21days Challenge

/*
Create a comprehensive hospital performance dashboard using CTEs. 
Calculate: 
1) Service-level metrics (total admissions, refusals, avg satisfaction), 
2) Staff metrics per service (total staff, avg weeks present), 
3) Patient demographics per service (avg age, count). 
Then combine all three CTEs to create a final report showing service name, all calculated metrics, 
and an overall performance score (weighted average of admission rate and satisfaction). 
Order by performance score descending.
*/
WITH temp1 AS
(-- This CTE will give service, Total admission, total refusal, avg satisfaction
SELECT 
`service`,SUM(`patients_admitted`) AS 'Total admission',SUM(`patients_refused`) AS 'Total Refusal', 
AVG(`patient_satisfaction`) AS 'AVG satisfaction'
FROM services_weekly
GROUP BY `service`), temp2 AS 
( -- This CTE will return Total staff, avg week present per services
SELECT 
`service`, COUNT(DISTINCT `staff_id`) AS 'Total staff', ROUND((SUM(`present`) / COUNT(DISTINCT `staff_id`)),2) AS 'avg week present'
FROM staff_schedule
WHERE `present` = 1
GROUP BY `service`), temp3 AS
( -- This CTE will return avg age and count of patients servicewise
SELECT
`service`,
ROUND(AVG(`age`),2) AS 'avg age',
COUNT(`patient_id`) AS 'count of patients'
FROM patients
GROUP BY `service`) , temp4 AS
(-- This CTE will join above 3 CTEs and also return admission rate per service alongwith other matrics
SELECT
*, 
ROUND(((`Total admission`)/(`Total admission`+`Total Refusal`))*100,2) AS 'admission rate(%age)'
FROM 
temp1 INNER JOIN temp2 
USING(`service`)
INNER JOIN temp3
USING(`service`)
)-- and finally we will calculate performance score
SELECT 
* , ROUND(
(
	(`AVG satisfaction`*(0.6)) +
	(`admission rate(%age)`*(0.4))
),2) AS 'Performance Score'
FROM temp4;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
