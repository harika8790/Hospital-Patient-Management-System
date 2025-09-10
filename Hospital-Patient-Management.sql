CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

-- Patients Table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    gender ENUM('Male', 'Female', 'Other'),
    dob DATE,
    contact_number VARCHAR(15),
    address VARCHAR(255),
    medical_history TEXT
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100),
    contact_number VARCHAR(15),
    email VARCHAR(100)
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_time TIME,
    status ENUM('Scheduled', 'Completed', 'Cancelled'),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Prescriptions Table
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    medication TEXT,
    dosage VARCHAR(100),
    instructions TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Patients
INSERT INTO Patients (name, gender, dob, contact_number, address, medical_history) VALUES
('Bhavya Reddy', 'Female', '2000-05-12', '9876543210', 'Pedapadu, AP', 'Asthma'),
('Ravi Kumar', 'Male', '1995-08-20', '9123456780', 'Vijayawada, AP', 'Diabetes');

-- Doctors
INSERT INTO Doctors (name, specialization, contact_number, email) VALUES
('Dr. Meena Sharma', 'Cardiologist', '9001112233', 'meena@hospital.com'),
('Dr. Arjun Rao', 'Dermatologist', '9002223344', 'arjun@hospital.com');

-- Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status) VALUES
(1, 1, '2025-09-10', '10:00:00', 'Completed'),
(2, 2, '2025-09-11', '11:30:00', 'Scheduled'),
(1, 1, '2025-09-12', '09:00:00', 'Scheduled');

-- Prescriptions
INSERT INTO Prescriptions (appointment_id, medication, dosage, instructions) VALUES
(1, 'Aspirin', '75mg', 'Take once daily after breakfast');

#Patient History
SELECT p.name AS patient_name, d.name AS doctor_name, a.appointment_date, pr.medication
FROM Prescriptions pr
JOIN Appointments a ON pr.appointment_id = a.appointment_id
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE p.name = 'Bhavya Reddy';

#Scheduling Conflicts (Same doctor, same time)
SELECT doctor_id, appointment_date, appointment_time, COUNT(*) AS conflict_count
FROM Appointments
GROUP BY doctor_id, appointment_date, appointment_time
HAVING COUNT(*) > 1;

# Doctor with Most Appointments
SELECT d.name, COUNT(*) AS total_appointments
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.name
ORDER BY total_appointments DESC
LIMIT 1;

# Longest Wait Times (Scheduled but not completed)
SELECT p.name AS patient_name, d.name AS doctor_name, a.appointment_date,
       DATEDIFF(CURDATE(), a.appointment_date) AS days_waiting
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE a.status = 'Scheduled'
ORDER BY days_waiting DESC;
