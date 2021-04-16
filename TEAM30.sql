--New file below

drop database nyahomedical;
CREATE DATABASE nyahomedical;
USE nyahomedical;

-- Person table
CREATE TABLE person (
	first_name varchar(25) NOT NULL,
    middle_name varchar(25),
    last_name varchar(25) NOT NULL,
    gender enum('M', 'F'),
    age INT,
    phone_number varchar(20),
    email varchar(25) check (email like '%@%'),
    person_id INT PRIMARY KEY NOT NULL 
);



 
-- Doctor table
CREATE TABLE doctor (
	doctor_id int PRIMARY KEY NOT NULL,
    person_id int,
    foreign key doctor(person_id) references person(person_id)
);


-- Diagnosis table
CREATE TABLE diagnosis(
	diagnosis_id INT PRIMARY KEY NOT NULL,
    diagnosis_name varchar (50) 
);

-- Patient table
CREATE TABLE patient(
	patient_id INT PRIMARY KEY NOT NULL ,
    person_id INT NOT NULL,
    diagnosis_id INT NOT NULL,
    doctor_id INT NOT NULL,
    
    foreign key (person_id) references person(person_id),
    foreign key (doctor_id) references doctor(doctor_id),
    foreign key (diagnosis_id) references diagnosis(diagnosis_id)
);




-- Surgeon table
CREATE TABLE surgeon (
	doctor_id int NOT NULL,
    specialty varchar(25) NOT NULL,
    foreign key (doctor_id) references doctor(doctor_id)
);


-- Nurse table
CREATE TABLE nurse(
	nurse_id INT PRIMARY KEY NOT NULL,
    person_id INT NOT NULL,
    doctor_id INT NOT NULL,
    foreign key (person_id) references person(person_id),
    foreign key (doctor_id) references doctor(doctor_id)
);



-- Laboratory table
CREATE TABLE laboratory(
	lab_id INT PRIMARY KEY NOT NULL,
    patient_id INT,
    doctor_id INT,
    date_visited datetime,
    amount decimal,
    
    foreign key (patient_id) references patient(patient_id),
    foreign key (doctor_id) references doctor(doctor_id)
);


-- Medication table
CREATE table medication(
	medication_id INT PRIMARY KEY NOT NULL ,
    medication_name varchar(50)
);

-- Bill table
CREATE TABLE bill(
	bill_id INT PRIMARY KEY NOT NULL,
    doctor_charge decimal NOT NULL,
    room_charge decimal,
    number_of_days int,
    lab_charge decimal,
    patient_id int NOT NULL,
    
    foreign key (patient_id) references patient(patient_id)
);

-- Ward table
CREATE TABLE ward(
	ward_id INT PRIMARY KEY NOT NULL ,
    ward_name varchar(25)
);
-- Room table
CREATE TABLE room(
	room_id INT PRIMARY KEY NOT NULL ,
    roomType varchar(25),
    room_status int,
    ward_id INT NOT NULL,
    nurse_id INT,
    
    foreign key (ward_id) references ward(ward_id),
    foreign key (nurse_id) references nurse(nurse_id)
);

-- Inpatient table
CREATE TABLE inpatient(
	patient_id INT NOT NULL,
    room_id INT NOT NULL,
    date_of_admission date NOT NULL,
    date_of_discharge date,
    time_of_death date,
    doctor_id INT,
    lab_id INT,
    
    foreign key (patient_id) references patient(patient_id),
     foreign key (room_id) references room(room_id),
    foreign key (doctor_id) references doctor(doctor_id),
    foreign key (lab_id) references laboratory(lab_id));
    


-- Outpatient table
CREATE table outpatient(
	patient_id INT NOT NULL,
    date_of_discharge date NOT NULL,
    doctor_id INT,
    
    foreign key (patient_id) references patient(patient_id),
    foreign key (doctor_id) references doctor(doctor_id)
);

-- Blood Bank table
CREATE TABLE bloodbank(
    blood_type varchar(25) ,
    person_id INT,
    
    foreign key (person_id) references person(person_id)
);








