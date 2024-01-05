import sqlite3

def read_sql_file(file_path):
    with open(file_path, 'r') as file:
        return file.read()

sql_commands = read_sql_file('setup_tables.sql')

conn = sqlite3.connect('dragonfruit_data.db')
cursor = conn.cursor()

# Split the commands by semicolon (if multiple statements are present)
commands = sql_commands.split(';')

# Execute each command
for command in commands:
    if command.strip():
        cursor.execute(command)

conn.commit()
conn.close()