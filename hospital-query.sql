USE hospital;
-- view 1
-- view to retrieve patients and respective physician associated with them.CREATE VIEW v_patient_physician AS
SELECT p.patient_name,
       ph.physician_name,
       hr.status
FROM   patient p
JOIN   physician_order_instructions poi
ON     p.patient_id = poi.patient_id
JOIN   physician ph
ON     ph.physician_id = poi.physician_id
JOIN   health_record hr
ON     hr.patient_id = p.patient_id ;

-- view 2
-- view retrieve patient and their daily medication information.CREATE VIEW v_patient_medication AS
SELECT p.patient_name,
       m.medicine_name
FROM   patient p
JOIN   medication m
ON     p.patient_id = m.patient_id;

-- view 3
-- view to retrieve hospitalization record with respective room number and duration of stay of each patient.CREATE VIEW v_patient_hospitalized AS
SELECT p.patient_name,
       h.no_of_nights,
       h.room_id
FROM   patient p
JOIN   hospitalized h
ON     p.patient_id = h.patient_id;

-- trigger 1
-- trigger to update invoice table whenever a  patient record is updated in hospitalized table as per number of rooms.
CREATE TRIGGER tgr_invoice_hospitalized_update after
UPDATE
ON hospitalized FOR each row
UPDATE invoice
SET    room_charge =
       (
              SELECT fee_per_night
              FROM   room
              WHERE  room_id = new.room_id) * new.no_of_nights
WHERE  patient_id = new.patient_id;

-- trigger 2
-- trigger to insert a row in invoice table whenever a new patient record is added in hospitalized table as per number of rooms.
CREATE TRIGGER tgr_after_hospitalized_insert after
INSERT
ON hospitalized FOR each row
UPDATE invoice
SET    room_charge =
       (
              SELECT fee_per_night
              FROM   room
              WHERE  room_id = new.room_id) * new.no_of_nights
WHERE  patient_id = new.patient_id;

-- trigger 3
-- trigger to auto populate invoice table whenever a new record is inserted into patient table.
CREATE TRIGGER tgr_after_patient_insert after
INSERT
ON patient FOR each row
INSERT INTO invoice
            (
                        patient_id,
                        date
            )
            VALUES
            (
                        new.patient_id,
                        sysdate()
            );

-- query 1:
-- list all the physicians along with the count of patients they are monitoring
select   ph.physician_id,
         ph.physician_name ,
         count(*) AS total_patients_monitoring
FROM     physician ph
JOIN     physician_monitors pm
ON       pm.physician_id = ph.physician_id
GROUP BY ph.physician_id;

-- query 2:
-- total count of instructions assigned to each nurse
select   n.nurse_id,
         n.nurse_name,
         count(*) AS total_instructions
FROM     nurse n
JOIN     nurse_execution ne
ON       n.nurse_id = ne.nurse_id
GROUP BY ne.nurse_id;

-- query 3:
-- display the number of medicines they gave to the patients
select   n.nurse_id,
         m.medicine_name,
         count(*)
FROM     nurse n
JOIN     medication m
ON       n.nurse_id = m.nurse_id
GROUP BY n.nurse_id,
         m.medicine_name;

-- query 4:
-- display patient name and maximum no of nights hospitalized
select p.patient_name,
       max(h.no_of_nights) total_nights
FROM   hospitalized h
JOIN   patient p
ON     p.patient_id = h.patient_id;

-- query 5:
-- maximum no of instructions given to a patient
select patient_id,
       max(instructions_count) AS max_given_instructions
FROM   (
                SELECT   patient_id,
                         count(*) instructions_count
                FROM     physician_order_instructions
                GROUP BY patient_id ) b;

-- query 6
-- display  all the instructions assigned to nurses which are in progress
select ne.nurse_id,
       n.nurse_name,
       ne.instruction_id,
       ne.status
FROM   nurse_execution              AS ne
JOIN   nurse                        AS n
JOIN   physician_order_instructions AS poi
WHERE  ne.nurse_id=n.nurse_id
AND    poi.instruction_id=ne.instruction_id
AND    status = 'progress';

-- query 7
-- list all the count of instructions executed by a nurse
select   q.nurse_id,
         q.nurse_name,
         count(q.execution_id) AS total_instructioncount
FROM     (
                SELECT ne.nurse_id,
                       n.nurse_name,
                       ne.execution_id
                FROM   nurse_execution              AS ne
                JOIN   physician_order_instructions AS poi
                JOIN   nurse                        AS n
                WHERE  n.nurse_id=ne.nurse_id
                AND    poi.instruction_id = ne.instruction_id)q
GROUP BY q.nurse_id;

-- query 8
-- display all the payments of room_charge, instruction_charge and total combined amount for each patient
select   q.patient_id,
         sum(q.room_charge)                      AS roomcharge,
         sum(q.instruction_charge)               AS instruction_charge,
         sum(q.room_charge+q.instruction_charge) AS total_amount
FROM     (
                SELECT pay.patient_id,
                       iv.room_charge,
                       iv.instruction_charge
                FROM   payment AS pay
                JOIN   patient AS p
                JOIN   invoice AS iv
                WHERE  p.patient_id=pay.patient_id
                AND    iv.invoice_id=pay.invoice_id)q
GROUP BY q.patient_id;

-- query 9
-- find the room with highest amount per night
select room_id,
       fee_per_night
FROM   room
WHERE  fee_per_night=
       (
              SELECT max(fee_per_night)
              FROM   room);

-- query 10
-- list all the nurses who is not assigned any instruction at all
select nurse_id,
       nurse_name
FROM   nurse
WHERE  nurse_id NOT IN
       (
              SELECT nurse_id
              FROM   nurse_execution);

-- query 11
-- list all the nurses who's currently execution status is in progress
select nurse_id,
       nurse_name
FROM   nurse
WHERE  nurse_id IN
       (
              SELECT nurse_id
              FROM   nurse_execution
              WHERE  status='progress');

-- query 12
-- display the names of nurses who is giving medications to each patient
select p.patient_name,
       n.nurse_name,
       m.medicine_name,
       m.quantity
FROM   medication AS m
JOIN   patient    AS p
ON     p.patient_id=m.patient_id
JOIN   nurse AS n
ON     n.nurse_id=m.nurse_id;

-- query 13
-- list the physician name who monitors the patient maximum amount of time
select p.physician_name,
       pa.patient_name,
       max(ph.duration)   AS 'duration(hrs)'
FROM   physician_monitors AS ph
JOIN   patient            AS pa
ON     ph.patient_id=pa.patient_id
JOIN   physician AS p
ON     p.physician_id=ph.physician_id;

-- query 14
-- list all the physicians who is not monitoring any patients
select physician_id,
       physician_name
FROM   physician
WHERE  physician_id NOT IN
       (
              SELECT physician_id
              FROM   physician_monitors);

-- query 15
-- list number of physicians per field of expertise
select   field_of_expertise,
         count(*)
FROM     physician
GROUP BY field_of_expertise