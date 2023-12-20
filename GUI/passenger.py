import tkinter as tk
from tkinter import ttk, messagebox, simpledialog
import pypyodbc as odbc

# Database connection parameters
DRIVER_NAME = 'ODBC Driver 17 for SQL Server'
SERVER_NAME = 'Sanal'
DATABASE_NAME = 'CityTramConveyanceManagementSystem'

# Initialize database connection
def get_db_connection():
    connection_string = f"""
        DRIVER={{{DRIVER_NAME}}};
        SERVER={SERVER_NAME};
        DATABASE={DATABASE_NAME};
        Trusted_Connection=yes;
    """
    return odbc.connect(connection_string)

conn = get_db_connection()
cursor = conn.cursor()

# GUI setup
root = tk.Tk()
root.title("Passenger Table DDL Operations")
root.geometry('800x600')  # Adjust the window size as needed
root.resizable(False, False)  # Disable resizing

# Apply theme and styles
style = ttk.Style(root)
style.theme_use("clam")  # Set a theme for ttk widgets

# Define colors and styles
bg_color = '#f0f0f0'
button_color = '#333333'
text_color = '#ffffff'
highlight_color = '#5fba7d'

style.configure('TButton', background=button_color, foreground=text_color)
style.map('TButton', background=[('active', highlight_color)])
style.configure('Treeview', background=bg_color, fieldbackground=bg_color, foreground='black')
style.map('Treeview', background=[('selected', highlight_color)])
style.configure('Vertical.TScrollbar', background=button_color, troughcolor=bg_color)

# Define Treeview to display data with column names
treeview_frame = ttk.Frame(root)
treeview_frame.pack(pady=10, padx=10, fill='both', expand=True)

treeview = ttk.Treeview(treeview_frame, selectmode='browse')
treeview.pack(side='left', fill='both', expand=True)

# Define the columns
treeview['columns'] = ('Passenger ID', 'Name', 'Address', 'Phone', 'Email', 'DOB', 'Gender', 'Username', 'Password')
treeview.column('#0', width=0, stretch=tk.NO)  # Hides the default first column
treeview.column('Passenger ID', anchor=tk.CENTER, width=80)
treeview.column('Name', anchor=tk.W, width=120)
treeview.column('Address', anchor=tk.W, width=180)
treeview.column('Phone', anchor=tk.W, width=100)
treeview.column('Email', anchor=tk.W, width=180)
treeview.column('DOB', anchor=tk.W, width=100)
treeview.column('Gender', anchor=tk.W, width=80)
treeview.column('Username', anchor=tk.W, width=100)
treeview.column('Password', anchor=tk.W, width=100)

# Create headings
treeview.heading('#0', text='', anchor=tk.CENTER)
treeview.heading('Passenger ID', text='Passenger ID', anchor=tk.CENTER)
treeview.heading('Name', text='Name', anchor=tk.CENTER)
treeview.heading('Address', text='Address', anchor=tk.CENTER)
treeview.heading('Phone', text='Phone', anchor=tk.CENTER)
treeview.heading('Email', text='Email', anchor=tk.CENTER)
treeview.heading('DOB', text='Date of Birth', anchor=tk.CENTER)
treeview.heading('Gender', text='Gender', anchor=tk.CENTER)
treeview.heading('Username', text='Username', anchor=tk.CENTER)
treeview.heading('Password', text='Password', anchor=tk.CENTER)

# Scrollbar for the Treeview
scrollbar = ttk.Scrollbar(treeview_frame, orient=tk.VERTICAL, command=treeview.yview)
scrollbar.pack(side='right', fill='y')
treeview.configure(yscrollcommand=scrollbar.set)

# CRUD functions
def refresh_data(cursor, treeview):
    treeview.delete(*treeview.get_children())
    cursor.execute("SELECT * FROM Passenger")
    for row in cursor.fetchall():
        treeview.insert('', tk.END, values=row)

