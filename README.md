# Job Application Tracker  
A simple Java + MySQL command–line system for managing applicants, positions, applications, and interviews.

---

## ✦ Overview
This project stores and manages job-related information using a MySQL database.  
The Java program (`Main.java`) provides a terminal menu that lets you interact with the data.

---

## ✦ Features

- View and add applicants  
- Update an applicant’s email  
- View, add, and delete job positions  
- View and add applications  
- Run a transaction workflow (Application + Interview)  
- SQL file includes: sample data, triggers, stored procedure, view, and indexes  

---

## ✦ Getting Started

### 1. Import the database
Run:

```
create_and_populate.sql
```

This creates all tables and loads sample data.

---

### 2. Configure database connection  
Edit these fields inside **Main.java**:

```java
private static final String URL = "jdbc:mysql://localhost:3306/your_db_name";
private static final String USERNAME = "your_username";
private static final String PASSWORD = "your_password";
```

---

### 3. Run the program

```
javac Main.java
java Main
```

---

## ✦ Menu Options

```
------------------------------------------------------
 1. View Applicants
 2. Add Applicant
 3. Update Applicant Email
 4. View Positions
 5. Add Position
 6. Delete Position
 7. View Applications
 8. Add Application
 9. Transaction Workflow
 0. Exit
------------------------------------------------------
```

---

## ✦ ER Diagram  
![erd](https://github.com/user-attachments/assets/5e2fc198-4b50-47fe-bc45-4559affa1b10)
--------------------------------------------------
<img width="521" height="558" alt="Screenshot 2025-12-17 at 6 37 51 PM" src="https://github.com/user-attachments/assets/74ba9456-bbf9-43e3-b216-a16a3cd43085" />

---

## ✦ Project Structure

```
├── Main.java
├── create_and_populate.sql
└── README.md
```

---

## ✦ Notes
This project was created to practice SQL schema design, JDBC, and working with relational data from Java.  
Everything runs in the terminal for simplicity.

---

