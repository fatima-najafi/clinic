--create databse 
CREATE DATABASE clinic
-- create the patients table
 CREATE TABLE patients(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE  NOT NULL

 );
 --CEATE THE MEDICAL HISTORIES
 CREATE TABLE medical_histories(
    id SERIAL PRIMARY KEY,
    admitted_id TIMESTAMP,
    patient_id INT NOT NULL,
    status VARCHAR (100)
 );
  -- create forign KEY for medical _history
  ALTER TABLE medical_histories
  ADD CONSTRAINT fk_patient_id
  FOREIGN KEY (patient_id)
  REFERENCES patients (id);

 --CREATE THE invoices
    CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
     total_amount DECIMAL,
     generated_at TIMESTAMP,
    payed_id TIMESTAMP,
    medical_history_id INT
    );
  -- create forign KEY for invoices
    ALTER TABLE invoices
    ADD CONSTRAINT fk_invoice_id
    FOREIGN KEY (medical_history_id)
    REFERENCES medical_histories (id);

    ---create table INVOICE_ITEMS
    CREATE TABLE invoice_items(
      id SERIAL PRIMARY KEY,
        unit_price DECIMAL,
        quantity INT,
        total_price DECIMAL,
        invoice_id INT,
        treatment_id INT
    );
 -- create invoice_items
    ALTER TABLE invoice_items
    ADD CONSTRAINT fk_invoice_items_invoice_id
    FOREIGN KEY ( invoice_id)
    REFERENCES invoices (id),
    ADD CONSTRAINT fk_invoice_items_treatment_id
    FOREIGN KEY ( treatment_id)
    REFERENCES treadments (id);

--CREATE TABLE TREADMENTS
    CREATE TABLE treadments(
        id SERIAL PRIMARY KEY,
        type VARCHAR (150) NOT NULL,
        name VARCHAR (100) NOT NULL
    );

  -- crete table medical_history_treatments to retalte to mdical and treatment
CREATE TABLE medical_history_treatments(
    medical_history_id INT,
    treatment_id INT,
    PRIMARY KEY (medical_history_id, treatment_id),
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
     FOREIGN KEY (treatment_id) REFERENCES treadments (id)

);


-- Create the join tables for many-to-many relationships

-- CREATE TABLE doctors_patients (many-to-many relationship between doctors and patients)
CREATE TABLE doctors_patients (
    doctor_id INT,
    patient_id INT,
    PRIMARY KEY (doctor_id, patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- CREATE TABLE treatments_patients (many-to-many relationship between treatments and patients)
CREATE TABLE treatments_patients (
    treatment_id INT,
    patient_id INT,
    PRIMARY KEY (treatment_id, patient_id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- CREATE TABLE appointments_patients (many-to-many relationship between appointments and patients)
CREATE TABLE appointments_patients (
    appointment_id INT,
    patient_id INT,
    PRIMARY KEY (appointment_id, patient_id),
    FOREIGN KEY (appointment_id) REFERENCES appointments(id),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- CREATE TABLE appointments_doctors (many-to-many relationship between appointments and doctors)
CREATE TABLE appointments_doctors (
    appointment_id INT,
    doctor_id INT,
    PRIMARY KEY (appointment_id, doctor_id),
    FOREIGN KEY (appointment_id) REFERENCES appointments(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

