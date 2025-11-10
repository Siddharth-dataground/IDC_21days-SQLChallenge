-- Day 8 - IDC 21days Challenge

/*
Create a patient summary that shows patient_id, full name in uppercase, service in lowercase, 
age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length. 
Only show patients whose name length is greater than 10 characters.
*/
USE hospital;

SELECT
`patient_id`, 
UPPER(`name`) AS 'Full Name',
LOWER(`service`) AS 'Services',
CASE
WHEN `age`>=65 THEN 'Senior'
WHEN `age`>=18 AND `age`<65 THEN 'Adult'
ELSE 'Minor'
END AS 'Age Group',
CHAR_LENGTH(`name`) AS 'Name Length'
FROM
patients
GROUP BY `patient_id`
HAVING `Name Length`>10;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice

-- 1. Convert all patient names to uppercase.
SELECT
UPPER(`name`) AS 'Full Name'
FROM
patients;
-- 2. Find the length of each staff member's name.
SELECT
`staff_name`,CHAR_LENGTH(`staff_name`) AS 'Length of staff name'
FROM
staff;

-- 3. Concatenate staff_id and staff_name with a hyphen separator
SELECT
`staff_id`, `staff_name`,
concat(`staff_id`, ' - ',`staff_name`) AS 'Staff_id and Staff_name'
FROM
staff;