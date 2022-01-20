DROP DATABASE

IF EXISTS hospital;
	CREATE DATABASE hospital;
    use hospital;

/*REMOVED in final design
create table staff
(
id int,
name varchar(20),
certification_number varchar(20),
address varchar(50),
phone_number int,
primary key(id)
);
*/
CREATE TABLE patient (
	patient_id INT not null auto_increment
	,patient_name VARCHAR(20)
	,address VARCHAR(50)
	,phone_number varchar(10)
	,PRIMARY KEY (patient_id)
	);

CREATE TABLE health_record (
	healthrecord_id INT NOT NULL auto_increment
	,patient_id INT
    ,STATUS VARCHAR(10)
	,DATE DATETIME
	,description VARCHAR(50)
	,disease VARCHAR(20)
    ,primary key(healthrecord_id,patient_id)
	,FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
	);

CREATE TABLE physician (
	physician_id INT NOT NULL auto_increment
	,physician_name VARCHAR(20)
	,certification_number VARCHAR(20)
	,address VARCHAR(50)
	,phone_number varchar(10)
	,field_of_expertise VARCHAR(30)
	,PRIMARY KEY (physician_id)
	);

CREATE TABLE nurse (
	nurse_id INT NOT NULL auto_increment
	,nurse_name VARCHAR(20)
	,certification_number VARCHAR(20)
	,address VARCHAR(50)
	,phone_number varchar(10)
	,PRIMARY KEY (nurse_id)
	);

CREATE TABLE instruction (
	instruction_code VARCHAR(10) NOT NULL
	,instruction_fee NUMERIC
	,description VARCHAR(50)
	,PRIMARY KEY (instruction_code)
	);
    
Create table Physician_order_instructions(
instruction_id INT NOT NULL auto_increment ,
physician_id int, 
instruction_code varchar(10),
patient_id int, 
given_date datetime,
primary key (instruction_id),
Foreign key (physician_id) references Physician(physician_id), 
Foreign key (instruction_code) references instruction(instruction_code), 
Foreign key (patient_id) references patient(Patient_ID)
);

CREATE TABLE room (
	room_id INT auto_increment
	,capacity INT
	,fee_per_night NUMERIC
	,PRIMARY KEY (room_id)
	);

CREATE TABLE hospitalized (
	hospitalized_id INT NOT NULL auto_increment
	,patient_id INT 
	,no_of_nights INT
	,room_id INT
    ,primary key(hospitalized_id)
	,FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
    ,foreign key (room_id) references room(room_id)
	);

CREATE TABLE invoice (
	invoice_id INT not null auto_increment
    ,hospitalized_id int
	,patient_id INT
	,room_charge NUMERIC
	,instruction_charge NUMERIC
	,PRIMARY KEY (invoice_id)
    ,Foreign key(hospitalized_id) references hospitalized(hospitalized_id)
	,FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
	);

CREATE TABLE payment (
	payment_id INT NOT NULL auto_increment
	,patient_id int
	,invoice_id INT
	,amount NUMERIC
	,DATE DATETIME
	,PRIMARY KEY (payment_id)
	,FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id)	
	,FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
	);




CREATE TABLE medication (
	medication_id INT not null auto_increment
	,patient_id INT
	,nurse_id INT
	,medicine_name VARCHAR(20)
	,quantity INT
	,PRIMARY KEY (medication_id)
	,FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
	,FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id)
	);



CREATE TABLE Physician_Monitors(
	monitor_id INT NOT NULL auto_increment, 
	physician_id INT
	,patient_id INT
	,duration NUMERIC
    ,primary key(monitor_id) 
    ,FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
	,FOREIGN KEY (physician_id) REFERENCES physician(physician_id)
	);

CREATE TABLE nurse_execution (
	execution_id INT not null auto_increment,
    instruction_id int,
    nurse_id int
	,DATE DATETIME
	,STATUS VARCHAR(10)
	,PRIMARY KEY (execution_id)
	,Foreign  key(nurse_id) references nurse(nurse_id)
    ,foreign key(instruction_Id)references Physician_order_instructions(instruction_id)
	);