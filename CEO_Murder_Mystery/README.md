## Murder of TechNova Inc.
The CEO of **TechNova Inc.** has been found dead in their office on **October 15, 2025, at 9:00 PM**.

As a **lead data analyst**, I am tasked with solving this case using SQL. All the clues I need are hidden in the company’s databases:

- Keycard logs
- Phone call records
- Alibis
- Evidence found in different rooms

My mission is simple but challenging:

👉 **Find out who the killer is, where and when the crime took place, and how it happened — using only SQL queries.**
---
### Links to data source and query : [Link]()

---
## All Table details

### **Table: employees**

| Column | Type | Description |
| --- | --- | --- |
| employee_id | INT | Unique employee ID |
| name | VARCHAR | Full name of the employee |
| department | VARCHAR | Department of the employee |
| role | VARCHAR | Role or title |

---

### **Table: keycard_logs**

| Column | Type | Description |
| --- | --- | --- |
| log_id | INT | Log ID |
| employee_id | INT | ID of employee |
| room | VARCHAR | Room name |
| entry_time | TIMESTAMP | Time they entered |
| exit_time | TIMESTAMP | Time they left |

🕒 *Clue: Someone entered the CEO’s office around the time of the crime.*

---

### **Table: calls**

| Column | Type | Description |
| --- | --- | --- |
| call_id | INT | Call ID |
| caller_id | INT | ID of caller |
| receiver_id | INT | ID of receiver |
| call_time | TIMESTAMP | When the call happened |
| duration_sec | INT | Duration in seconds |

📞 *Clue: There was a suspicious call shortly before the crime.*

---

### **Table: alibis**

| Column | Type | Description |
| --- | --- | --- |
| alibi_id | INT | Alibi record ID |
| employee_id | INT | Employee ID |
| claimed_location | VARCHAR | Where they said they were |
| claim_time | TIMESTAMP | When they claimed to be there |

🤔 *Clue: Someone may have lied about their location.*

---

### **Table: evidence**

| Column | Type | Description |
| --- | --- | --- |
| evidence_id | INT | Evidence ID |
| room | VARCHAR | Where evidence was found |
| description | VARCHAR | What was found |
| found_time | TIMESTAMP | When it was found |

⁉️ *Clue: Physical evidence was discovered at the scene.*
