import ui
import csv
import os
import datetime

def submit_action(sender):
    # Get the form data
    systolic = bp_form['systolic_textfield'].text
    diastolic = bp_form['diastolic_textfield'].text
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Append data to a CSV file
    file_path = os.path.join(os.path.expanduser('~'), 'Documents', 'bp_data.csv')
    with open(file_path, 'a', newline='') as file:
        writer = csv.writer(file)
        writer.writerow([timestamp, systolic, diastolic])

    # Optionally, clear the text fields after submission
    bp_form['systolic_textfield'].text = ''
    bp_form['diastolic_textfield'].text = ''

# Create the UI
bp_form = ui.View()
bp_form.name = 'Blood Pressure Form'
bp_form.background_color = 'white'

# Systolic TextField
systolic_textfield = ui.TextField(frame=(10, 10, 200, 40), placeholder='Systolic')
bp_form.add_subview(systolic_textfield)

# Diastolic TextField
diastolic_textfield = ui.TextField(frame=(10, 60, 200, 40), placeholder='Diastolic')
bp_form.add_subview(diastolic_textfield)

# Submit Button
submit_btn = ui.Button(title='Submit')
submit_btn.frame = (10, 110, 200, 40)
submit_btn.action = submit_action
bp_form.add_subview(submit_btn)

# Display the form
bp_form.present('sheet')

