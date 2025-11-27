-- Day 18 - IDC 21days Challenge

/*
Create a comprehensive personnel and patient list showing: 
identifier (patient_id or staff_id), full name, type ('Patient' or 'Staff'), and associated service. 
Include only those in 'surgery' or 'emergency' services. 
Order by type, then service, then name.
*/

SELECT `patient_id` AS 'Identifier',`name` AS 'Full name',('Patient') AS 'Type', `service` FROM patients WHERE `service` IN ('surgery','emergency')
UNION -- here unique names will come
SELECT `staff_id` AS 'Identifier',`staff_name` AS 'Full name', ('Staff') AS 'Type', `service` FROM staff WHERE `service` IN ('surgery','emergency')
ORDER BY `Type`,`service`,`Full name`;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice   

-- 1. Combine patient names and staff names into a single list.
SELECT `name` FROM patients
UNION ALL -- here duplicate name may come
SELECT `staff_name` FROM staff;

-- 2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
SELECT * FROM patients WHERE `satisfaction` > 90 -- High satidafaction
UNION
SELECT * FROM patients WHERE `satisfaction` < 50; -- Low satisfaction

-- 3. List all unique names from both patients and staff tables.
SELECT `name` FROM patients
UNION -- here unique names will come
SELECT `staff_name` FROM staff;