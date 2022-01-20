USE hospital;
insert into 
	patient
	(	
	patient_name 
	,address 
	,phone_number 
	)
	values
	(
	'Goutham Nanda',
	'101 University Terrace',
	'8723901234'
		)
	,	(
	'Krishna Manohar',
	'102 University Terrace',
	'9281091234'
		)
	,
	(
	'Nanda Gopal',
	'103 University Terrace',
	'8901813521'
		)
	,
	(
	'Ajay Kumar',
	'104 University Terrace',
	'9848032919'
		)
	,
	(
	'Arun Kumar',
	'105 University Terrace',
	'9848022338'
		);

	INSERT INTO `hospital`.`health_record`
(`patient_id`,
`STATUS`,
`DATE`,
`description`,
`disease`)
VALUES
(1
,'CRITICAL',
sysdate(),
'HIGH FEVER',
'Jaundice'),
(2
,'STABLE',
sysdate(),
'NAUSEA',
'Malaria'),
(3
,'STABLE',
sysdate(),
'OVERDOSE',
'OVERDOSE'),
(4
,'CRITICAL',
sysdate(),
'VOMITING',
'Food poisoning'),
(5
,'CRITICAL',
sysdate(),
'Head ache',
'NA');


INSERT INTO `hospital`.`physician`
(
`physician_name`,
`certification_number`,
`address`,
`phone_number`,
`field_of_expertise`)
VALUES
('Shankar Dada',
'A123',
'901 Tryon Street',
'9876543210',
"Cardiolgist"),

('Munna Bhai',
'MB142',
'9028 Tryon Street',
'9104783726',
'General Physician'),

('Arun Kumar',
'AK09',
'9999 Tryon Street',
'8123098456',
'Orthopaedic'),

('Spoorthi',
'A113',
'961 Tryon Street',
'9174826376',
'Dentist'),

('Adithya Kolla',
'A235',
'906 Tryon Street',
'9728491846',
'Urologist');


INSERT INTO `hospital`.`nurse`
(
`nurse_name`,
`certification_number`,
`address`,
`phone_number`)
VALUES
('Jennie',
'C102',
'123 Hospital Street',
'0912783456'),
('Mary',
'C129',
'112 Hospital Street',
'8192850298'),
('Bunny',
'C102',
'1013 Hospital Street',
'9104728378'),
('Minnie',
'C185',
'81728 Hospital Street',
'9102892178'),
('Naomi Watts',
'C091',
'0912 Hospital Street',
'9810473628');



INSERT INTO `hospital`.`instruction`
(`instruction_code`,
`instruction_fee`,
`description`)
VALUES
('N1234',
10,
'Paracetamol'),
('N1291',
20,
'Orasep'),
('N123865',
10,
'Dolo 650'),
('N12310',
40,
'Calpol'),
('N123218',
10,
'Aspirine');


INSERT INTO `hospital`.`physician_order_instructions`
(
`physician_id`,
`instruction_code`,
`patient_id`,
`given_date`)
VALUES
(
1,
'N1234',
1,
sysdate()+1),
(
2,
'N1291',
2,
sysdate()+1),(
3,
'N123865',
3,
sysdate()+1),(
4,
'N12310',
4,
sysdate()+1),(
5,
'N123218',
5,
sysdate()+1);



INSERT INTO `hospital`.`room`
(
`capacity`,
`fee_per_night`)
VALUES
(1,
100),
(2,
200),
(3,
300),
(4,
400),
(5,
500);

INSERT INTO `hospital`.`hospitalized`
(`patient_id`,
`no_of_nights`,
`room_id`)
VALUES
(1,
2,
1),
(2,
2,
2),
(3,
2,
3),
(4,
2,
4),
(5,
2,
5);


INSERT INTO `hospital`.`invoice`
(
`hospitalized_id`,
`patient_id`,
`room_charge`,
`instruction_charge`)
VALUES
(1,
1,
200,
500),
(2,
2,
200,
500),
(3,
3,
200,
500),
(4,
4,
200,
500),
(5,
5,
200,
500);



INSERT INTO `hospital`.`payment`
(
`patient_id`,
`invoice_id`,
`amount`,
`DATE`)
VALUES
(1,
1,
500,
sysdate()+5),

(2,
2,
500,
sysdate()+5),(3,
3,
500,
sysdate()+5),(4,
4,
500,
sysdate()+5),(5,
5,
500,
sysdate()+5);


INSERT INTO `hospital`.`medication`
(
`patient_id`,
`nurse_id`,
`medicine_name`,
`quantity`)
VALUES
(1,
1,
'Paracetamol',
2),
(2,
2,
'Calpol',
2),
(3,
3,
'Orasep',
2),
(4,
4,
'Dolo 650',
2),
(5,
5,
'Aspirine',
2);


INSERT INTO `hospital`.`physician_monitors`
(`physician_id`,
`patient_id`,
`duration`)
VALUES
(1,
1,
2),

(2,
2,
2),
(3,
3,
2),
(4,
4,
2),
(5,
5,
2);

INSERT INTO `hospital`.`nurse_execution`
(`instruction_id`,
`nurse_id`,
`DATE`,
`STATUS`)
VALUES
(1,
1,
sysdate(),
'Complete'),

(2,
2,
sysdate(),
'Complete'),
(3,
3,
sysdate(),
'Complete'),
(4,
4,
sysdate(),
'Complete'),
(5,
5,
sysdate(),
'Complete');

insert into instruction values('501',1456,'Eldoper');
insert into physician_order_instructions values(6,1,'501',1,'2021-12-05');
insert into nurse_execution values(6,6,1,'2021-12-05','Progress');
insert into hospitalized values(6,1,3,2);
insert into invoice values(202,6,1,500,1000);
insert into payment values(102,1,202,1500,'2021-12-06');
insert into nurse values(6,'Natalie','C111','112 Hospital Street','9674562210');
insert into physician_monitors values(6,1,1,5);
insert into physician_monitors values(7,2,2,3);
insert into physician values(6,'Satwik','A145','809 Mc colough','9866345210','Dentist');