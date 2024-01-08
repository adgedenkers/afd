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
  ndc TEXT,
  prescription BOOLEAN DEFAULT 1,
  prescribed_to_id INTEGER,
  generic_name TEXT,
  brand_name TEXT,
  dosage_per_unit FLOAT,
  dosage_units TEXT,
  dosage_format TEXT,
  FOREIGN KEY(prescribed_to_id) REFERENCES people(id)
);

CREATE TABLE IF NOT EXISTS medication_formats(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  format_name TEXT
);

INSERT INTO medication_formats (format_name) VALUES
('tablet'),
('capsule'),
('liquid'),
('injection'),
('syrup'),
('suspension'),
('solution'),
('gel'),
('lotion'),
('cream'),
('ointment'),
('suppository'),
('inhaler'),
('spray'),
('other'),
('patch'),
('powder')
;

CREATE TABLE IF NOT EXISTS medication_dosage_units(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  unit_name TEXT
);

INSERT INTO medication_dosage_units (unit_name) VALUES
('mg'),
('mcg'),
('g'),
('ml'),
('oz'),
('tsp'),
('tbsp'),
('other')

CREATE TABLE IF NOT EXISTS medication_ingredients(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ingredient_name TEXT
);

INSERT INTO medication_ingredients (ingredient_name) VALUES
('acetaminophen'),
('ibuprofen'),
('naproxen'),
('aspirin'),
('diphenhydramine'),
('pseudoephedrine'),
('phenylephrine'),
('dextromethorphan'),
('guaifenesin'),
('chlorpheniramine'),
('loratadine'),
('cetirizine'),
('fexofenadine'),
('ranitidine'),
('omeprazole'),
('lansoprazole'),
('famotidine'),
('cimetidine'),
('calcium carbonate'),
('magnesium hydroxide'),
('simethicone'),
('bismuth subsalicylate'),
('lactobacillus acidophilus'),
('loperamide'),
('docusate sodium'),
('senna'),
('bisacodyl'),
('polyethylene glycol'),
('glycerin'),
('mineral oil'),
('psyllium'),
('methylcellulose'),
('dextrose'),
('glucose'),
('fructose'),
('sucrose'),
('lactose'),
('sorbitol'),
('mannitol'),
('xylitol'),
('sucralose'),
('aspartame'),
('saccharin'),
('acesulfame potassium'),
('stevia'),
('monosodium glutamate');

CREATE TABLE IF NOT EXISTS medication_person_mapping (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  medication_id INTEGER,
  FOREIGN KEY(person_id) REFERENCES people(id),
  FOREIGN KEY(medication_id) REFERENCES medications(id)
);

CREATE TABLE IF NOT EXISTS current_tasks(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  task_name TEXT,
  task_description TEXT,
  due DATETIME,
  task_type_id INTEGER,
  status_id INTEGER,
  completed INTEGER DEFAULT 0,
  action_on_complete TEXT,
  pre_task_id INTEGER DEFAULT 0,
  pre_task_order INTEGER DEFAULT 0,
  post_task_id INTEGER DEFAULT 0,
  post_task_order INTEGER DEFAULT 0,
  FOREIGN KEY(person_id) REFERENCES people(id),
  FOREIGN KEY(task_type_id) REFERENCES task_types(id),
  FOREIGN KEY(status_id) REFERENCES task_status(id)
  FOREIGN KEY(pre_task_id) REFERENCES current_tasks(id),
  FOREIGN KEY(post_task_id) REFERENCES current_tasks(id)
);

CREATE TABLE IF NOT EXISTS tasks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  task_name TEXT,
  task_description TEXT,
  assigned_to_id INTEGER,
  due DATETIME,
  frequency TEXT,
  task_type_id INTEGER,
  recurring INTEGER DEFAULT 0,
  schedule TEXT,
  set_ios_reminder INTEGER DEFAULT 0,
  action_on_complete TEXT,
  FOREIGN KEY(assigned_to_id) REFERENCES people(id),
  FOREIGN KEY(task_type_id) REFERENCES task_types(id)
);

