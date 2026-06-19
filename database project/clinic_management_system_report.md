# PUBLIC HEALTH CLINIC RECORDS MANAGEMENT SYSTEM

## Cover Page

Project Title: PUBLIC HEALTH CLINIC RECORDS MANAGEMENT SYSTEM
Course: Introduction to Database (COMP102)
Database Platform: MySQL (XAMPP)
Prepared by: [Your Name]
Date: June 2026

## Introduction

The Public Health Clinic Records Management System is designed to provide a structured relational database solution for managing patient records, clinical encounters, medical treatments, prescriptions, billing, and payment tracking at a community health facility in Sierra Leone.

## Problem Statement

Manual record keeping in public health clinics is error-prone, inefficient, and difficult to manage. A digital database-driven system is required to improve accuracy, support reporting, and enable reliable clinical decision-making.

## Objectives

- Design a normalized relational database compatible with MySQL.
- Implement clinic entities including patients, doctors, departments, nurses, appointments, medical records, prescriptions, billing, and payments.
- Generate realistic Sierra Leone clinic data for testing and evaluation.
- Provide query examples that support clinical operations and reporting.
- Demonstrate database security and user management.

## Refined Physical Data Model

The physical data model includes the following entities:

- Patients
- Doctors
- Departments
- Nurses
- Appointments
- Medical_Records
- Prescriptions
- Medicines
- Billing
- Payments

Key relationships:

- `Patients` to `Appointments`
- `Doctors` to `Appointments`
- `Departments` to `Doctors`
- `Departments` to `Nurses`
- `Patients` to `Medical_Records`
- `Medical_Records` to `Prescriptions`
- `Medicines` to `Prescriptions`
- `Patients` to `Billing`
- `Billing` to `Payments`

## Database Design Justification

Normalization was applied to avoid redundancy and ensure data integrity. Each entity maps to a single table with primary keys, foreign keys, and appropriate constraints.

- `PRIMARY KEY` ensures unique row identification.
- `FOREIGN KEY` enforces valid relationships between related entities.
- `NOT NULL` preserves required data elements.
- `UNIQUE` enforces uniqueness for emails and license values.
- `DEFAULT` values ensure consistent behavior for status and timestamps.

This design supports typical clinic workflows while remaining compatible with MySQL in XAMPP.

## Table Descriptions

- `departments`: Stores clinic department details and extensions.
- `doctors`: Stores doctor credentials, department assignment, specialization, and contact.
- `nurses`: Stores nurse credentials and department assignment.
- `patients`: Stores patient personal information, contact details, and medical history.
- `medicines`: Stores inventory details for medications used in prescriptions.
- `appointments`: Tracks scheduled clinic visits and appointment status.
- `medical_records`: Stores diagnoses, treatments, and notes from clinical encounters.
- `prescriptions`: Links medical records to medicines with dosage instructions.
- `billing`: Tracks charges for patient services and billing status.
- `payments`: Records payments made against bills.

## SQL Implementation

The database implementation is provided in `clinic_management_system.sql`.

Included components:

1. `CREATE DATABASE`
2. `USE DATABASE`
3. `CREATE TABLE` statements with foreign keys
4. `INSERT INTO` sample data
5. `UPDATE` examples
6. `DELETE` examples
7. Query demonstrations
8. User management commands

## Sample Data

The script includes realistic Sierra Leone clinic data:

- 30 patients
- 10 doctors
- 5 departments
- 10 nurses
- 30 appointments
- 30 medical records
- 30 prescriptions
- 30 medicines
- 30 billing records
- 30 payments

All foreign keys are valid, and sample data uses Sierra Leone cities such as Freetown, Bo, Makeni, Kenema, and Koidu.

## Query Demonstrations

The SQL script contains at least 20 example queries with clinical value, including:

- List all patients
- Find female patients
- Find patients above age 50
- Show today\'s appointments
- Show appointments for a specific doctor
- Count total patients
- Count appointments per doctor
- Average bill amount
- Total revenue generated
- Patients with unpaid bills
- Most prescribed medicine
- Top 5 recent appointments
- Patients with multiple visits
- Doctors with highest appointments
- Monthly revenue report
- Department-specific doctor listings
- Low-stock medicine alerts
- Billing and payment history
- Prescription trends by department