INSERT INTO person (first_name, middle_name, last_name, gender,age, phone_number,email,person_id)
 VALUES ('Chris','Martin','Kelvin','M',19,'01123147789','aiudni@gmail.com',0111111),
 ('Chrisie','Martn','Kelsa','M',19,'0113147789','aiudn@gmail.com',0111122),
 ('Mark','Watkins','Dan','M',29,'01174592013','sks@gmail.com',0111123),
 ('Diel','Williams','Walter','M',37,NULL,null,0111124),
 ('Sarah','Taylor','Serop','F',39,'01176348290','sjns@gmail.com',0111125),
 ('Katie','Armstrong','Sena','F',29,'01145787353','wjsi@hotmail.com',0111126),
 ('Kat','Atrong','Sean','F',29,'0114577353','Wiggle@hotmail.com',0111127),
 ('Kok','Aong','Yaw','F',239,'01145787353','wjsi@hotmail.com',0111128),
 ('Kok','Armstrong','Sena','F',23,'01145787353','wjsi@hotmail.com',0111129),
 ('Kok','Armstrong','Sena','F',23,'01145787353','wjsi@hotmail.com',0111120),
 ('Koko','Armstrong','Sena','F',42,'0245555890','Khl@hotmail.com',01111206),
 ('Kodk','Armstrong','Sena','F',43,'0246667876','wsmj@hotmail.com',01111207),
 ('bok','Armstrong','Sena','F',3,'0247546732','wpsi@hotmail.com',01111208),
 ('Kole','Armstrong','Sena','F',30,'0248453728','Lmaoi@hotmail.com',01111209),
 ('Kane','Armstrong','Sena','F',53,'0249564467','wpsi@hotmail.com',01111210),
 ('Mike','Kofi','Addo','M',8,'02244424521','kay@gmail.com',01111201),
('Daryl','Osei','Darko','M',55,'01114897177','dos@gmail.com',01111202),
('Mary','Abiba','Mettle','F',75,'01117914444','mos@gmail.com','01111203'),
('Khrys','Jeny','Kutin','F',2,'01117770147','kjt@gmail.com','01111287'),
('Alfred','Kusi','Boateng','M',100,'01117843531','alf@gmail.com',01111204),
('Rebecca',null,'Ofori','F',34,'0207492013','rebmills@gmail.com',0111300),
('Abena','Nana','Debrah','F',23,'0209595423','abenan@gmail.com',0111301),
('Dylan','Kofi','Sylan','M',21,'0207492013','dylsyl@gmail.com',0111302),
('Michaek','Yaw','Opana','M',21,'0207492013','micopa@gmail.com',0111303),
('Efua','Mariam','Asante','F',23,'0542323234','efuaasa@gmail.com',0111304),
('Kellen','Maame','Bonsu','F',24,'0207492013','kellmill@gmail.com',0111305),
('Bishop','Sarpong','Mensah','M',21,'0207492013','bissar@gmail.com',0111306),
('Jesse','Kwabenya','Kuma','M',34,'0207492013','jeskuma@gmail.com',0111307),
('Abena',null,'Fianko','F',24,'05023123223','abefia@gmail.com',0111308),
('Beyonce','Esi','White','F',64,'02045643423','beyesi@gmail.com',0111309),
('Rihanna','Mabel','Boatend','F',56,'05445643423','rima@gmail.com',0111310);

insert into doctor values(01011,0111111);
insert into doctor values(01022,0111122);
insert into doctor values(01031,0111123);
insert into doctor values(01042,0111124);
insert into doctor values(01045,0111125);
insert into doctor values(01012,0111126);
insert into doctor values(01023,0111127);
insert into doctor values(01034,0111128);
insert into doctor values(01065,0111129);
insert into doctor values(01075,0111120);

insert into diagnosis values(12211,'tuberculosis');
insert into diagnosis values(19331,'malaria');
insert into diagnosis values(19219,'asthma');
insert into diagnosis values(12121,'stomache ache');
insert into diagnosis values(12111,'diarrhea');
insert into diagnosis values(11231,'chlamydia');
insert into diagnosis values(12311,'syphilis');
insert into diagnosis values(01112,'allergies');
insert into diagnosis values(14222,'avianinfluenza');
insert into diagnosis values(15433,'arthritis');

