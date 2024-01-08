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
  [id] INTEGER PRIMARY KEY AUTOINCREMENT,
  [user_name] TEXT NOT NULL UNIQUE,
  [name_prefix] TEXT,
  [first_name] TEXT NOT NULL,
  [middle_name] TEXT,
  [last_name] TEXT NOT NULL,
  [name_suffix] TEXT,
  [dob] TEXT,
  [user_password] TEXT,
  [email] TEXT NOT NULL,
  [phone] TEXT,
  [address_id] INTEGER,
  [born_in_county] TEXT,
  [born_in_state] TEXT,
  [born_in_country] TEXT,
  [created_at] TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')) NOT NULL
);

-- Insert Statements for people
INSERT INTO people ([user_name], [name_prefix], [first_name], [middle_name], [last_name], [dob], [email], [phone], [born_in_county], [born_in_state], [born_in_country], [created_at]), VALUES
  ('Adge', 'Mr.', 'Adriaan', 'Harold', 'Denkers', '1977-11-22T08:45:22-0500', 'adge.denkers@gmail.com', '607-226-0710', 'Albany', 'New York', 'United States', GETDATE()),
  ('Becky', 'Mrs.', 'Rebecca', 'Lydia', 'Denkers', '1978-08-19T14:02:33-0400', 'rebecca.denkers@gmail.com', '607-316-2604', '304 Cosen Road', 'Oxford', 'NY', '13830', 'United States', 'Chenango', 'New York', 'United States', GETDATE()),
  ('Fitz', 'Mr.', 'Adriaan', 'Fitzgerald', 'Denkers', '2010-09-08T14:39:11-0400', 'bonniegamer0812@gmail.com', '607-226-3077', '304 Cosen Road', 'Oxford', 'NY', '13830', 'United States', 'Schenectady', 'New York', 'United States', GETDATE());



CREATE TABLE IF NOT EXISTS addresses (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT,
  [address] TEXT,
  [city] TEXT,
  [state] TEXT,
  [zip] TEXT,
  [country] TEXT,
);

INSERT INTO addresses ([address_id], [city], [state], [zip], [country]) VALUES ()
('304 Cosen Road', 'Oxford', 'NY', '13830', 'United States');

CREATE TABLE IF NOT EXISTS people_address_mapping (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT,
  [person_id] INTEGER,
  [address_id] INTEGER,
  FOREIGN KEY([person_id]) REFERENCES people([id]),
  FOREIGN KEY([address_id]) REFERENCES addresses([id])
);

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
  url TEXT
);

CREATE TABLE IF NOT EXISTS condition_person_mapping (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  condition_id INTEGER,
  FOREIGN KEY(person_id) REFERENCES people(id),
  FOREIGN KEY(condition_id) REFERENCES conditions(id)
);

-- Symptoms Table
-- Symptoms are the effects felt by the person, for a given condition
CREATE TABLE IF NOT EXISTS symptoms (
    [id] INTEGER PRIMARY KEY AUTOINCREMENT,
    [symptom] TEXT,
    [description] TEXT,
    [reference_url] TEXT
);

-- Condition Symptom Mapping Table
-- This table maps symptoms to conditions
CREATE TABLE IF NOT EXISTS condition_symptom_mapping (
    [id] INTEGER PRIMARY KEY AUTOINCREMENT,
    [condition_id] INTEGER,
    [symptom_id] INTEGER,
);


CREATE TABLE IF NOT EXISTS effects (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  description TEXT,
  url TEXT
);