## User Management

The script includes MySQL user management commands:

- `CREATE USER`
- `ALTER USER`
- `GRANT PRIVILEGES`
- `REVOKE PRIVILEGES`
- `SHOW GRANTS`

Security best practices:

- Use least privilege access for application accounts.
- Restrict access to `localhost` for local XAMPP deployments.
- Use strong passwords and limit concurrent connections.
- Avoid granting global privileges unless necessary.

## Screenshots Section

Include screenshots in your final presentation showing:

1. XAMPP MySQL running
2. phpMyAdmin with `clinic_management_system` database selected
3. Table structure views for `patients`, `appointments`, `medical_records`, and `billing`
4. Query results for revenue and appointment reports
5. User management commands executed successfully

## Conclusion

This project delivers a complete, normalized relational database ready for a Sierra Leone public health clinic. The implementation supports clinical workflows, billing, inventory, and reporting while demonstrating sound database design and security practices.

## References

- MySQL Reference Manual
- XAMPP Documentation
- Sierra Leone Ministry of Health and Sanitation guidelines
- COMP102 course materials on relational database design

## Mermaid ER Diagram

```mermaid
erDiagram
    PATIENTS ||--o{ APPOINTMENTS : has
    DOCTORS ||--o{ APPOINTMENTS : handles
    DEPARTMENTS ||--o{ DOCTORS : employs
    DEPARTMENTS ||--o{ NURSES : employs
    PATIENTS ||--o{ MEDICAL_RECORDS : has
    MEDICAL_RECORDS ||--o{ PRESCRIPTIONS : issues
    MEDICINES ||--o{ PRESCRIPTIONS : includes
    PATIENTS ||--o{ BILLING : receives
    BILLING ||--o{ PAYMENTS : settles

    PATIENTS {
      INT patient_id PK
      VARCHAR first_name
      VARCHAR last_name
      ENUM gender
      DATE date_of_birth
      VARCHAR phone
      VARCHAR email
      VARCHAR address
      VARCHAR city
      VARCHAR region
    }
    DOCTORS {
      INT doctor_id PK
      VARCHAR first_name
      VARCHAR last_name
      INT department_id FK
      VARCHAR specialization
      VARCHAR phone
      VARCHAR email
    }
    DEPARTMENTS {
      INT department_id PK
      VARCHAR name
      VARCHAR floor
      VARCHAR extension
    }
    NURSES {
      INT nurse_id PK
      VARCHAR first_name
      VARCHAR last_name
      INT department_id FK
      VARCHAR phone
      VARCHAR email
    }
    APPOINTMENTS {
      INT appointment_id PK
      INT patient_id FK
      INT doctor_id FK
      DATETIME appointment_date
      VARCHAR reason
      ENUM status
    }
    MEDICAL_RECORDS {
      INT record_id PK
      INT patient_id FK
      INT doctor_id FK
      DATE record_date
      VARCHAR diagnosis
      TEXT treatment
    }
    PRESCRIPTIONS {
      INT prescription_id PK
      INT medical_record_id FK
      INT medicine_id FK
      INT patient_id FK
      INT doctor_id FK
      VARCHAR dosage
    }
    MEDICINES {
      INT medicine_id PK
      VARCHAR name
      VARCHAR generic_name
      VARCHAR dosage
      ENUM form
      DECIMAL price
    }
    BILLING {
      INT bill_id PK
      INT patient_id FK
      DATE billing_date
      DECIMAL amount
      ENUM status
      DATE due_date
    }
    PAYMENTS {
      INT payment_id PK
      INT bill_id FK
      DATE payment_date
      DECIMAL amount
      ENUM method
    }
```

---

> Notes for presentation: include the SQL file and report file in your GitHub submission. The SQL script is ready to import into MySQL/XAMPP. The report is formatted for a professional COMP102 project presentation.