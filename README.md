# Hospital-Patient-Management-System
A relational database project designed to manage patients, doctors, appointments, and prescriptions in a hospital setting. Built using MySQL to demonstrate schema design, foreign key relationships, and real-world query logic.

## Schema Overview

- **Patients**: Stores patient details including contact info and medical history
- **Doctors**: Stores doctor profiles and specializations
- **Appointments**: Tracks scheduled visits, status, and timing
- **Prescriptions**: Records medications and instructions linked to appointments

## Sample Queries

- View a patient's complete prescription history
- Detect scheduling conflicts for doctors
- Identify doctors with the most appointments
- Find patients with the longest wait times for scheduled visits

## How to Run

1. Create the database:
   ```sql
   CREATE DATABASE hospital_db;
   USE hospital_db;