CREATE TABLE IF NOT EXISTS task_views (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  task_id INTEGER,
  person_id INTEGER,
  primary INTEGER DEFAULT 0,
  FOREIGN KEY(task_id) REFERENCES current_tasks(id),
  FOREIGN KEY(person_id) REFERENCES people(id)
);


-- Task Name: Take Morning Medications
-- Task Description: Adge's reminder to take his morning medications
-- Assign to: Adge
-- Due: 01/09/2024 6:00 am
-- Frequency: Daily
-- Task Type: Medication Reminder
-- Status: Open
-- Completed: No
-- Closed: NULL
-- Closing Notes: NULL
-- Recurring: Yes


CREATE TABLE IF NOT EXISTS task_types (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  task_type_name TEXT
);

INSERT INTO task_types (task_type_name) VALUES
('reminder'),
('task'),
('chore'),
('appointment'),
('other');

-- Reminder - just uses the Task Name and Description along with due date/time

-- All tasks of any task_type have the following common fields:
-- 1. task_name
-- 2. task_description
-- 3. due
-- 4. task_type_id
-- 5. status_id
-- 6. completed

-- Chores have a specific point value to them - which will be addressed in future releases


-- Appointments have one additional field:
-- 1. appointment_datetime
-- 2. appointment_duration
-- 3. appointment_location
-- 4. outcome_comments
-- 5. mapping table: appointments_tasks_mapping
-- tasks can be pre or post appointment
-- tasks s

CREATE TABLE IF NOT EXISTS task_status (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  status_name TEXT,
  status_description TEXT,
  status_color TEXT,
  status_icon TEXT,
  status_active INTEGER DEFAULT 1,
  status_order INTEGER DEFAULT 0
);

INSERT INTO task_status (
  status_name, status_description, status_color, status_icon, status_active, status_order
) VALUES
('open', 'Task is open and active', '#ff0000', 'fa fa-exclamation-circle', 1, 0),
('in progress', 'Task is in progress', '#ff9900', 'fa fa-spinner', 1, 1),
('on hold', 'Task is on hold', '#ffff00', 'fa fa-pause-circle', 1, 2),
('completed', 'Task is completed', '#00ff00', 'fa fa-check-circle', 1, 3),
('closed', 'Task is closed', '#000000', 'fa fa-times-circle', 1, 4),
('canceled', 'Task is canceled', '#000000', 'fa fa-times-circle', 1, 5),
('deleted', 'Task is deleted', '#000000', 'fa fa-times-circle', 1, 6);



-- ================================================================


-- -- appointments Table
-- CREATE TABLE IF NOT EXISTS appointments (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   person_id INTEGER,
--   appointment_name TEXT,
--   appointment_date DATETIME,
--   description TEXT,
--   FOREIGN KEY(person_id) REFERENCES people(id)
-- );

-- -- reminders Table
-- CREATE TABLE IF NOT EXISTS reminders (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   person_id INTEGER,
--   reminder_name TEXT,
--   reminder_date DATETIME,
--   description TEXT,
--   FOREIGN KEY(person_id) REFERENCES people(id)
-- );

-- -- tasks Table
-- CREATE TABLE IF NOT EXISTS tasks (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   person_id INTEGER,
--   task_name TEXT,
--   due_date DATETIME,
--   status TEXT,
--   FOREIGN KEY(person_id) REFERENCES people(id)
-- );

-- -- chores Table
-- CREATE TABLE IF NOT EXISTS chores (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   person_id INTEGER,
--   chore_name TEXT,
--   due_date DATETIME,
--   status TEXT,
--   FOREIGN KEY(person_id) REFERENCES people(id)
-- );

-- -- log_table Table
-- CREATE TABLE IF NOT EXISTS log_table (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   event_type VARCHAR(50) NOT NULL,
--   event_subtype VARCHAR(50),
--   event_description TEXT,
--   event_data JSON,
--   person_id INTEGER,
--   user_name VARCHAR(50),
--   ip_address VARCHAR(50),
--   user_agent VARCHAR(255),
--   event_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
--   event_start_timestamp DATETIME,
--   event_end_timestamp DATETIME,
--   FOREIGN KEY(person_id) REFERENCES people(id)
-- );
