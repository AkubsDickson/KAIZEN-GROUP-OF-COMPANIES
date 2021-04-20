DROP DATABASE IF EXISTS Nyaho_Medical;
CREATE DATABASE Nyaho_Medical;
USE Nyaho_Medical;

-- Person Table
CREATE TABLE `Person` (
  `first_name` VARCHAR(50) NOT NULL,
  `middle_name` VARCHAR(50),
  `last_name` VARCHAR(50) NOT NULL,
  `gender` ENUM('M', 'F'),
  `age` INT,
  `phone_number` varchar(12),
  `email` VARCHAR(25) CHECK (email LIKE '%@%') NOT NULL,
  `person_id` INT NOT NULL,
  
  PRIMARY KEY (`person_id`)
);

-- Doctor Table
CREATE TABLE `Doctor` (
  `doctor_id` INT  NOT NULL,
  `specialty` VARCHAR(50),
  `person_id` INT NOT NULL,
  
  PRIMARY KEY (`doctor_id`),
  FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

-- Diagnosis Table
CREATE TABLE `Diagnosis` (
  `diagnosis_id` INT NOT NULL,
  `diagnosis_name` VARCHAR(50),
  
  PRIMARY KEY (`diagnosis_id`)
);

-- Patient Table
CREATE TABLE `Patient` (
  `patient_id` INT NOT NULL,
  `doctor_id` INT,
  `person_id` INT,
  
  
  PRIMARY KEY (`patient_id`),
  FOREIGN KEY (person_id) REFERENCES Person(person_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Nurse Table
CREATE TABLE `Nurse` (
  `nurse_id` INT NOT NULL,
  `nurse_type` VARCHAR(50),
  `person_id` INT NOT NULL,
  `doctor_id` INT,
  
  PRIMARY KEY (`nurse_id`),
  FOREIGN KEY (person_id) REFERENCES Person(person_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Laboratory Table
CREATE TABLE `Laboratory` (
  `lab_id` INT NOT NULL,
  `patient_id` INT,
  `doctor_id` INT,
  `date_visited` DATETIME,
  `amount` DECIMAL(8,2),
  
  PRIMARY KEY (`lab_id`),
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Medication Table
CREATE TABLE `Medication` (
  `medication_id` INT NOT NULL,
  `brand_name` VARCHAR(50),
  `generic_name` VARCHAR(50),
  
  PRIMARY KEY (`medication_id`)
);

-- Bill Table
CREATE TABLE `Bill` (
  `bill_id` INT NOT NULL,
  `doctor_charge` DECIMAL(5,2),
  `room_charge` DECIMAL(5,2),
  `number_of_days` INT NOT NULL,
  `lab_charge` DECIMAL(5,2),
  `patient_id` INT NOT NULL,
  
  PRIMARY KEY (`bill_id`),
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Ward Table
CREATE TABLE `Ward` (
  `ward_id` INT NOT NULL,
  `ward_name` VARCHAR(50),
  
  PRIMARY KEY (`ward_id`)
);

-- Room Table
CREATE TABLE `Room` (
  `room_id` INT NOT NULL,
  `room_type` VARCHAR(50),
  `room_status` INT CHECK (room_status > 0 & room_status <= 4),
  `ward_id` INT NOT NULL,
  `nurse_id` INT,
  
  PRIMARY KEY (`room_id`),
  FOREIGN KEY (ward_id) REFERENCES Ward(ward_id),
  FOREIGN KEY (nurse_id) REFERENCES Nurse(nurse_id)
);

-- Inpatient Table
CREATE TABLE `Inpatient` (
  `patient_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  `date_of_admission` DATETIME NOT NULL,
  `time_of_death` DATETIME,
  `doctor_id` INT,
  `lab_id` INT,
  `ward_id` INT,
  
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  FOREIGN KEY (room_id) REFERENCES Room(room_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
  FOREIGN KEY (lab_id) REFERENCES Laboratory(lab_id),
  FOREIGN KEY (ward_id) REFERENCES Ward(ward_id)
);

-- Outpatient Table
CREATE TABLE `Outpatient` (
  `patient_id` INT NOT NULL,
  `date_of_discharge` DATETIME,
  `bill_status` ENUM('paid', 'unpaid', 'waived'),
  `doctor_id` INT,
  `bill_id` INT,
  
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
  FOREIGN KEY (bill_id) REFERENCES Bill(bill_id)
);

-- Covid_Test Table
CREATE TABLE `Covid_Test` (
  `test_id` INT NOT NULL,
  `has_tested` BOOLEAN,
  `test_status` ENUM('positive', 'negative'),
  `person_id` INT,
  `doctor_id` INT,
  
  PRIMARY KEY (`test_id`),
  FOREIGN KEY (person_id) REFERENCES Person(person_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Appointment Table
CREATE TABLE `Appointment` (
  `appointment_id` INT NOT NULL,
  `appointment_time` DATETIME,
  `doctor_id` INT NULL,
  `patient_id` INT NOT NULL,
  
  PRIMARY KEY (`appointment_id`),
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);


-- Patient_Diagnosis Table
CREATE TABLE `Patient_Diagnosis` (
	`patient_id` INT NOT NULL,
	`diagnosis_id` INT NOT NULL,
	`doctor_id` INT NOT NULL,
	
	FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
	FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
	FOREIGN KEY (diagnosis_id) REFERENCES Diagnosis(diagnosis_id)
);

-- Patient_Medication Table
CREATE TABLE `Patient_Medication` (
	`patient_id` INT NOT NULL,
	`medication_id` INT NOT NULL,
    
	FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
	FOREIGN KEY (medication_id) REFERENCES Medication(medication_id)
);
      


#Populating the Tables

-- Person Table
INSERT INTO Person (first_name, middle_name, last_name, gender,age, phone_number,email,person_id)
 VALUES ('Chris','Martin','Kelvin','M',19,'01123147789','aiudni@gmail.com',0111111),
 ('Chrisie','Martyn','Kelsa','F',21,'0113147789','aiudn@gmail.com',0111122),
 ('Mark','Watkins','Dan','M',29,'01174592013','sks@gmail.com',0111123),
 ('Daniel','Williams','Walter','M',37,NULL,'dwalter@outlook.com',0111124),
 ('Sarah','Taylor','Serop','F',39,'01176348290','sjns@gmail.com',0111125),
 ('Katie','B','Armstrong','F',29,'01145787353','wjsi@yahoomail.com',0111126),
 ('Kat',NULL,'Nash','F',50,'0114577353','katenash@hotmail.com',0111127),
 ('Buster','Aong','Yaw','F',40,'01145787353','aobuster@gmail.com',0111128),
 ('Charlie',NULL,'Faith','F',23,'01145787353','charliefaith@outlook.com',0111129),
 ('Lindsay','Sena','Bluth','F',22,'01145787353','senaluth@gmail.com',0111120),
 ('Harry','E','Johnson','F',42,'0245555890','hejohnson@hotmail.com',01111206),
 ('Joan','Armstrong','Smith','F',43,'0246667876','jsmith@outlook.com',01111207),
 ('John','Dwayne','Taylor','M',3,'0247546732','jdtaylor@outlook.com',01111208),
 ('Emma','Elois','Smith','F',30,'0248453728','eesmith15@hotmail.com',01111209),
 ('Gob','Toby','Bluth','M',53,'0249564467','g.tobybluth@gobbluth.com',01111210),
 ('Mike','Kofi','Addo','M',8,'02244424521','kay@gmail.com',01111201),
('Daryl','Osei','Darko','M',55,'01114897177','dos@gmail.com',01111202),
('Mary','Abiba','Mettle','F',75,'01117914444','mos@gmail.com','01111203'),
('Khrys','Jeny','Kutin','F',2,'01117770147','kjt@gmail.com','01111287'),
('Alfred','Kusi','Boateng','M',100,'01117843531','alf@gmail.com',01111204),
('Rebecca',NULL,'Ofori','F',34,'0207492013','rebmills@gmail.com',0111300),
('Abena','Nana','Debrah','F',23,'0209595423','abenan@gmail.com',0111301),
('Dylan','Kofi','Sylan','M',21,'0207492013','dylsyl@gmail.com',0111302),
('Michaek','Yaw','Opana','M',21,'0207492013','micopa@gmail.com',0111303),
('Efua','Mariam','Asante','F',23,'0542323234','efuaasa@gmail.com',0111304),
('Kellen','Maame','Bonsu','F',24,'0207492013','kellmill@gmail.com',0111305),
('Bishop','Sarpong','Mensah','M',21,'0207492013','bissar@gmail.com',0111306),
('Jesse','Kwabenya','Kuma','M',34,'0207492013','jeskuma@gmail.com',0111307),
('Abena',NULL,'Fianko','F',24,'05023123223','abefia@gmail.com',0111308),
('Beyonce','Esi','White','F',64,'02045643423','beyesi@gmail.com',0111309),
('Rihanna','Mabel','West','F',56,'05445643423','rima@gmail.com',0111310);

-- Doctor Table
INSERT INTO Doctor (doctor_id, specialty, person_id)
VALUES (01011, 'chiropractor', 0111111), 
(01022, 'pediatrician', 0111122),
(01031, 'gynecologist', 0111123),
(01042, 'dermatologist', 0111124),
(01045, 'psychologist', 0111125),
(01012, 'optometrist', 0111126),
(01023, 'dentist', 0111127),
(01034, 'dietician', 0111128),
(01065, 'ophthalmologist', 0111129),
(01075, 'radiologist', 0111120);

-- Diagnosis Table
INSERT INTO Diagnosis 
VALUES (12211,'tuberculosis'),
(19331,'malaria'), 
(19219,'asthma'),
(12121,'stomache ache'),
(12111,'diarrhea'),
(11231,'chlamydia'),
(12311,'syphilis'),
(01112,'allergies'),
(14222,'avianinfluenza'),
(15433,'arthritis');

-- Patient Table
INSERT INTO Patient (patient_id, person_id, doctor_id)
VALUES (05001,0111300,01011),
(05002,0111301,01022),
(05003,0111302,01031),
(05004,0111303,01042),
(05005,0111304,01045),
(05006,0111305,01012),
(05007,0111306,01023),
(05008,0111307,01034),
(05009,0111308,01065),
(05010,0111310,01075);

-- Nurse Table
INSERT INTO Nurse (nurse_id, nurse_type, person_id, doctor_id)
VALUES (100121, 'geriatric nurse', 0111300, 01011),
(100122, 'ER nurse', 0111301, 01022),
(100123, 'mental health nurse', 0111302, 01045),
(100124, 'oncology nurse', 0111303, 01023),
(100125, 'orthopedic nurse', 0111304, 01022),
(100126, 'pediatric nurse', 0111305, 01042),
(100127, 'surgical nurse', 0111306, 01012),
(100128, 'neonatal nurse', 0111307,01034),
(100129, 'intensive care nurse', 0111308, 01065),
(100130, 'nursing assistant', 0111309, 01075);

-- Laboratory
INSERT INTO Laboratory 
VALUES (5001, 05001, 01031, '2021-03-11 09-02-14', 500.00),
(5002, 05002, 01042, '2017-01-01 08-02-11', 200.0),
(5003, 05003, 01011, '2019-02-01 13-20-13', 150.00),
(5004, 05004, 01022, '2020-02-01 14-15-12', 200.00),
(5005, 05005, 01065, '2021-02-17 15-05-00', 1500.00),		       
(5006, 05006, 01012, '2021-04-18 08-33-27', 2000.00),		       
(5007, 05007, 01075, '2018-06-10 11-05-34', 150.00),    
(5008, 05008, 01034, '2021-01-18 09-12-56', 400.00),
(5009, 05009, 01045, '2020-05-14 10-05-15', 1000.00),			       
(50010, 05010,01023, '2019-06-20 16-11-20', 400.00);

-- Medication Table
INSERT INTO Medication 
VALUES (9001, 'Fosamax', 'Alendronate'),
(9002,'Glucophage', 'Metformin'),
(9003,'Glucotrol', 'Glipizide'),
(9004,'Hytrin', 'Terazosin'),
(9005,'Altace', 'Ramipril'),
(9006, 'Amaryl', 'Glimepiride'),
(9007, 'Celexa', 'Citalopram'),
(9008, 'Diabeta', 'Glyburide'),
(9009, 'Imitrex', 'Sumatriptan'),
(9010, 'Mevacor', 'Iovastatin');


-- Bill Table
INSERT INTO Bill 
VALUES (01001, 200, 150, 4, 100, 05001),
(01002, 100, 110, 3, 80, 05002),
(01003, 90, 50, 5, 120, 05003),
(01004, 60, 150, 1, 170, 05004),
(01005, 70, 140, 2, 111, 05005),
(01006, 220, 114, 6, 10, 05006),
(01007, 250, 10, 9, 133, 05007),
(01008, 210, 199, 10, 153, 05008),
(01009, 161, 159, 7, 171, 05009),
(010010, 187, 180, 8, 181, 05010);

-- Ward Table
INSERT INTO Ward 
VALUES (010000,'Pediatrics'),
(020000,'Infectious Diseases'),
(030000,'Adult'),
(040000,'Accident'),
(050000,'Emergency'),
(060000,'Geriatics'),
(070000,'Pychiatric'),
(080000,'Maternity ward'),
(090000,'Intensive Care'),
(090001,'Surgery');

-- Room Table
INSERT INTO Room 
VALUES (1001,'2-bed',0,010000,100121),
(1002,'4-bed',1,020000,100122),
(1003,'2-bed',2,030000,100123),
(1004,'2-bed',1,040000,100124),
(1005,'4-bed',4,050000,100125),
(1006,'3-bed',1,060000,100126),
(1007,'1-bed',1,070000,100127),
(1008,'2-bed',1,080000,100128),
(1009,'3-bed',1,090000,100129),
(1010,'1-bed',1,090001,100130);

-- Inpatient Table
INSERT INTO Inpatient  ( patient_id, room_id, date_of_admission, time_of_death, doctor_id, lab_id, ward_id)
VALUES (05001,1001, '2003-04-13', NULL, 01011, 5001,010000),
(05002,1002, '2021-01-12', NULL, 01022,5002,020000),
(05003,1003, '2020-04-13','2021-04-21 11-30-14', 01011,5003,030000),
(05004,1004, '2021-01-11', NULL, 01031, 5004,040000),
(05005,1005, '2021-04-13', NULL, 01042, 5005,050000),
(05006,1006, '2021-04-13', NULL, 01065, 5006,060000),
(05007,1007, '2021-04-13', NULL, 01075, 5007,070000),
(05008,1008, '2021-04-13', NULL, 01034, 5008,080000),
(05009,1009, '2021-04-13', NULL, 01023, 5009,090000 ),
(05010,1010, '2021-04-13', NULL, 01012, 50010,090001);

-- Outpatient Table
INSERT INTO Outpatient (patient_id, date_of_discharge, doctor_id, bill_status, bill_id)
VALUES (05001, '2011-10-3', 01011, 'paid', 01004),
(05002, '2021-12-2', 01022, 'paid', 01002),
(05003, '2012-01-4', 01031, 'paid', 01001),
(05004, '2011-11-2', 01042, 'paid', 01005),
(05005, '2000-04-5', 01045, 'waived', 01007),
(05006, '2019-05-8', 01012, 'unpaid', 01006),
(05007, '2011-12-11', 01023, 'waived', 01003),
(05008, '2002-04-4', 01034, 'paid', 01009),
(05009, '2002-2-5', 01065, 'paid', 01008),
(05010, '2021-9-9', 01075, 'paid', 010010);

-- Covid_Test
INSERT INTO Covid_Test (test_id,has_tested,test_status,person_id,doctor_id)
VALUES (05011, TRUE, 'negative', 0111300, 01011),
(05012, TRUE, 'positive', 0111301, 01022),
(05013, TRUE, 'negative', 0111302, 01031),
(05014, TRUE, 'positive', 0111303, 01042),
(05015, TRUE, 'positive', 0111304, 01045),
(05016, TRUE, 'positive', 0111305, 01012),
(05017, TRUE, 'negative', 0111306, 01023),
(05018, TRUE, 'negative', 0111307, 01034),
(05019, TRUE, 'negative', 0111308, 01065),
(05020, TRUE, 'positive', 0111310, 01075);

-- Appointment Table
INSERT INTO APPOINTMENT (appointment_id, appointment_time, doctor_id, patient_id)
VALUES (070300,'2017-01-01 08-02-11', 01011, 05001),
(070301,' 2017-02-03 08-33-49', 01022, 05002),
(070302, '2017-02-13 12-34-56', 01031, 05003),
(070303, '2017-01-27 09-23-57', 01042, 05004),
(070304, '2017-01-28 11-55-33', 01045, 05005),
(070305, '2019-02-27 12-12-34', 01012, 05006),
(070306, '2021-04-25 11-32-54', 01023, 05007),
(070307, '2020-02-17 13-41-17', 01034, 05008),
(070308, '2020-02-17 13-41-17', 01065, 05009),
(070309, '2020-02-17 13-41-17', 01075, 05010);

  
  
  -- Patient_Medication Table
INSERT INTO Patient_Medication
VALUES (05001,9001),
(05002,9002),
(05003,9003),
(05004,9004),
(05005,9005),
(05006,9006),
(05007,9007),
(05008,9008),
(05009,9009),
(05010,9010);
    
-- Patient_Diagnosis Table
INSERT INTO patient_Diagnosis
VALUES (05001,12211,01011),
(05002,19331,01022),
(05003,19219,01031),
(05004,12121,01042),
(05005,12111,01045),
(05006,11231,01012),
(05007,12311,01023),
(05008,01112,01034),
(05009,14222,01065),
(05010,15433,01075);


--  Functionalities
-- 1. Show empty rooms so nurses can assign rooms and corresponding ward to patients.
SELECT Ward.ward_name, Room.room_id, Room.room_type, Room.room_status
FROM Ward
INNER JOIN Room
ON Ward.ward_id = Room.ward_id
ORDER BY Room.room_status ASC;

-- 3. Help the hospital keep track of tested patients and their corresponding details 
SELECT Person.first_name, Person.last_name, Person.gender, Person.phone_number, Person.email
FROM Person
INNER JOIN Covid_Test
ON Person.person_id = Covid_Test.person_id
WHERE Covid_Test.has_tested = TRUE & Covid_Test.test_status = 'positive' AND Person.phone_number IS NOT NULL;
