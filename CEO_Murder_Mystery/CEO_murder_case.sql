CREATE DATABASE policecase;
USE policecase; 
-- DROP TABLES if exist
DROP TABLE IF EXISTS employees, keycard_logs, calls, alibis, evidence;

-- Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    role VARCHAR(50)
);

INSERT INTO employees VALUES
(1, 'Alice Johnson', 'Engineering', 'Software Engineer'),
(2, 'Bob Smith', 'HR', 'HR Manager'),
(3, 'Clara Lee', 'Finance', 'Accountant'),
(4, 'David Kumar', 'Engineering', 'DevOps Engineer'),
(5, 'Eva Brown', 'Marketing', 'Marketing Lead'),
(6, 'Frank Li', 'Engineering', 'QA Engineer'),
(7, 'Grace Tan', 'Finance', 'CFO'),
(8, 'Henry Wu', 'Engineering', 'CTO'),
(9, 'Isla Patel', 'Support', 'Customer Support'),
(10, 'Jack Chen', 'HR', 'Recruiter');

-- Keycard Logs Table
CREATE TABLE keycard_logs (
    log_id INT PRIMARY KEY,
    employee_id INT,
    room VARCHAR(50),
    entry_time TIMESTAMP,
    exit_time TIMESTAMP
);

INSERT INTO keycard_logs VALUES
(1, 1, 'Office', '2025-10-15 08:00', '2025-10-15 12:00'),
(2, 2, 'HR Office', '2025-10-15 08:30', '2025-10-15 17:00'),
(3, 3, 'Finance Office', '2025-10-15 08:45', '2025-10-15 12:30'),
(4, 4, 'Server Room', '2025-10-15 08:50', '2025-10-15 09:10'),
(5, 5, 'Marketing Office', '2025-10-15 09:00', '2025-10-15 17:30'),
(6, 6, 'Office', '2025-10-15 08:30', '2025-10-15 12:30'),
(7, 7, 'Finance Office', '2025-10-15 08:00', '2025-10-15 18:00'),
(8, 8, 'Server Room', '2025-10-15 08:40', '2025-10-15 09:05'),
(9, 9, 'Support Office', '2025-10-15 08:30', '2025-10-15 16:30'),
(10, 10, 'HR Office', '2025-10-15 09:00', '2025-10-15 17:00'),
(11, 4, 'CEO Office', '2025-10-15 20:50', '2025-10-15 21:00'); -- killer

-- Calls Table
CREATE TABLE calls (
    call_id INT PRIMARY KEY,
    caller_id INT,
    receiver_id INT,
    call_time TIMESTAMP,
    duration_sec INT
);

INSERT INTO calls VALUES
(1, 4, 1, '2025-10-15 20:55', 45),
(2, 5, 1, '2025-10-15 19:30', 120),
(3, 3, 7, '2025-10-15 14:00', 60),
(4, 2, 10, '2025-10-15 16:30', 30),
(5, 4, 7, '2025-10-15 20:40', 90);

-- Alibis Table
CREATE TABLE alibis (
    alibi_id INT PRIMARY KEY,
    employee_id INT,
    claimed_location VARCHAR(50),
    claim_time TIMESTAMP
);

INSERT INTO alibis VALUES
(1, 1, 'Office', '2025-10-15 20:50'),
(2, 4, 'Server Room', '2025-10-15 20:50'), -- false alibi
(3, 5, 'Marketing Office', '2025-10-15 20:50'),
(4, 6, 'Office', '2025-10-15 20:50');

-- Evidence Table
CREATE TABLE evidence (
    evidence_id INT PRIMARY KEY,
    room VARCHAR(50),
    description VARCHAR(255),
    found_time TIMESTAMP
);

INSERT INTO evidence VALUES
(1, 'CEO Office', 'Fingerprint on desk', '2025-10-15 21:05'),
(2, 'CEO Office', 'Keycard swipe logs mismatch', '2025-10-15 21:10'),
(3, 'Server Room', 'Unusual access pattern', '2025-10-15 21:15');