def add_passenger(cursor, conn, treeview):
    passenger_id = simpledialog.askstring("Input", "Enter the passenger ID:")
    name = simpledialog.askstring("Input", "Enter the passenger name:")
    address = simpledialog.askstring("Input", "Enter the passenger address:")
    phone = simpledialog.askstring("Input", "Enter the passenger phone:")
    email = simpledialog.askstring("Input", "Enter the passenger email:")
    dob = simpledialog.askstring("Input", "Enter the passenger date of birth (YYYY-MM-DD):")
    gender = simpledialog.askstring("Input", "Enter the passenger gender:")
    username = simpledialog.askstring("Input", "Enter the passenger username:")
    password = simpledialog.askstring("Input", "Enter the passenger password:")
    if passenger_id and name and address and phone and email and dob and gender and username and password:
        try:
            cursor.execute("INSERT INTO Passenger (passenger_id, passenger_name, passenger_address, passenger_phone, email, date_of_birth, gender, username, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", (passenger_id, name, address, phone, email, dob, gender, username, password))
            conn.commit()
            refresh_data(cursor, treeview)
        except Exception as e:
            messagebox.showerror("Error", str(e))

def update_passenger(cursor, conn, treeview):
    selected = treeview.selection()
    if selected:
        selected_item = treeview.item(selected[0])['values']
        passenger_id = selected_item[0]  # assuming passenger_id is the first item
        # Ask for new values, providing current ones as defaults
        name = simpledialog.askstring("Input", "Enter the new name:", initialvalue=selected_item[1])
        address = simpledialog.askstring("Input", "Enter the new address:", initialvalue=selected_item[2])
        phone = simpledialog.askstring("Input", "Enter the new phone:", initialvalue=selected_item[3])
        email = simpledialog.askstring("Input", "Enter the new email:", initialvalue=selected_item[4])
        dob = simpledialog.askstring("Input", "Enter the new date of birth (YYYY-MM-DD):", initialvalue=selected_item[5])
        gender = simpledialog.askstring("Input", "Enter the new gender:", initialvalue=selected_item[6])
        username = simpledialog.askstring("Input", "Enter the new username:", initialvalue=selected_item[7])
        password = simpledialog.askstring("Input", "Enter the new password:", initialvalue=selected_item[8])
        if name and address and phone and email and dob and gender and username and password:
            try:
                cursor.execute("UPDATE Passenger SET passenger_name = ?, passenger_address = ?, passenger_phone = ?, email = ?, date_of_birth = ?, gender = ?, username = ?, password = ? WHERE passenger_id = ?", (name, address, phone, email, dob, gender, username, password, passenger_id))
                conn.commit()
                refresh_data(cursor, treeview)
            except Exception as e:
                messagebox.showerror("Error", str(e))

def delete_passenger(cursor, conn, treeview):
    selected = treeview.selection()
    if selected:
        selected_item = treeview.item(selected[0])['values']
        passenger_id = selected_item[0]  # assuming passenger_id is the first item
        try:
            cursor.execute("DELETE FROM Passenger WHERE passenger_id = ?", (passenger_id,))
            conn.commit()
            refresh_data(cursor, treeview)
        except Exception as e:
            messagebox.showerror("Error", str(e))

# Buttons for CRUD operations
button_frame = ttk.Frame(root)
button_frame.pack(pady=10, fill='x')

add_button = ttk.Button(button_frame, text="Add Passenger", command=lambda: add_passenger(cursor, conn, treeview))
update_button = ttk.Button(button_frame, text="Update Selected Passenger", command=lambda: update_passenger(cursor, conn, treeview))
delete_button = ttk.Button(button_frame, text="Delete Selected Passenger", command=lambda: delete_passenger(cursor, conn, treeview))

add_button.pack(side='left', fill='x', expand=True, padx=2)
update_button.pack(side='left', fill='x', expand=True, padx=2)
delete_button.pack(side='left', fill='x', expand=True, padx=2)

# Initial data load
refresh_data(cursor, treeview)

# Start the GUI event loop
root.mainloop()
