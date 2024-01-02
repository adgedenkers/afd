import ui

# Mapping of names to IDs for easy identification and processing
name_to_id = {'Adriaan': 1, 'Becky': 2, 'Fitz': 3}

def submit_action(sender):
    """
    Function called when the submit button is pressed.
    It retrieves the selected profile, fetches the corresponding ID,
    and prints the entered values along with the profile name and ID.
    """
    # Get the selected profile name from the segmented control
    selected_profile = sender.superview['profile_segmented'].segments[sender.superview['profile_segmented'].selected_index]
    
    # Fetch the corresponding ID from the name_to_id dictionary
    profile_id = name_to_id.get(selected_profile)

    # Retrieve values from all TextField subviews and check if any field is empty
    values = [field.text for field in sender.superview.subviews if isinstance(field, ui.TextField)]
    if any(value == '' for value in values):
        print("Please fill in all fields.")
        return

    # Print the profile details and entered values
    print(f"Vitals for {selected_profile} (ID: {profile_id}): {values}")

def create_form():
    """
    Creates and displays the main form view with various UI elements.
    """
    # Create the main view with basic properties
    main_view = ui.View()
    main_view.name = 'Enter Your Vitals'
    main_view.background_color = 'white'
    main_view.frame = (0, 0, 400, 400)

    # Add a segmented control for selecting the profile
    profile_segmented = ui.SegmentedControl(frame=(10, 10, 380, 40), segments=['Adriaan', 'Becky', 'Fitz'])
    profile_segmented.name = 'profile_segmented'
    main_view.add_subview(profile_segmented)

    # Add a title label to the view
    title_label = ui.Label(frame=(10, 60, 380, 40))
    title_label.text = 'Enter Your Vitals'
    title_label.alignment = ui.ALIGN_CENTER
    main_view.add_subview(title_label)

    # Add a TextField for entering systolic blood pressure
    systolic_field = ui.TextField(frame=(10, 110, 175, 40))
    systolic_field.placeholder = 'Systolic'
    systolic_field.keyboard_type = ui.KEYBOARD_NUMBER_PAD
    main_view.add_subview(systolic_field)

    # Add a label for the slash symbol between systolic and diastolic fields
    slash_label = ui.Label(frame=(190, 110, 20, 40))
    slash_label.text = '/'
    slash_label.alignment = ui.ALIGN_CENTER
    main_view.add_subview(slash_label)

    # Add a TextField for entering diastolic blood pressure
    diastolic_field = ui.TextField(frame=(215, 110, 175, 40))
    diastolic_field.placeholder = 'Diastolic'
    diastolic_field.keyboard_type = ui.KEYBOARD_NUMBER_PAD
    main_view.add_subview(diastolic_field)

    # Add a TextField for entering heart rate
    heart_rate_field = ui.TextField(frame=(10, 160, 380, 40))
    heart_rate_field.placeholder = 'Heart Rate'
    heart_rate_field.keyboard_type = ui.KEYBOARD_NUMBER_PAD
    main_view.add_subview(heart_rate_field)

    # Add a submit button with styling and action binding
    submit_btn = ui.Button(frame=(50, 220, 300, 60))
    submit_btn.title = 'Submit'
    submit_btn.background_color = 'navy'
    submit_btn.tint_color = 'white'
    submit_btn.action = submit_action
    main_view.add_subview(submit_btn)

    # Present the view in fullscreen mode
    main_view.present('fullscreen')

# Create and display the form by calling the function
create_form()
