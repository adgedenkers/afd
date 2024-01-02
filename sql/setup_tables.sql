/*
 * Filename: /Users/adge/_code/dev/dragonfruit/family_tracker__setup_tables.sql
 * Path: /Users/adge/_code/dev/dragonfruit
 * Created Date: Friday, December 22nd 2023, 9:38:25 am
 * Author: Adge Denkers
 * 
 * Copyright (c) 2024 denkers.co
 */

-- Enable Foreign Key Support
PRAGMA foreign_keys = ON;

-- people Table
CREATE TABLE IF NOT EXISTS people (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_name TEXT NOT NULL UNIQUE,
  name_prefix TEXT,
  first_name TEXT NOT NULL,
  middle_name TEXT,
  last_name TEXT NOT NULL,
  name_suffix TEXT,
  dob TEXT,
  user_password TEXT,
  email TEXT NOT NULL,
  phone TEXT,
  address TEXT,
  city TEXT,
  state TEXT,
  zip TEXT,
  country TEXT,
  created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')) NOT NULL
);

-- Insert Statements for people
INSERT INTO people (user_name, name_prefix, first_name, middle_name, last_name, dob, email, phone, address, city, state, zip, country)
VALUES
  ('Adge', 'Mr.', 'Adriaan', 'Harold', 'Denkers', '1977-11-22T08:45:22-0500', 'adge.denkers@gmail.com', '607-226-0710', '304 Cosen Road', 'Oxford', 'NY', '13830', 'United States'),
  ('Becky', 'Mrs.', 'Rebecca', 'Lydia', 'Denkers', '1978-08-19T14:02:33-0400', 'rebecca.denkers@gmail.com', '607-316-2604', '304 Cosen Road', 'Oxford', 'NY', '13830', 'United States'),
  ('Fitz', 'Mr.', 'Adriaan', 'Fitzgerald', 'Denkers', '2010-09-08T14:39:11-0400', 'bonniegamer0812@gmail.com', '607-226-3077', '304 Cosen Road', 'Oxford', 'NY', '13830', 'United States');

-- access_logs Table
CREATE TABLE IF NOT EXISTS access_logs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  login_time DATETIME,
  logout_time DATETIME,
  FOREIGN KEY(person_id) REFERENCES people(id)
);

-- medical_info Table
CREATE TABLE IF NOT EXISTS medical_info (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  blood_type TEXT,
  FOREIGN KEY(person_id) REFERENCES people(id)
);

CREATE TABLE IF NOT EXISTS conditions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  description TEXT,
  symptoms TEXT,
  treatment TEXT,
  severity INT
);

CREATE TABLE condition_person_mapping (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  condition_id INTEGER,
  FOREIGN KEY(person_id) REFERENCES people(id),
  FOREIGN KEY(condition_id) REFERENCES conditions(id)

CREATE TABLE IF NOT EXISTS allergies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  description TEXT,
  symptoms TEXT,
  treatment TEXT,
  severity TEXT,
);

CREATE TABLE IF NOT EXISTS allergy_person_mapping (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  allergy_id INTEGER,
  FOREIGN KEY(person_id) REFERENCES people(id),
  FOREIGN KEY(allergy_id) REFERENCES allergies(id)
);

-- med_groups Table
CREATE TABLE IF NOT EXISTS med_groups (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  group_name TEXT,
  active INTEGER DEFAULT 1,
  FOREIGN KEY(person_id) REFERENCES people(id)
);

INSERT INTO med_groups (person_id, group_name) VALUES
(1, 'morning medications'),
(1, 'afternoon medications'),
(2, 'am medications'),
(2, 'noon medications'),
(2, 'pm medications');

-- medication_med_group_mapping Table
CREATE TABLE IF NOT EXISTS medication_med_group_mapping (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  group_id INTEGER,
  medication_id INTEGER,
  FOREIGN KEY(group_id) REFERENCES med_groups(id),
  FOREIGN KEY(medication_id) REFERENCES medications(id)
);

INSERT INTO medication_med_group_mapping (group_id, medication_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 2),
(2, 3),
(2, 9),
(3, 10),
(3, 11),
(3, 12),
(4, 13),
(4, 14),
(4, 15)

-- medications Table
CREATE TABLE IF NOT EXISTS medications (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  prescription BOOLEAN DEFAULT 1,
  prescribed_to_id INTEGER,
  generic_name TEXT,
  dosage FLOAT,
  dosage_units TEXT,
  FOREIGN KEY(prescribed_to_id) REFERENCES people(id)
);

INSERT INTO medications (prescription, medication_name, dosage) VALUES
(1, 'Lisinopril', '10mg'),
(1, 'Metformin', '500mg'),
(1, 'Atorvastatin', '20mg'),
(1, 'Amlodipine', '5mg'),
(1, 'Metoprolol', '25mg'),
(1, 'Omeprazole', '20mg'),
(1, 'Aspirin', '81mg'),
(1, 'Simvastatin', '20mg'),
(1, 'Losartan', '50mg'),
(1, 'Albuterol', '90mcg'),
(1, 'Hydrochlorothiazide', '25mg'),
(1, 'Levothyroxine', '50mcg'),
(1, 'Gabapentin', '300mg'),
(1, 'Furosemide', '20mg'),
(1, 'Fluticasone', '50mcg');

CREATE TABLE IF NOT EXISTS medication_person_mapping (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  medication_id INTEGER,
  FOREIGN KEY(person_id) REFERENCES people(id),
  FOREIGN KEY(medication_id) REFERENCES medications(id)
);



-- appointments Table
CREATE TABLE IF NOT EXISTS appointments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  appointment_name TEXT,
  appointment_date DATETIME,
  description TEXT,
  FOREIGN KEY(person_id) REFERENCES people(id)
);

-- reminders Table
CREATE TABLE IF NOT EXISTS reminders (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  reminder_name TEXT,
  reminder_date DATETIME,
  description TEXT,
  FOREIGN KEY(person_id) REFERENCES people(id)
);

-- tasks Table
CREATE TABLE IF NOT EXISTS tasks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  task_name TEXT,
  due_date DATETIME,
  status TEXT,
  FOREIGN KEY(person_id) REFERENCES people(id)
);

-- chores Table
CREATE TABLE IF NOT EXISTS chores (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  chore_name TEXT,
  due_date DATETIME,
  status TEXT,
  FOREIGN KEY(person_id) REFERENCES people(id)
);

-- log_table Table
CREATE TABLE IF NOT EXISTS log_table (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  event_type VARCHAR(50) NOT NULL,
  event_subtype VARCHAR(50),
  event_description TEXT,
  event_data JSON,
  person_id INTEGER,
  user_name VARCHAR(50),
  ip_address VARCHAR(50),
  user_agent VARCHAR(255),
  event_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  event_start_timestamp DATETIME,
  event_end_timestamp DATETIME,
  FOREIGN KEY(person_id) REFERENCES people(id)
);