INSERT INTO patient VALUES (05001,0111300,12211,01011);
INSERT INTO patient VALUES (05002,0111301,19331,01022);
INSERT INTO patient VALUES (05003,0111302,19219,01031);
INSERT INTO patient VALUES (05004,0111303,12121,01042);
INSERT INTO patient VALUES (05005,0111304,12111,01045);
INSERT INTO patient VALUES (05006,0111305,11231,01012);
INSERT INTO patient VALUES (05007,0111306,12311,01023);
INSERT INTO patient VALUES (05008,0111307,01112,01034);
INSERT INTO patient VALUES (05009,0111308,14222,01065);
INSERT INTO patient VALUES (05010,0111310,15433,01075);

insert into nurse values(100121,0111300,01011);
insert into nurse values(100122,0111301,01022);
insert into nurse values(100123,0111302,01045);
insert into nurse values(100124,0111303,01023);
insert into nurse values(100125,0111304,01022);
insert into nurse values(100126,0111305,01042);
insert into nurse values(100127,0111306,01012);
insert into nurse values(100128,0111307,01034);
insert into nurse values(100129,0111308,01065);
insert into nurse values(100130,0111309,01075);

insert into surgeon values(01011,'Cardiologists');
insert into surgeon values(01022,'Colon Surgeon');
insert into surgeon values(01031,'Dermatologist');
insert into surgeon values(01042,'Endocrinologists');
insert into surgeon values(01045,'Endorinologists');
insert into surgeon values(01075,'Hematologists');
insert into surgeon values(01065,'Gastroenterologists');
insert into surgeon values(01023,'heatologists');
insert into surgeon values(01012,'hmatologists');
insert into surgeon values(01034,'Family Physicians');


INSERT INTO laboratory VALUES (5001, 05001, 01031, '2021-03-11 09-02-14', 500.00);
INSERT INTO laboratory VALUES (5002, 05002, 01042, '2017-01-01 08-02-11', 200.0);
INSERT INTO laboratory VALUES (5003, 05003, 01011, '2019-02-01 13-20-13', 150.00);
INSERT INTO laboratory VALUES (5004, 05004, 01022, '2020-02-01 14-15-12', 200.00);
INSERT INTO laboratory VALUES (5005, 05005, 01065, '2021-02-17 15-05-00', 1500.00);		       
INSERT INTO laboratory VALUES (5006, 05006, 01012, '2021-04-18 08-33-27', 2000.00);		       
INSERT INTO laboratory VALUES (5007, 05007, 01075, '2018-06-10 11-05-34', 150.00);     
INSERT INTO laboratory VALUES (5008, 05008, 01034, '2021-01-18 09-12-56', 400.00);
INSERT INTO laboratory VALUES (5009, 05009, 01045, '2020-05-14 10-05-15', 1000.00);			       
INSERT INTO laboratory VALUES (50010, 05010,01023, '2019-06-20 16-11-20', 400.00);



INSERT INTO medication VALUES (9001,'Amoxacylin');
INSERT INTO medication VALUES (9002,'panadol');
INSERT INTO medication VALUES (9003,'paracetamol');
INSERT INTO medication VALUES (9004,'Keratin');
INSERT INTO medication VALUES (9005,'flaxin');

insert into bill values(01001, 200, 150, 4, 100, 05001);
insert into bill values(01002, 100, 110, 3, 80, 05002);
insert into bill values(01003, 90, 50, 5, 120, 05003);
insert into bill values(01004, 60, 150, 1, 170, 05004);
insert into bill values(01005, 70, 140, 2, 111, 05005);
insert into bill values(01006, 220, 114, 6, 10, 05006);
insert into bill values(01007, 250, 10, 9, 133, 05007);
insert into bill values(01008, 210, 199, 10, 153, 05008);
insert into bill values(01009, 161, 159, 7, 171, 05009);
insert into bill values(010010, 187, 180, 8, 181, 05010);