INSERT INTO effects (name, description, url) VALUES
('nausea', 'Nausea is a feeling of sickness with an inclination to vomit.', 'https://en.wikipedia.org/wiki/Nausea'),
('vomiting', 'Vomiting is the involuntary, forceful expulsion of the contents of one''s stomach through the mouth and sometimes the nose.', 'https://en.wikipedia.org/wiki/Vomiting'),
('diarrhea', 'Diarrhea is the condition of having at least three loose, liquid, or watery bowel movements each day.', 'https://en.wikipedia.org/wiki/Diarrhea'),
('constipation', 'Constipation refers to bowel movements that are infrequent or hard to pass.', 'https://en.wikipedia.org/wiki/Constipation'),
('headache', 'A headache is pain in the head or upper neck.', 'https://en.wikipedia.org/wiki/Headache'),
('dizziness', 'Dizziness is an impairment in spatial perception and stability.', 'https://en.wikipedia.org/wiki/Dizziness'),
('fatigue', 'Fatigue is a subjective feeling of tiredness that has a gradual onset.', 'https://en.wikipedia.org/wiki/Fatigue_(medical)'),
('insomnia', 'Insomnia, also known as sleeplessness, is a sleep disorder in which people have trouble sleeping.', 'https://en.wikipedia.org/wiki/Insomnia'),
('anxiety', 'Anxiety is an emotion characterized by an unpleasant state of inner turmoil, often accompanied by nervous behavior.', 'https://en.wikipedia.org/wiki/Anxiety'),
('depression', 'Depression is a state of low mood and aversion to activity that can affect a person''s thoughts, behavior, feelings, and sense of well-being.', 'https://en.wikipedia.org/wiki/Depression_(mood)'),
('irritability', 'Irritability is an excessive response to stimuli.', 'https://en.wikipedia.org/wiki/Irritability'),
('mood swings', 'A mood swing is an extreme or rapid change in mood.', 'https://en.wikipedia.org/wiki/Mood_swing'),
('weight gain', 'Weight gain is an increase in body weight.', 'https://en.wikipedia.org/wiki/Weight_gain'),
('weight loss', 'Weight loss, in the context of medicine, health, or physical fitness, refers to a reduction of the total body mass, due to a mean loss of fluid, body fat or adipose tissue or lean mass, namely bone mineral deposits, muscle, tendon, and other connective tissue.', 'https://en.wikipedia.org/wiki/Weight_loss'),
('loss of appetite', 'Anorexia is the decreased sensation of appetite.', 'https://en.wikipedia.org/wiki/Anorexia_(symptom)'),
('loss of taste', 'Ageusia is the loss of taste functions of the tongue, particularly the inability to detect sweetness, sourness, bitterness, saltiness, and umami.', 'https://en.wikipedia.org/wiki/Ageusia'),
('loss of smell', 'Anosmia is the inability to perceive odor or a lack of functioning olfaction—the loss of the sense of smell.', 'https://en.wikipedia.org/wiki/Anosmia'),
('loss of libido', 'Hypoactive sexual desire disorder or inhibited sexual desire (ISD) is considered a sexual dysfunction and is characterized as a lack or absence of sexual fantasies and desire for sexual activity, as judged by a clinician.', 'https://en.wikipedia.org/wiki/Hypoactive_sexual_desire_disorder'),
('loss of memory', 'Amnesia is a deficit in memory caused by brain damage or disease, but it can also be caused temporarily by the use of various sedatives and hypnotic drugs.', 'https://en.wikipedia.org/wiki/Amnesia'),
('loss of concentration', 'Attention deficit hyperactivity disorder (ADHD) is a mental disorder of the neurodevelopmental type.', 'https://en.wikipedia.org/wiki/Attention_deficit_hyperactivity_disorder'),
('loss of coordination', 'Ataxia is a neurological sign consisting of lack of voluntary coordination of muscle movements that can include gait abnormality, speech changes, and abnormalities in eye movements.', 'https://en.wikipedia.org/wiki/Ataxia'),
('loss of balance', 'Disequilibrium is a loss of balance or equilibrium.', 'https://en.wikipedia.org/wiki/Disequilibrium'),
('loss of motor skills', 'Motor skills are movements and actions of the muscles.', 'https://en.wikipedia.org/wiki/Motor_skills');

-- Person Symptom Mapping Table
CREATE TABLE IF NOT EXISTS person_symptom_mapping (
    [id] INTEGER PRIMARY KEY AUTOINCREMENT,
    [person_id] INTEGER,
    [symptom_id] INTEGER,
    [severity] TEXT,
    [frequency] TEXT,
    [duration] TEXT,
    [notes] TEXT,
    FOREIGN KEY (person_id) REFERENCES people(id),
    FOREIGN KEY (symptom_id) REFERENCES symptoms(id)
);

CREATE TABLE IF NOT EXISTS condition_person_mapping
(
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    person_id    INTEGER,
    condition_id INTEGER,
    FOREIGN KEY (person_id) REFERENCES people (id),
    FOREIGN KEY (condition_id) REFERENCES conditions (id)
);

CREATE TABLE IF NOT EXISTS allergies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  description TEXT,
  symptoms TEXT,
  treatment TEXT,
  severity TEXT
);

CREATE TABLE IF NOT EXISTS allergy_person_mapping (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_id INTEGER,
  allergy_id INTEGER,
  FOREIGN KEY(person_id) REFERENCES people(id),
  FOREIGN KEY(allergy_id) REFERENCES allergies(id)
);

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



prescribed_to_id	ndc	brand_name	generic_name	dosage	dosage_units_id	release
1		Prilosec	omeprazole	40	1	
1		Wellbutrin	bupropion	300	1	ER
1		Vyvanse	lisdexamfetamine	60	1	
1		Effexor	venlafaxine	150	1	XR
1		Flomax	tamsulosin	0.4	1	
1		Klonopin	clonazepam	1	1	
2	42858-0118-30	lidocaine patch	lidocaine transdermal patch	5	1	



-- medications Table
CREATE TABLE IF NOT EXISTS medications (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ndc TEXT,
  prescription BOOLEAN DEFAULT 1,
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
