-- Day 12 - IDC 21days Challenge

/*
Analyze the event impact by comparing weeks with events vs weeks without events. 
Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale. 
Order by average patient satisfaction descending.
*/
USE hospital;

SELECT
CASE
WHEN `event` = 'none' THEN 'No Event'
ELSE 'With Event'
END AS 'Event status',
COUNT(`week`) AS 'count of weeks',
AVG(`patient_satisfaction`) AS 'Avg patient satisfaction',
AVG(`staff_morale`) AS 'Avg staff morale'
FROM
services_weekly
GROUP BY `Event status`
ORDER BY `Avg patient satisfaction` DESC;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BONUS Practice

-- 1. Find all weeks in services_weekly where no special event occurred.
/*
what is special event ? 
Here special event means to any event mentioned in the dataset 
other than ‘none’  like flu, donation, or strike.These indicate something unusual that happened that week.
*/
SELECT 
DISTINCT `week` 
FROM 
services_weekly
WHERE `event` <> 'none';

-- 2. Count how many records have null or empty event values.
SELECT 
COUNT(*) AS 'Records with no event'
FROM 
services_weekly
WHERE `event` = 'none';

-- 3. List all services that had at least one week with a special event.
SELECT 
DISTINCT `service`, COUNT(DISTINCT `week`) AS 'count of week'
FROM 
services_weekly
WHERE `event` <> 'none'
GROUP BY `service`
HAVING `count of week`;