insert into ward values(010000,'Children ward');
insert into ward values(020000,'Infectious disease ward');
insert into ward values(030000,'Adult ward');
insert into ward values(040000,'Accident ward');
insert into ward values(050000,'Emergency ward');
insert into ward values(060000,'VIP ward');
insert into ward values(070000,'Presidential ward');
insert into ward values(080000,'Maternity ward');
insert into ward values(090000,'ICU ward');
insert into ward values(090001,'surgery ward');




INSERT INTO room VALUES (1001,'2-bedroom',0,010000,100121);
INSERT INTO room VALUES (1002,'4-bedroom',1,020000,100122);
INSERT INTO room VALUES (1003,'2-bedroom',2,030000,100123);
INSERT INTO room VALUES (1004,'2-bedroom',1,040000,100124);
INSERT INTO room VALUES (1005,'4-bedroom',4,050000,100125);
INSERT INTO room VALUES (1006,'3-bedroom',1,060000,100126);
INSERT INTO room VALUES (1007,'1-bedroom',1,070000,100127);
INSERT INTO room VALUES (1008,'2-bedroom',1,080000,100128);
INSERT INTO room VALUES (1009,'3-bedroom',1,090000,100129);
INSERT INTO room VALUES (1010,'1-bedroom',1,090001,100130);



insert into inpatient values(05001,1001,'2003-04-13','2003-04-21',null,01011,5001);
insert into inpatient values(05002,1002,'2021-01-12','2021-01-21',null,01022,5002);
insert into inpatient values(05003,1003,'2020-04-13','2021-04-21','2021-04-21',01011,5003);
insert into inpatient values(05004,1004,'2021-01-11','2021-02-21',null,01031,5004);
insert into inpatient values(05005,1005,'2021-04-13','2021-04-21',null,01042,5005);
insert into inpatient values(05006,1006,'2021-04-13','2021-04-21',null,01065,5006);
insert into inpatient values(05007,1007,'2021-04-13','2021-04-21',null,01075,5007);
insert into inpatient values(05008,1008,'2021-04-13','2021-04-21',null,01034,5008);
insert into inpatient values(05009,1009,'2021-04-13','2021-04-21',null,01023,5009);
insert into inpatient values(05010,1010,'2021-04-13','2021-04-21',null,01012,50010);

insert into outpatient (patient_id, date_of_discharge, doctor_id)values(05001

,'2011-10-3',01011);
insert into outpatient (patient_id, date_of_discharge, doctor_id)values(05002
,'2023-12-2',01022);
insert into outpatient (patient_id, date_of_discharge, doctor_id)values(05003
,'2012-01-4',01031);
insert into outpatient (patient_id, date_of_discharge, doctor_id)values(05004
,'2011-11-2',01042);
insert into outpatient (patient_id, date_of_discharge, doctor_id)values(05005
,'2000-04-5',01045);
insert into outpatient (patient_id, date_of_discharge, doctor_id)values(05006
,'2019-05-8',01012);
insert into outpatient (patient_id, date_of_discharge, doctor_id)values(05007
,'2011-12-11',01023);
insert into outpatient (patient_id, date_of_discharge, doctor_id)values(05008
,'2002-04-4',01034);
insert into outpatient (patient_id, date_of_discharge, doctor_id)values(05009
,'2002-2-5',01065);
insert into outpatient (patient_id, date_of_discharge, doctor_id)values(05010
,'2021-9-9',01075);

insert into bloodbank values('neg',0111111);
insert into bloodbank values('0-pos',0111122);
insert into bloodbank values('0-neg',0111123);
insert into bloodbank values('0-pos',0111124);
insert into bloodbank values('0-neg',0111125);
insert into bloodbank values('0-neg',0111126);
insert into bloodbank values('AB',0111127);
insert into bloodbank values('AS',0111128);
insert into bloodbank values('SS',0111129);
insert into bloodbank values('O-neg',01111210);






