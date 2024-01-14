import ui
import sqlite3
import datetime

class DragonDataApp(ui.View):
    def __init__(self):
        self.name_to_id = {'Adge': 1, 'Becky': 2, 'Fitz': 3}
        self.db_path = 'dragonfruit_data.db'
        self.setup_ui()

    def setup_ui(self):
        self.name = 'Enter Your Vitals'
        self.background_color = 'white'
        self.frame = (0, 0, 400, 400)

        self.profile_segmented = ui.SegmentedControl(frame=(10, 10, 380, 40), segments=list(self.name_to_id.keys()))
        self.add_subview(self.profile_segmented)

        self.systolic_field = self.create_text_field('Systolic', (10, 110, 175, 40))
        self.diastolic_field = self.create_text_field('Diastolic', (215, 110, 175, 40))
        self.heart_rate_field = self.create_text_field('Heart Rate', (10, 160, 380, 40))

        submit_btn = ui.Button(frame=(50, 220, 300, 60), title='Submit', action=self.submit_action)
        submit_btn.background_color = 'navy'
        submit_btn.tint_color = 'white'
        self.add_subview(submit_btn)

        self.present('fullscreen')

    def create_text_field(self, placeholder, frame):
        text_field = ui.TextField(frame=frame, placeholder=placeholder)
        text_field.keyboard_type = ui.KEYBOARD_NUMBER_PAD
        self.add_subview(text_field)
        return text_field

    def submit_action(self, sender):
        selected_profile = self.profile_segmented.segments[self.profile_segmented.selected_index]
        profile_id = self.name_to_id.get(selected_profile)

        systolic = self.systolic_field.text
        diastolic = self.diastolic_field.text
        pulse = self.heart_rate_field.text

        if any(value == '' for value in [systolic, diastolic, pulse]):
            print("Please fill in all fields.")
            return

        self.insert_bp_data(profile_id, systolic, diastolic, pulse)
        print(f"Vitals for {selected_profile} (ID: {profile_id}) submitted successfully.")

    def insert_bp_data(self, person_id, systolic, diastolic, pulse, notes=''):
        with sqlite3.connect(self.db_path) as conn:
            query = '''INSERT INTO medical__bp (person_id, systolic, diastolic, pulse, notes, taken_at)
                       VALUES (?, ?, ?, ?, ?, ?)'''
            taken_at = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            conn.execute(query, (person_id, systolic, diastolic, pulse, notes, taken_at))

if __name__ == '__main__':
    DragonDataApp()
