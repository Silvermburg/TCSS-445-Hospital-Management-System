USE master
IF EXISTS(select * from sys.databases where name='Burgess_Lee_Matthew_Benji_db')
DROP DATABASE Burgess_Lee_Matthew_Benji_db

CREATE DATABASE Burgess_Lee_Matthew_Benji_db

-- Use the created database
USE Burgess_Lee_Matthew_Benji_db;
GO

-- Create Tables
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Date_of_Birth DATE,
    Gender CHAR(1),
    Address VARCHAR(100),
    Contact_Number VARCHAR(20),
    Email_Address VARCHAR(100),
    Emergency_Contact_Name VARCHAR(100),
    Emergency_Contact_Number VARCHAR(20)
);

CREATE TABLE Healthcare_Professional (
    Professional_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Specialty VARCHAR(50),
    License_Number VARCHAR(50),
    Contact_Number VARCHAR(20),
    Email_Address VARCHAR(100)
);

CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Professional_ID INT,
    Date_Time DATETIME,
    Purpose VARCHAR(100),
    Status VARCHAR(20),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Professional_ID) REFERENCES Healthcare_Professional(Professional_ID)
);

CREATE TABLE Diagnosis (
    Diagnosis_ID INT PRIMARY KEY,
    Patient_ID INT,
    Professional_ID INT,
    Date_Time DATETIME,
    Description VARCHAR(1000),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Professional_ID) REFERENCES Healthcare_Professional(Professional_ID)
);

CREATE TABLE Treatment (
    Treatment_ID INT PRIMARY KEY,
    Diagnosis_ID INT,
    Name VARCHAR(100),
    Start_Date DATE,
    End_Date DATE,
    Status VARCHAR(20),
    FOREIGN KEY (Diagnosis_ID) REFERENCES Diagnosis(Diagnosis_ID)
);

CREATE TABLE Medication (
    Medication_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Form VARCHAR(50),
    Strength VARCHAR(50),
    Manufacturer VARCHAR(100),
    Cost_Per_Unit DECIMAL(10, 2)
);

CREATE TABLE Prescription (
    Prescription_ID INT PRIMARY KEY,
    Treatment_ID INT,
	Medication_ID INT,
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    Duration INT,
    FOREIGN KEY (Treatment_ID) REFERENCES Treatment(Treatment_ID),
	FOREIGN KEY (Medication_ID) REFERENCES Medication(Medication_ID)
);

CREATE TABLE Test (
    Test_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description VARCHAR(1000),
    Cost DECIMAL(10, 2)
);

CREATE TABLE Lab_Result (
    Result_ID INT PRIMARY KEY,
    Test_ID INT,
    Patient_ID INT,
    Date_Time DATETIME,
    Result VARCHAR(1000),
    Status VARCHAR(20),
    FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

CREATE TABLE Medical_Equipment (
    Equipment_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description VARCHAR(1000),
    Status VARCHAR(20),
    Location VARCHAR(100)
);

CREATE TABLE Room (
    Room_Number INT PRIMARY KEY,
    Type VARCHAR(50),
    Status VARCHAR(20),
    Capacity INT
);

CREATE TABLE Admission (
    Admission_ID INT PRIMARY KEY,
    Patient_ID INT,
    Room_Number INT,
    Admission_Date DATETIME,
    Discharge_Date DATETIME,
    Reason VARCHAR(1000),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Room_Number) REFERENCES Room(Room_Number)
);

