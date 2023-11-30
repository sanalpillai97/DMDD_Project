import tkinter as tk
from tkinter import ttk
import subprocess
import sys
import os

# Function to launch the Locality table script
def launch_locality():
    script_path = os.path.join(sys.path[0], 'locality.py')
    subprocess.run(['python', script_path], check=True)

# Function to launch the Route table script
def launch_route():
    script_path = os.path.join(sys.path[0], 'route.py')
    subprocess.run(['python', script_path], check=True)

# Function to launch the Tram table script
def launch_tram():
    script_path = os.path.join(sys.path[0], 'tram.py')
    subprocess.run(['python', script_path], check=True)

# Function to launch the Passenger table script
def launch_passenger():
    script_path = os.path.join(sys.path[0], 'passenger.py')
    subprocess.run(['python', script_path], check=True)

# Main screen GUI setup
root = tk.Tk()
root.title("Tram Network Database Operations")
root.geometry('600x400')  # Set the window size
root.resizable(False, False)  # Disable resizing

# Apply theme and styles from previous code
style = ttk.Style(root)
style.theme_use("clam")

# Define colors and styles
bg_color = '#f0f0f0'
button_color = '#333333'
text_color = '#ffffff'
highlight_color = '#5fba7d'

style.configure('TButton', background=button_color, foreground=text_color)
style.map('TButton', background=[('active', highlight_color)])

# Frame for buttons
button_frame = ttk.Frame(root, padding="30")
button_frame.pack(fill='both', expand=True)

# Button for Locality table
locality_button = ttk.Button(button_frame, text="Modify Locality Table", command=launch_locality)
locality_button.pack(side='top', fill='x', expand=True, pady=10)

# Button for Route table
route_button = ttk.Button(button_frame, text="Modify Route Table", command=launch_route)
route_button.pack(side='top', fill='x', expand=True, pady=10)

# Button for Tram table
tram_button = ttk.Button(button_frame, text="Modify Tram Table", command=launch_tram)
tram_button.pack(side='top', fill='x', expand=True, pady=10)

# Button for Passenger table
passenger_button = ttk.Button(button_frame, text="Modify Passenger Table", command=launch_passenger)
passenger_button.pack(side='top', fill='x', expand=True, pady=10)

# Start the GUI event loop
root.mainloop()