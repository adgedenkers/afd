import sqlite3
import json
from datetime import datetime, timedelta

# Database initialization
def init_db():
    conn = sqlite3.connect('family_health_tracker.db')
    cursor = conn.cursor()
    
    # Create table
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS tasks (
            id INTEGER PRIMARY KEY,
            description TEXT NOT NULL,
            recurrence TEXT NOT NULL,
            last_completed DATE,
            special_conditions TEXT,
            status TEXT NOT NULL
        )
    ''')
    conn.commit()
    conn.close()

# Adding a task
def add_task(description, recurrence, special_conditions=None):
    conn = sqlite3.connect('family_health_tracker.db')
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO tasks (description, recurrence, special_conditions, status)
        VALUES (?, ?, ?, ?)
    ''', (description, recurrence, json.dumps(special_conditions) if special_conditions else None, 'pending'))
    conn.commit()
    conn.close()

# Marking a task as complete
def complete_task(task_id):
    conn = sqlite3.connect('family_health_tracker.db')
    cursor = conn.cursor()
    today = datetime.now().date()
    cursor.execute('''
        UPDATE tasks
        SET last_completed = ?, status = 'completed'
        WHERE id = ?
    ''', (today, task_id))
    conn.commit()
    conn.close()

# Flagging incomplete tasks at the end of the day
def flag_incomplete_tasks():
    conn = sqlite3.connect('family_health_tracker.db')
    cursor = conn.cursor()
    cursor.execute('''
        UPDATE tasks
        SET status = 'flagged'
        WHERE status = 'pending'
    ''')
    conn.commit()
    conn.close()

# Generate daily tasks based on recurrence
def generate_daily_tasks():
    conn = sqlite3.connect('family_health_tracker.db')
    cursor = conn.cursor()
    today = datetime.now().date()
    cursor.execute('''
        SELECT id, description, recurrence, last_completed, special_conditions
        FROM tasks
        WHERE status IN ('pending', 'flagged')
    ''')
    tasks = cursor.fetchall()

    for task in tasks:
        task_id, _, recurrence, last_completed, special_conditions = task
        if last_completed:
            last_completed_date = datetime.strptime(last_completed, '%Y-%m-%d').date()
        else:
            last_completed_date = None

        if recurrence == 'daily' or (recurrence == 'weekly' and (not last_completed_date or (today - last_completed_date).days >= 7)):
            # For weekly tasks, check special conditions like illness
            if special_conditions:
                conditions = json.loads(special_conditions)
                if 'illness' in conditions and conditions['illness']:
                    continue  # Skip task if the condition is not met

            cursor.execute('''
                UPDATE tasks
                SET status = 'pending'
                WHERE id = ?
            ''', (task_id,))
    
    conn.commit()
    conn.close()

# Initializing the database
init_db()  # This will create the database and table if they don't exist

# Example usage
# Adding a task
add_task('Take medication', 'weekly')

# Simulate completing a task
complete_task(1)

# Generate daily tasks
generate_daily_tasks()

# Flag incomplete tasks at the end of the day
flag_incomplete_tasks()
