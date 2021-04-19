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
  FOREIGN KEY (diagnosis_id) REFERENCES Diagnosis(Diagnosis_id),
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
  `amount` DECIMAL(5,2),
  
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
  FOREIGN KEY (medication_id) REFERENCES Medication(medication_id),
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
    FOREIGN KEY (diagnosis_id) REFERENCES Diagnosis(patient_id)
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
(10131, 'gynecologist', 0111123),
(01042, 'dermatologist', 0111124),
(01045, 'psychologist', 0111125),
(01012, 'optometrist', 0111126),
(01023, 'dentist', 0111127),
(01034, 'dietician', 0111128),
(01065, 'ophthalmologist', 0111129),
(01075, 'radiologist', 0111120);

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

-- Medication Table
INSERT INTO Medication 
VALUES (9001, 'Fosamax', 'Alendronate'),
(9002,'Glucophage', 'Metformin'),
(9003,'Glucotrol', 'Glipizide'),
(9004,'Hytrin', 'Terazosin'),
(9005,'Altace', 'Ramipril');

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

-- Inpatient Table
INSERT INTO Inpatient 
VALUES (05001,1001, '2003-04-13', NULL, 01011, 5001, 090000),
(05002,1002, '2021-01-12', NULL, 01022,5002, 050000),
(05003,1003, '2020-04-13','2021-04-21 11-30-14', 01011, 080000),
(05004,1004, '2021-01-11', NULL, 01031, 070000),
(05005,1005, '2021-04-13', NULL, 01042, 010000),
(05006,1006, '2021-04-13', NULL, 01065, 030000),
(05007,1007, '2021-04-13', NULL, 01075, 040000),
(05008,1008, '2021-04-13', NULL, 01034, 090001),
(05009,1009, '2021-04-13', NULL, 01023, 060000),
(05010,1010, '2021-04-13', NULL, 01012, 020000);


-- Outpatient Table
INSERT INTO Outpatient (patient_id, date_of_discharge, doctor_id, bill_status, bill_id)
VALUES (05001, '2011-10-3', 01011, 'paid', 01004),
(05002, '2021-12-2', 01022, 'paid', 01002),
(05003, '2012-01-4', 01031, 'paid', 01001),
(0500, '2011-11-2', 01042, 'paid', 01005),
(05005, '2000-04-5', 01045, 'waived', 01007),
(05006, '2019-05-8', 01012, 'unpaid', 01006),
(05007, '2011-12-11', 01023, 'waived', 01003),
(05008, '2002-04-4', 01034, 'paid', 01009),
(05009, '2002-2-5', 01065, 'paid', 01008),
(05010, '2021-9-9', 01075, 'paid', 010010);

-- Covid_Test
 `appointment_id` INT NOT NULL,
  `appointment_time` DATETIME,
  `doctor_id` INT NULL,
  `patient_id` INT NOT NULL,
/*INSERT INTO Covid_Test (

*/

-- Appointment Table
 `appointment_id` INT NOT NULL,
  `appointment_time` DATETIME,
  `doctor_id` INT NULL,
  `patient_id` INT NOT NULL,
  /*
  INSERT INTO Appointment (appointment_id, appointment_time, doctor_id, patient_id) 
  VALUES (012, '2021-01-01 08-02-11', 01022, 
  
  */
  
  -- Patient_Medication Table
  `patient_id` INT NOT NULL,
    `diagnosis_id` INT NOT NULL,
    `doctor_id` INT NOT NULL,

/*

*/
    
-- Patient_Diagnosis Table

/*

*/
