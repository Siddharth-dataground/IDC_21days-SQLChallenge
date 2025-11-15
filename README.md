# IDC_21days-SQLChallenge
### Prerequisite
**MySQL** : 
- To install on Mac OS, you can follow this YouTube video. [Link](https://youtu.be/ODA3rWfmzg8?si=phxld1lk1doCVfPH)
- To install on Windows OS, you can follow this YouTube video. [Link](https://youtu.be/v8i2NgiM5pE?si=8vVrof2tILodpIo7)
<br>***Note*** :
    - You can follow any video or other method to download and install. I just provided an example here to install. Install carefully as per your system requirements.
    - I have used MySQL Workbench 8.0 version 8.0.41.

### 21-day Challenge for SQL by IDC [Indian Data Club] sponsored by DPDzero
In this Repo, I have uploaded day-wise challenges and the solution using my approach.<br> The main aim is to improve SQL knowledge by doing problems, improving our approach and improving logic building
#### About the dataset: [Link](./sources)
It's a hospital data set. There are a total of 4 tables.
<br>
<br> 1. hospital_staff.csv – List of hospital staff
<br> 2. hospital_patients.csv – Patient records
<br> 3. hospital_service_weekly.csv – Weekly service-level data
<br> 4. hospital_staff_schedule.csv – Weekly schedule

#### Challenges List
First, create a database and table structure using the [Code](./Create%20Database,%20Table%20Structures)

| Days | Challenege | Code Link |
|-|-|-|
| **1** | List all unique hospital services available in the hospital. | [Code](./Codes_daywise/Day%201_IDC.sql)|
| **2** | Find all patients admitted to the 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score.|[Code](./Codes_daywise/Day%202_IDC.sql) |
| **3** | Retrieve the top 5 weeks with the highest patient refusals across all services, showing week, service, patients_refused, and patients_request. Sort by patients_refused in descending order.|[Code](./Codes_daywise/Day%203_IDC.sql) |
| **4** | Find the 3rd to 7th highest patient satisfaction scores from the patients table, showing patient_id, name, service, and satisfaction. Display only these 5 records.|[Code](./Codes_daywise/Day%204_IDC.sql) |
| **5** | Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks.Round the average satisfaction to 2 decimal places.|[Code](./Codes_daywise/Day%205_IDC.sql) |
| **6** | For each hospital service, calculate the total number of patients admitted, total patients refused, and the admission rate ( percentage of requests that were admitted ). Order by admission rate descending.|[Code](./Codes_daywise/Day%206_IDC.sql) |
| **7** | Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80. Show service name, total refused, and average satisfaction.|[Code](./Codes_daywise/Day%207_IDC.sql) |
| **8** | Create a patient summary that shows patient_id, full name in uppercase, service in lowercase, age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length. Only show patients whose name length is greater than 10 characters.|[Code](./Codes_daywise/Day%208_IDC.sql)|
| **9** | Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. Also show the count of patients and order by average stay descending.|[Code](./Codes_daywise/Day%209_IDC.sql)|
| **10** | Create a service performance report showing service name, total patients admitted, and a performance category based on the following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.|[Code](./Codes_daywise/Day%2010_IDC.sql)|
| **11** | Find all unique combinations of service and event type from the services_weekly table where events are not null or none, along with the count of occurrences for each combination. Order by count descending.|[Code](./Codes_daywise/Day%2011_IDC.sql)|
| **12** | Analyse the event impact by comparing weeks with events vs weeks without events. Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale. Order by average patient satisfaction descending.|[Code](./Codes_daywise/Day%2012_IDC.sql)|