SELECT * FROM employees; -- employee_id (pri), name, department, role
DESC employees;
SELECT * FROM keycard_logs; -- log_id (pri), employee_id, room, entry_time, exit_time
DESC keycard_logs;
SELECT * FROM calls; -- call_id (pri), caller_id, receiver_id, call_time, duration_sec 
DESC calls; 
SELECT * FROM alibis; -- alibi_id(pri), employee_id, claimed_location, claim_time
DESC alibis;
SELECT * FROM evidence; -- evidence_id (pri), room, description, found_time
DESC evidence;


-- The CEO of TechNova Inc. has been found dead in their office on October 15, 2025, at 9:00 PM.
/*
You are the lead data analyst tasked with solving this case using SQL. All the clues you need are hidden in the company’s databases:

- Keycard logs
- Phone call records
- Alibis
- Evidence found in different rooms

Your mission is simple but challenging:

👉 Find out who the killer is, where and when the crime took place, and how it happened — using only SQL queries.
*/

-- Who entered the CEO’s Office close to the time of the murder?

SELECT 
`log_id`, `employee_id`,`name`, `room`, `entry_time`, `exit_time`
FROM keycard_logs AS k
INNER JOIN
employees AS e
USING(`employee_id`)
WHERE `room` = 'CEO Office';

-- Who claimed to be somewhere else but was not?

SELECT 
k.`employee_id`, e.`name`,a.`alibi_id`, a.`claimed_location`, k.`room` AS 'Actual Location', 
a.`claim_time`,  k.`entry_time` AS 'actual entry', k.`exit_time` AS 'Actual exit'
FROM alibis AS a
INNER JOIN
keycard_logs AS k
USING (employee_id)
INNER JOIN
employees AS e
USING (employee_id)
WHERE `claimed_location` != `room`;


-- Who made or received calls around **20:50–21:00**?

SELECT 
`call_id`, `caller_id`,
(SELECT `name` FROM employees WHERE `employee_id` = `caller_id` ) AS 'Caller name', `receiver_id`,
(SELECT `name` FROM employees WHERE `employee_id` = `receiver_id` ) AS 'Receiver name',
`call_time`, `duration_sec`, TIME(`call_time`)
FROM calls
call_time
WHERE TIME(`call_time`) BETWEEN '20:00' AND '21:00';

-- What evidence was found at the crime scene?
SELECT 
`description` 
FROM evidence
WHERE `room` = 'CEO Office';


-- Which suspect’s movements, alibi, and call activity don’t add up?
-- lets combine all above finding to see the common name

WITH temp1 AS
( -- Who entered the CEO’s Office close to the time of the murder?
SELECT 
`log_id`, `employee_id`,`name`, `room`, `entry_time`, `exit_time`
FROM keycard_logs AS k
INNER JOIN
employees AS e
USING(`employee_id`)
WHERE `room` = 'CEO Office'
),temp2 AS
(-- Who claimed to be somewhere else but was not?
SELECT 
k.`employee_id`, e.`name`,a.`alibi_id`, a.`claimed_location`, k.`room` AS 'Actual Location', a.`claim_time`,  k.`entry_time` AS 'actual entry', k.`exit_time` AS 'Actual exit'
FROM alibis AS a
INNER JOIN
keycard_logs AS k
USING (employee_id)
INNER JOIN
employees AS e
USING (employee_id)
WHERE `claimed_location` != `room`
), temp3 AS
(-- Who made or received calls around **20:50–21:00**?
SELECT 
`call_id`, `caller_id`,
(SELECT `name` FROM employees WHERE `employee_id` = `caller_id` ) AS 'Caller name', `receiver_id`,
(SELECT `name` FROM employees WHERE `employee_id` = `receiver_id` ) AS 'Receiver name',
`call_time`, `duration_sec`, TIME(`call_time`)
FROM calls
call_time
WHERE TIME(`call_time`) BETWEEN '20:00' AND '21:00'
)
SELECT DISTINCT temp1.`name`FROM temp1 INNER JOIN temp2 USING(`employee_id`)
INNER JOIN temp3 ON temp2.`employee_id` = temp3.`caller_id`;
