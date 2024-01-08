import sqlite3
import os

def setup_database():
    # Path to the database file
    db_path = os.path.join(os.path.expanduser('~'), 'Dragonfruit', 'dragonfruit.db')

    # Connect to the SQLite database. It will create the database file if it doesn't exist.
    conn = sqlite3.connect(db_path)

    # Create the 'people' table
    c = conn.cursor()
    c.execute("setup_tables.sql")

    # Insert initial data if the table is empty
    c.execute("SELECT COUNT(*) FROM people")
    if c.fetchone()[0] == 0:
        c.execute("INSERT INTO people (name) VALUES ('Adge')")
        c.execute("INSERT INTO people (name) VALUES ('Becky')")
        c.execute("INSERT INTO people (name) VALUES ('Fitz')")
        conn.commit()

    return conn

db_conn = setup_database()
