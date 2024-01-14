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
  email TEXT NOT NULL,
  phone TEXT,
  address_id INTEGER,
  born_in_county TEXT,
  born_in_state TEXT,
  born_in_country TEXT,
  created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')) NOT NULL
);

-- Insert data into people table
INSERT INTO people (user_name, name_prefix, first_name, middle_name, last_name, dob, email, phone, born_in_county, born_in_state, born_in_country, created_at) VALUES
  ('Adge', 'Mr.', 'Adriaan', 'Harold', 'Denkers', '1977-11-22T08:45:22-0500', 'adge.denkers@gmail.com', '607-226-0710', 'Albany', 'New York', 'United States', strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
  ('Becky', 'Mrs.', 'Rebecca', 'Lydia', 'Denkers', '1978-08-19T14:02:33-0400', 'rebecca.denkers@gmail.com', '607-316-2604', 'Chenango', 'New York', 'United States', strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
  ('Fitz', 'Mr.', 'Adriaan', 'Fitzgerald', 'Denkers', '2010-09-08T14:39:11-0400', 'bonniegamer0812@gmail.com', '607-226-3077', 'Schenectady', 'New York', 'United States', strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime'));

-- medications Table
CREATE TABLE IF NOT EXISTS medications (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ndc TEXT,
  prescription INTEGER DEFAULT 1,
  prescribed_to_id INTEGER,
  generic_name TEXT,
  brand_name TEXT,
  dosage_per_unit FLOAT,
  dosage_units_id INTEGER,
  release TEXT,
  format_id INTEGER,
  FOREIGN KEY(prescribed_to_id) REFERENCES people(id),
  FOREIGN KEY(format_id) REFERENCES medication_formats(id),
  FOREIGN KEY(dosage_units_id) REFERENCES medication_dosage_units(id)
);

INSERT INTO medications (ndc, prescription, prescribed_to_id, generic_name, brand_name, dosage_per_unit, dosage_units_id, format_id) VALUES
('',1,1,'omeprazole','Prilosec',40,1,'',2),
('',1,1,'bupropion','Wellbutrin',300,1,'ER',1),
('',1,1,'lisdexamfetamine','Vyvanse',60,1,'',2),
('',1,1,'venlafaxine','Effexor',150,1,'XR',2),
('',1,1,'tamsulosin','Flomax',0.4,1,'',2),
('',1,1,'clonazepam','Klonopin',1,1,'',1),
('42858-0118-30',1,2,'lidocaine transdermal patch','lidocaine patch',5,1,'',16);

-- medication_groups Table
CREATE TABLE IF NOT EXISTS medication_groups (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  group_name TEXT,
  active INTEGER DEFAULT 1,
  FOREIGN KEY(person_id) REFERENCES people(id)
);

INSERT INTO medication_groups (person_id, group_name) VALUES
(1, 'morning medications'),
(1, 'afternoon medications'),
(2, 'am medications'),
(2, 'noon medications'),
(2, 'pm medications');

-- medication_medication_group_mapping Table
CREATE TABLE IF NOT EXISTS medication_medication_group_mapping (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  group_id INTEGER,
  medication_id INTEGER,
  FOREIGN KEY(group_id) REFERENCES medication_groups(id),
  FOREIGN KEY(medication_id) REFERENCES medications(id)
);

INSERT INTO medication_medication_group_mapping (group_id, medication_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 4),
(2, 6),
(2, 9),
(3, 10),
(3, 11),
(3, 12),
(4, 13),
(4, 14),
(4, 15);


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
('other');

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
  FOREIGN KEY(status_id) REFERENCES task_status(id),
  FOREIGN KEY(pre_task_id) REFERENCES current_tasks(id),
  FOREIGN KEY(post_task_id) REFERENCES current_tasks(id)
);

CREATE TABLE IF NOT EXISTS tasks (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT,
  [task_name] TEXT,
  [task_description] TEXT,
  [assigned_to_id] INTEGER,
  [due] DATETIME,
  [frequency] TEXT,
  [days_frequency] INTEGER,
  [task_type_id] INTEGER,
  [recurring] INTEGER DEFAULT 0,
  [schedule] TEXT,
  [set_ios_reminder] INTEGER DEFAULT 0,
  [action_on_complete] TEXT,
  FOREIGN KEY([assigned_to_id]) REFERENCES people([id]),
  FOREIGN KEY([task_type_id]) REFERENCES task_types([id])
);

CREATE TABLE IF NOT EXISTS task_views (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  task_id INTEGER,
  person_id INTEGER,
  prime INTEGER DEFAULT 0,
  FOREIGN KEY(task_id) REFERENCES current_tasks(id),
  FOREIGN KEY(person_id) REFERENCES people(id)
);


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