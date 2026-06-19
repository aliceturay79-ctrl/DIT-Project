-- PUBLIC HEALTH CLINIC RECORDS MANAGEMENT SYSTEM
-- MySQL script for clinic_management_system

DROP DATABASE IF EXISTS clinic_management_system;
CREATE DATABASE clinic_management_system CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE clinic_management_system;

-- Departments table
CREATE TABLE departments (
  department_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  floor VARCHAR(20) NOT NULL,
  extension VARCHAR(10) NOT NULL,
  description TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Doctors table
CREATE TABLE doctors (
  doctor_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  department_id INT NOT NULL,
  specialization VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  hire_date DATE NOT NULL,
  license_number VARCHAR(40) NOT NULL UNIQUE,
  status ENUM('Active','Inactive','On Leave') NOT NULL DEFAULT 'Active',
  FOREIGN KEY (department_id) REFERENCES departments(department_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Nurses table
CREATE TABLE nurses (
  nurse_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  department_id INT NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  hire_date DATE NOT NULL,
  license_number VARCHAR(40) NOT NULL UNIQUE,
  status ENUM('Active','Inactive') NOT NULL DEFAULT 'Active',
  FOREIGN KEY (department_id) REFERENCES departments(department_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Patients table
CREATE TABLE patients (
  patient_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  gender ENUM('Male','Female','Other') NOT NULL,
  date_of_birth DATE NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  address VARCHAR(255) NOT NULL,
  city VARCHAR(100) NOT NULL,
  region VARCHAR(100) NOT NULL,
  registered_date DATE NOT NULL DEFAULT CURRENT_DATE,
  emergency_contact VARCHAR(120) NOT NULL,
  medical_history TEXT,
  active BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Medicines table
CREATE TABLE medicines (
  medicine_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  generic_name VARCHAR(100) NOT NULL,
  dosage VARCHAR(50) NOT NULL,
  form ENUM('Tablet','Capsule','Syrup','Injection','Cream','Drops') NOT NULL,
  price DECIMAL(8,2) NOT NULL,
  stock INT NOT NULL DEFAULT 0,
  supplier VARCHAR(120) NOT NULL,
  expiry_date DATE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Appointments table
CREATE TABLE appointments (
  appointment_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  appointment_date DATETIME NOT NULL,
  reason VARCHAR(255) NOT NULL,
  status ENUM('Scheduled','Completed','Cancelled','No Show') NOT NULL DEFAULT 'Scheduled',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  notes TEXT,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Medical records table
CREATE TABLE medical_records (
  record_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  record_date DATE NOT NULL,
  diagnosis VARCHAR(255) NOT NULL,
  treatment TEXT NOT NULL,
  notes TEXT,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Prescriptions table
CREATE TABLE prescriptions (
  prescription_id INT AUTO_INCREMENT PRIMARY KEY,
  medical_record_id INT NOT NULL,
  medicine_id INT NOT NULL,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  dosage VARCHAR(100) NOT NULL,
  frequency VARCHAR(100) NOT NULL,
  duration VARCHAR(50) NOT NULL,
  notes TEXT,
  FOREIGN KEY (medical_record_id) REFERENCES medical_records(record_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Billing table
CREATE TABLE billing (
  bill_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  billing_date DATE NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  status ENUM('Unpaid','Paid','Partial','Cancelled') NOT NULL DEFAULT 'Unpaid',
  description TEXT NOT NULL,
  due_date DATE NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Payments table
CREATE TABLE payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  bill_id INT NOT NULL,
  payment_date DATE NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  method ENUM('Cash','Card','Mobile Money','Insurance') NOT NULL DEFAULT 'Cash',
  reference VARCHAR(100) NOT NULL,
  received_by VARCHAR(100) NOT NULL,
  FOREIGN KEY (bill_id) REFERENCES billing(bill_id)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Sample Data Inserts are stored in data/clinic_management_system_inserts.sql