CREATE TABLE Bill (
    Bill_ID INT PRIMARY KEY,
    Patient_ID INT,
    Date_Time DATETIME,
    Amount DECIMAL(10, 2),
    Status VARCHAR(20),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

CREATE TABLE Insurance (
    Insurance_ID INT PRIMARY KEY,
    Patient_ID INT,
    Provider_Name VARCHAR(100),
    Policy_Number VARCHAR(100),
    Coverage_Details VARCHAR(1000),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

CREATE TABLE Schedule (
    Schedule_ID INT PRIMARY KEY,
    Professional_ID INT,
    Start_Date_Time DATETIME,
    End_Date_Time DATETIME,
    FOREIGN KEY (Professional_ID) REFERENCES Healthcare_Professional(Professional_ID)
);

-- Insert Data
-- Insert sample data into each table

-- Insert sample data into the Patient table
INSERT INTO Patient (Patient_ID, First_Name, Last_Name, Date_of_Birth, Gender, Address, Contact_Number, Email_Address, Emergency_Contact_Name, Emergency_Contact_Number)
VALUES
    (1, 'John', 'Doe', '1985-05-10', 'M', '123 Main St', '1234567890', 'johndoe@gmail.com', 'Jane Doe', '9795066994'),
    (2, 'Jane', 'Smith', '1990-12-15', 'F', '456 Elm St', '9876543210', 'janesmith@hotmail.com', 'Paul Smith', '7737940037'),
	(3, 'Jackie', 'Brown', '1997-03-31', 'F', '234 Main St', '9257126408 ', 'jackiebrown@gmail.com', 'Jim Brown', '0987654321'),
    (4, 'Paul', 'Smith', '2000-09-20', 'M', '456 Elm St', '7737940037 ', 'paulsmith@hotmail.com', 'Jane Smith', '9876543210'),
	(5, 'Jennie', 'Miller', '1985-07-24', 'M', '707 Brook St', '0806088694 ', 'jenniemiller@gmail.com', 'Jack Miller', '8537343068'),
    (6, 'Andrew', 'White', '2007-08-10', 'M', '247 Pike St', '8162144686 ', 'andrewwhite@gmail.com', 'Sydney White', '4554003833');

-- Insert sample data into the Healthcare_Professional table
INSERT INTO Healthcare_Professional (Professional_ID, First_Name, Last_Name, Specialty, License_Number, Contact_Number, Email_Address)
VALUES
    (1, 'Dr. Michael', 'Johnson', 'Cardiology', 'MD12345', '5551234567', 'michaeljohnson@gmail.com'),
    (2, 'Dr. Emily', 'Williams', 'PCP', 'MD67890', '5559876543', 'emilywilliams@gmail.com'),
	(3, 'Dr. Jason', 'Adams', 'Pediatrics', 'MD95679', '8615399389', 'jasonadams@gmail.com'),
	(4, 'Dr. Jessie', 'Brock', 'Otolaryngologist', 'MD75777', '1988288003', 'jessiebrock@gmail.com'),
	(5, 'Dr. James', 'McMillan', 'Dermatologist', 'MD96437', '2280429254 ', 'jamesmcmillan@gmail.com');

-- Insert sample data into the Appointment table
INSERT INTO Appointment (Appointment_ID, Patient_ID, Professional_ID, Date_Time, Purpose, Status)
VALUES
    (1, 1, 1, '2023-05-24 10:00:00', 'Routine checkup', 'Completed'),
    (2, 2, 2, '2023-05-25 14:30:00', 'Routine checkup', 'Completed'),
	(3, 2, 2, '2023-05-27 12:00:00', 'Follow-up appointment', 'Completed'),
	(4, 4, 2, '2022-05-30 09:00:00', 'Routine checkup', 'Completed'),
	(5, 1, 1, '2023-06-01 12:00:00', 'Follow-up appointment', 'Completed'),
	(6, 6, 5, '2023-06-10 12:00:00', 'Urgent checkup', 'Completed'),
	(7, 6, 4, '2023-06-12 10:00:00', 'Routine checkup', 'Completed');

-- Insert sample data into the Diagnosis table
INSERT INTO Diagnosis (Diagnosis_ID, Patient_ID, Professional_ID, Date_Time, Description)
VALUES
    (1, 1, 1, '2023-05-24 10:30:00', 'High blood pressure'),
    (2, 2, 2, '2023-05-25 15:00:00', 'Sore Throat'),
	(3, 4, 2, '2022-05-30 09:00:00', 'Arthritis'),
	(4, 1, 1, '2023-06-01 12:00:00', 'Fatigue'),
	(5, 6, 5, '2023-06-10 12:00:00', 'Ringworm'),
	(6, 6, 4, '2023-06-12 10:00:00', 'Arthritis');

-- Insert sample data into the Treatment table
INSERT INTO Treatment (Treatment_ID, Diagnosis_ID, Name, Start_Date, End_Date, Status)
VALUES
    (1, 1, 'Medication A', '2023-05-24', '2023-07-02', 'Ongoing'),
    (2, 2, 'Rest and fluids', '2023-05-25', '2023-05-30', 'Completed'),
	(3, 3, 'Medication B', '2023-05-30', NULL, 'Ongoing'),
	(4, 4, 'Medication C', '2023-06-01', NULL, 'Ongoing'),
	(5, 5, 'Medication E', '2023-06-10', NULL, 'Ongoing'),
	(6, 6, 'Medication B', '2023-06-12', NULL, 'Ongoing');

-- Insert sample data into the Medication table
INSERT INTO Medication (Medication_ID, Name, Form, Strength, Manufacturer, Cost_Per_Unit)
VALUES
    (1, 'Medication A', 'Tablet', '50 mg', 'Manufacturer X', 10.99),
	(2, 'Medication B', 'Capsule', '100 mg', 'Manufacturer Y', 15.99),
	(3, 'Medication C', 'Fluid', '10 oz', 'Manufacturer X', 13.99),
	(4, 'Medication D', 'Tablet', '50 mg', 'Manufacturer X', 17.99),
	(5, 'Medication E', 'Tablet', '50 mg', 'Manufacturer X', 18.99),
	(6, 'Medication F', 'Tablet', '50 mg', 'Manufacturer X', 9.99);

-- Insert sample data into the Prescription table
INSERT INTO Prescription (Prescription_ID, Treatment_ID, Medication_ID, Dosage, Frequency, Duration)
VALUES
    (1, 1, 1, '1 tablet', 'Once daily', 10),
	(2, 3, 2, NULL, NULL, 10),
	(3, 4, 3, '10 mL', 'Once daily', 10),
	(4, 5, 5, '1 capsule', 'Twice daily', 10),
	(5, 6, 2, '1 tablet', 'Once daily', 10);

-- Insert sample data into the Test table
INSERT INTO Test (Test_ID, Name, Description, Cost)
VALUES
    (1, 'Blood Test', 'Complete blood count', 50.00),
    (2, 'X-ray', 'Chest X-ray', 100.00);

-- Insert sample data into the Lab_Result table
INSERT INTO Lab_Result (Result_ID, Test_ID, Patient_ID, Date_Time, Result, Status)
VALUES
    (1, 1, 1, '2023-05-24 11:00:00', 'Normal', 'Final'),
    (2, 2, 2, '2023-05-25 16:00:00', 'No abnormalities detected', 'Final');

-- Insert sample data into the Medical_Equipment table
INSERT INTO Medical_Equipment (Equipment_ID, Name, Description, Status, Location)
VALUES
    (1, 'Equipment A', 'Description of Equipment A', 'Available', 'Storage Room'),
    (2, 'Equipment B', 'Description of Equipment B', 'In Use', 'Room 101');

-- Insert sample data into the Room table
INSERT INTO Room (Room_Number, Type, Status, Capacity)
VALUES
    (101, 'Standard', 'Available', 2),
    (102, 'ICU', 'In Use', 1);

-- Insert sample data into the Admission table
INSERT INTO Admission (Admission_ID, Patient_ID, Room_Number, Admission_Date, Discharge_Date, Reason)
VALUES
    (1, 1, 102, '2023-05-24 10:00:00', '2023-05-27 14:00:00', 'Critical condition'),
    (2, 2, 101, '2023-05-25 14:30:00', '2023-05-25 15:30:00', 'Observation');

-- Insert sample data into the Bill table
INSERT INTO Bill (Bill_ID, Patient_ID, Date_Time, Amount, Status)
VALUES
    (1, 1, '2023-05-25 09:00:00', 500.00, 'Pending'),
    (2, 2, '2023-05-26 11:30:00', 250.00, 'Paid');

-- Insert sample data into the Insurance table
INSERT INTO Insurance (Insurance_ID, Patient_ID, Provider_Name, Policy_Number, Coverage_Details)
VALUES
    (1, 1, 'Insurance Provider X', 'POL12345', 'Coverage details for patient 1'),
    (2, 2, 'Insurance Provider Y', 'POL67890', 'Coverage details for patient 2');

-- Insert sample data into the Schedule table
INSERT INTO Schedule (Schedule_ID, Professional_ID, Start_Date_Time, End_Date_Time)
VALUES
    (1, 1, '2023-05-24 09:00:00', '2023-05-24 17:00:00'),
    (2, 2, '2023-05-25 09:00:00', '2023-05-25 16:00:00');

-- Scenario 1: Patient registration and updating of personal information
-- viewing current patient information
SELECT * FROM Patient;
-- registering new patient
INSERT INTO Patient (Patient_ID, First_Name, Last_Name, Date_of_Birth, Gender, Address, Contact_Number, Email_Address, Emergency_Contact_Name, Emergency_Contact_Number)
VALUES
	(7, 'Gates', 'Bill', '1955-08-28', 'M', '789 Baker St', '1352463579', 'billy@hotmail.com', 'Melinda Gates', '2463570000');
-- updating patient information
UPDATE Patient
SET Email_Address='johndoe@yahoo.com'
WHERE Patient_ID=1;
-- viewing updated patient information
SELECT * FROM Patient;

-- Scenario 2: Healthcare professional management
-- viewing current healthcare professional information
SELECT * FROM Healthcare_Professional;
-- entering new healthcare professional's information
INSERT INTO Healthcare_Professional (Professional_ID, First_Name, Last_Name, Specialty, License_Number, Contact_Number, Email_Address)
VALUES
    (6, 'Dr. Phil', 'McGraw', 'Psychology', 'MD46034', '5551567574', 'doctorphil@yahoo.com');
-- updating healthcare professional's information
UPDATE Healthcare_Professional
SET Email_Address='doctormike@google.com'
WHERE Professional_ID=1;
-- viewing updated healthcare professional information
SELECT * FROM Healthcare_Professional;

-- Scenario 3: Appointment booking, modification, and cancellation
-- viewing current appointments
SELECT * FROM Appointment;
-- adding information of another appointment
INSERT INTO Appointment (Appointment_ID, Patient_ID, Professional_ID, Date_Time, Purpose, Status)
VALUES
    (8, 7, 6, '2023-07-03 11:00:00', 'Therapy Session', 'Scheduled');
-- modifying appointment date/time
UPDATE Appointment
SET Date_Time='2023-07-03 12:00:00'
WHERE Appointment_ID=3;
-- viewing updated appointments
SELECT * FROM Appointment;

-- Scenario 4: Generating and updating diagnoses, treatments, and prescriptions
-- viewing current diagnoses, treatments, prescriptions and their information
SELECT * FROM Diagnosis;
SELECT * FROM Treatment;
SELECT * FROM Prescription;
-- entering new diagnoses, treatments, and prescriptions
INSERT INTO Diagnosis (Diagnosis_ID, Patient_ID, Professional_ID, Date_Time, Description)
VALUES
    (7, 7, 6, '2023-07-03 12:00:00', 'Social Anxiety');
INSERT INTO Treatment (Treatment_ID, Diagnosis_ID, Name, Start_Date, End_Date, Status)
VALUES
    (7, 7, 'Counseling and Medication F', '2023-07-03', NULL, 'Ongoing');
INSERT INTO Prescription (Prescription_ID, Treatment_ID, Medication_ID, Dosage, Frequency, Duration)
VALUES
    (6, 7, 6, '2 pills', 'Once daily', 10);
-- updating prescription with ID '2', entering information for medicine name, dosage, frequency, and duration which were previously NULL or zero
UPDATE Prescription
SET Dosage='2 tablets', Frequency='Once daily'
WHERE Prescription_ID=2;
-- viewing updated information
SELECT * FROM Diagnosis;
SELECT * FROM Treatment;
SELECT * FROM Prescription;

-- Scenario 5: Managing lab tests and results
-- viewing current information
SELECT * FROM Test;
SELECT * FROM Lab_Result;
-- insert new test and results
INSERT INTO Test (Test_ID, Name, Description, Cost)
VALUES
    (3, 'Anxiety Assessment', 'Multiple choice questionare to measure symptoms', 0.00);
INSERT INTO Lab_Result (Result_ID, Test_ID, Patient_ID, Date_Time, Result, Status)
VALUES
    (3, 3, 7, '2023-07-03 12:00:00', 'Normal', 'Ongoing');
-- updating pricing for test with Test_ID '1' to 25.00
UPDATE Test
SET Cost=25.00
WHERE Test_ID=1;
-- viewing updated information
SELECT * FROM Test;
SELECT * FROM Lab_Result;

-- Scenario 6: Tracking and maintaining medical equipment inventory
-- viewing current information
SELECT * FROM Medical_Equipment;
-- enter new medical equipment's information
INSERT INTO Medical_Equipment (Equipment_ID, Name, Description, Status, Location)
VALUES
    (3, 'Equipment C', 'Description of Equipment C', 'Available', 'Storage Room');
-- updating status of medical equipment with ID '1' to 'In Use'
UPDATE Medical_Equipment
SET Status='In Use'
WHERE Equipment_ID=1;
-- viewing updated information
SELECT * FROM Medical_Equipment;

-- Scenario 7: Room allocation and management for inpatient care
-- viewing current rooms and admission information
SELECT * FROM Room;
SELECT * FROM Admission;
-- adding new room and new admission
INSERT INTO Room (Room_Number, Type, Status, Capacity)
VALUES
    (103, 'Standard', 'In Use', 2);
INSERT INTO Admission (Admission_ID, Patient_ID, Room_Number, Admission_Date, Discharge_Date, Reason)
VALUES
    (3, 7, 103, '2023-07-03 12:00:00', '2023-07-03 13:30:00', 'Evaluation');
-- updating room '103' to have status 'Available'
UPDATE Room
SET Status='Available'
WHERE Room_Number=103;
-- updating admission information with ID '2', setting patient's discharge date to '2023-05-25'
UPDATE Admission
SET Discharge_Date='2023-05-25 16:00:00'
WHERE Admission_ID=2;
-- viewing updated rooms and admission information
SELECT * FROM Room;
SELECT * FROM Admission;

-- Analytical Query 1: Calculate the average duration of stay for patients in each room type.
SELECT Type, AVG(DATEDIFF(minute,Admission_Date, Discharge_Date)) AS AvgDurMinutes
FROM Room RIGHT OUTER JOIN Admission ON Room.Room_Number = Admission.Room_Number
GROUP BY Type
ORDER BY AvgDurMinutes;

-- Analytical Query 2: Find the top 5 medications based on number of perscriptions, ordered from least to most expensive.
SELECT TOP 5 P.Medication_ID, Name, Cost_Per_Unit, COUNT(P.Medication_ID) AS PerscribedCount
FROM Prescription AS P LEFT OUTER JOIN Medication AS M ON P.Medication_ID = M.Medication_ID
GROUP BY P.Medication_ID, Name, Cost_Per_Unit
ORDER BY PerscribedCount DESC, Cost_Per_Unit ASC;

-- Analytical Query 3: Identify the busiest healthcare professionals based on the number of appointments and treatments.
SELECT C.Professional_ID, First_Name, Last_Name, COUNT(C.Professional_ID) AS AppointmentAndTreatments
FROM (SELECT Professional_ID, Appointment_ID FROM Appointment
	  UNION ALL
	  SELECT Professional_ID, Treatment_ID FROM Diagnosis AS D LEFT OUTER JOIN Treatment AS T ON T.Diagnosis_ID = D.Diagnosis_ID)
	 AS C LEFT OUTER JOIN Healthcare_Professional ON C.Professional_ID = Healthcare_Professional.Professional_ID
GROUP BY C.Professional_ID, First_Name, Last_Name
ORDER BY AppointmentAndTreatments DESC;

-- Analytical Query 4: Determine the percentage of patients who use insurance to cover their medical expenses
SELECT (COUNT(DISTINCT Insurance.Patient_ID) * 100.0/COUNT(DISTINCT Patient.Patient_ID)) AS PctWithInsurance
FROM Patient LEFT OUTER JOIN Insurance on Patient.Patient_ID = Insurance.Patient_ID;

-- Analytical Query 5: Calcualate the average amount of pending bills at the hospital
SELECT AVG(Amount) AS AvgPendingBill
FROM Bill
WHERE Status='Pending';