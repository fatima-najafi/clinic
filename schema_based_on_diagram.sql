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
    CREATE TABLE treatments(
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
     FOREIGN KEY (treatment_id) REFERENCES treatments (id)

);

-- create INDEX
CREATE INDEX idx_medical_history_treatments_medical_history_id ON medical_history_treatments(medical_history_id);
CREATE INDEX idx_medical_history_treatments_treatment_id ON medical_history_treatments (treatment_id);
CREATE INDEX idx_invoice_items_invoice_id ON invoice_items (invoice_id);
CREATE INDEX idx_invoice_items_treatment_id ON invoice_items (treatment_id);
CREATE INDEX idx_invoices_medical_history_id ON invoices (medical_history_id);
CREATE INDEX idx_medical_histories_patient_id ON medical_histories (patient_id);
