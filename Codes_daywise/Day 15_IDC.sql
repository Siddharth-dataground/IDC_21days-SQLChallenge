-- Day 15 - IDC 21days Challenge
-- IMP
/*
Create a comprehensive service analysis report for week 20 showing: 
service name, total patients admitted that week, total patients refused, average patient satisfaction, count of staff assigned to service, 
and count of staff present that week. 
Order by patients admitted descending.
*/
USE hospital;

-- Approach 1: by subquery (FASTER)

SELECT * FROM
( -- this subquery will return the service, patients_admitted, patients_refused, avg_patient_satisfaction
SELECT 
w.`service`, SUM(w.`patients_admitted`) AS 'patients_admitted',SUM(w.`patients_refused`) AS 'patients_refused', 
ROUND(AVG(w.`patient_satisfaction`),2) AS 'Avg patient satisfaction'
FROM services_weekly as w WHERE w.`week` = 20 GROUP BY w.`service`
) AS t1
LEFT JOIN
( -- this subquery part will return total staff assigned in each service
SELECT 
`service`,COUNT(`staff_id`) AS 'Total staff assigned'
FROM staff GROUP BY `service`
) AS t2
USING(`service`)
LEFT JOIN
( -- this part will give how many staff absent for each service from total assigned
SELECT 
staff_schedule.`service`, COUNT(DISTINCT staff_schedule.`staff_id`) AS 'total staff present'
FROM staff_schedule INNER JOIN staff USING(`staff_id`,`service`) WHERE `week` =20 AND `present` = 1 
GROUP BY `service`
) AS t3
USING(`service`)
ORDER BY `patients_admitted` DESC;


-- Approach 2 : without using subquery/CTE (slower)
SELECT
 sw.service,
 MAX(sw.patients_admitted) AS total_admitted,
 MAX(sw.patients_refused) AS total_refused,
 ROUND(AVG(sw.patient_satisfaction), 2) AS avg_satisfaction,
 COUNT(DISTINCT s.staff_id) AS total_staff,
 COUNT(DISTINCT CASE WHEN ss.week = 20 AND ss.present = 1 THEN ss.staff_id END) AS staff_present_week_20
FROM 
 services_weekly sw
LEFT JOIN 
 staff s ON sw.service = s.service
LEFT JOIN 
 staff_schedule ss ON s.staff_id = ss.staff_id  AND s.service = ss.service
WHERE 
 sw.week = 20
GROUP BY 
 sw.service
ORDER BY 
 total_admitted DESC;
 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice
-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability.
-- We have to show patientwise how much staff scheduled and how much available

SELECT
p.`patient_id`,p.`name`,p.`service`, 
COUNT(DISTINCT st.`staff_id`) AS 'Assigned staff count',
MAX(ss.`available staff`) AS 'Available staff count' -- I use max sothat i dont have to put it in group by
FROM
patients AS p
LEFT JOIN
staff AS st
ON P.`service` = st.`service`
LEFT JOIN 
(
SELECT `service`,
COUNT(DISTINCT `staff_id`) AS 'available staff' 
FROM staff_schedule where `present` = 1
group by `service`
) AS ss
ON st.`service` = ss.`service`
GROUP BY p.`patient_id`,p.`name`,p.`service`
ORDER BY `service`;



-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
-- from staff collect the total staff assigned
-- from staff_schedule collect how much present for that respective week

SELECT 
sw.* , 
COUNT(DISTINCT s.`staff_id`) AS 'Staff assigned',
ss.`Total_staff_present`
FROM 
services_weekly AS sw
LEFT JOIN
staff AS s
ON sw.`service` = s.`service`
INNER JOIN
( -- THIS sub query will return the no. of staff present in each week for each service
SELECT 
`week`,`service`,SUM(`present`) AS 'Total_staff_present'
FROM staff_schedule
GROUP BY `week`,`service`
) AS ss
ON ss.`week` = sw.`week` AND ss.`service` = sw.`service`
GROUP BY sw.`week`, sw.`month`, sw.`service`, sw.`available_beds`, sw.`patients_request`, sw.`patients_admitted`, sw.`patients_refused`, 
sw.`patient_satisfaction`, sw.`staff_morale`, sw.`event`;

-- 3. Create a multi-table report showing patient admissions with staff information.
SELECT 
p.*, COUNT(DISTINCT s.staff_id) 
FROM patients AS p
INNER JOIN
staff AS s
ON p.`service` = s.`service`
GROUP BY p.`patient_id`, p.`name`, p.`age`, p.`arrival_date`, p.`departure_date`, p.`service`, p.`satisfaction`;