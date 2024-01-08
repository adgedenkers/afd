'''
File:      main.py
Project:   pythonista
Created:   2024-01-08
Author:    Adge Denkers
           https://github.com/adgedenkers/
License:   MIT License
'''


import ui
import time

class MyApp(ui.View):
    def __init__(self):
        self.background_color = 'white'
        self.present('fullscreen', hide_title_bar=True)
        self.show_splash_screen()
    
    def show_splash_screen(self):
        splash = ui.View(frame=self.bounds)
        splash.background_color = 'lightblue'
        label = ui.Label(frame=splash.bounds)
        label.text = 'Welcome to DragonData!'
        label.alignment = ui.ALIGN_CENTER
        label.font = ('<system-bold>', 20)
        splash.add_subview(label)
        self.add_subview(splash)
        ui.delay(lambda: self.show_dashboard_screen(splash), 2)  # 2 seconds splash screen

    def show_dashboard_screen(self, splash_view):
        splash_view.remove_from_superview()
        self.setup_dashboard()

    def setup_dashboard(self):
        # Dropdown Menu
        dropdown = ui.ButtonItem()
        dropdown.title = 'Options'
        dropdown.action = self.dropdown_action
        self.right_button_items = [dropdown]
        
        # Buttons at the bottom
        button_width, button_height = 100, 40
        btn1 = ui.Button(title='Button 1', frame=(self.width/2 - 110, self.height - 60, button_width, button_height))
        btn2 = ui.Button(title='Button 2', frame=(self.width/2 + 10, self.height - 60, button_width, button_height))
        btn1.action = self.button_action
        btn2.action = self.button_action
        self.add_subview(btn1)
        self.add_subview(btn2)

    def dropdown_action(self, sender):
        # Implement dropdown actions
        pass

    def button_action(self, sender):
        # Implement button actions
        pass

if __name__ == '__main__':
    app = MyApp()
