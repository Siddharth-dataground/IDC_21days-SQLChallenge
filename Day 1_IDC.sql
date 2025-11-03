USE hospital;

-- Challenge - DAY 1
-- Question: List all unique hospital services available in the hospital.

SELECT
DISTINCT UPPER(service) AS 'Distinct Services In Hospital'
FROM
services_weekly;

/* O/P:
| Distinct Services In Hospital |
	'EMERGENCY'
	'SURGERY'
	'GENERAL_MEDICINE'
	'ICU'
*/
-- --------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------
-- Some practice questions : BONUS
-- 1. Retrieve all columns from the `patients` table.
SELECT * FROM patients;
-- 2. Select only the `patient_id`, `name`, and `age` columns from the `patients` table.
SELECT 
`patient_id`, `name`, `age`
FROM patients;
-- 3. Display the first 10 records from the `services_weekly` table.
SELECT 
* 
FROM services_weekly
LIMIT 10;




