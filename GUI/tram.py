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
root.title("Tram Table DDL Operations")
root.geometry('600x400')  # Set the window size
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
treeview['columns'] = ('Tram ID', 'Manufacturer', 'Efficiency', 'Capacity', 'Speed')
treeview.column('#0', width=0, stretch=tk.NO)  # Hides the default first column
treeview.column('Tram ID', anchor=tk.CENTER, width=80)
treeview.column('Manufacturer', anchor=tk.W, width=120)
treeview.column('Efficiency', anchor=tk.W, width=120)
treeview.column('Capacity', anchor=tk.W, width=80)
treeview.column('Speed', anchor=tk.W, width=80)

# Create headings
treeview.heading('#0', text='', anchor=tk.CENTER)
treeview.heading('Tram ID', text='Tram ID', anchor=tk.CENTER)
treeview.heading('Manufacturer', text='Manufacturer', anchor=tk.CENTER)
treeview.heading('Efficiency', text='Efficiency', anchor=tk.CENTER)
treeview.heading('Capacity', text='Capacity', anchor=tk.CENTER)
treeview.heading('Speed', text='Speed', anchor=tk.CENTER)

# Scrollbar for the Treeview
scrollbar = ttk.Scrollbar(treeview_frame, orient=tk.VERTICAL, command=treeview.yview)
scrollbar.pack(side='right', fill='y')
treeview.configure(yscrollcommand=scrollbar.set)

# Refresh the Treeview data
def refresh_data(cursor, treeview):
    treeview.delete(*treeview.get_children())
    cursor.execute("SELECT * FROM Tram")
    for row in cursor.fetchall():
        treeview.insert('', tk.END, values=row)  # Inserting data row-wise

# Add a new tram
def add_tram(cursor, conn, treeview):
    tram_id = simpledialog.askstring("Input", "Enter the tram ID:")
    manufacturer = simpledialog.askstring("Input", "Enter the manufacturer name:")
    efficiency = simpledialog.askstring("Input", "Enter the energy efficiency:")
    capacity = simpledialog.askstring("Input", "Enter the seating capacity:")
    speed = simpledialog.askstring("Input", "Enter the maximum speed:")
    if tram_id and manufacturer and efficiency and capacity and speed:
        try:
            cursor.execute("INSERT INTO Tram (tram_id, manufacturer, energy_efficiency, seating_capacity, maximum_speed) VALUES (?, ?, ?, ?, ?)", 
                           (tram_id, manufacturer, efficiency, capacity, speed))
            conn.commit()
            refresh_data(cursor, treeview)
        except Exception as e:
            messagebox.showerror("Error", str(e))

# Function to update a tram
def update_tram(cursor, conn, treeview):
    selected = treeview.selection()
    if selected:
        selected_item = treeview.item(selected[0])['values']
        tram_id = selected_item[0]
        manufacturer = simpledialog.askstring("Input", "Enter the new manufacturer name:", initialvalue=selected_item[1])
        efficiency = simpledialog.askstring("Input", "Enter the new energy efficiency:", initialvalue=selected_item[2])
        capacity = simpledialog.askstring("Input", "Enter the new seating capacity:", initialvalue=selected_item[3])
        speed = simpledialog.askstring("Input", "Enter the new maximum speed:", initialvalue=selected_item[4])
        if manufacturer and efficiency and capacity and speed:
            try:
                cursor.execute("UPDATE Tram SET manufacturer = ?, energy_efficiency = ?, seating_capacity = ?, maximum_speed = ? WHERE tram_id = ?",
                               (manufacturer, efficiency, capacity, speed, tram_id))
                conn.commit()
                refresh_data(cursor, treeview)
            except Exception as e:
                messagebox.showerror("Error", str(e))

# Function to delete a tram
def delete_tram(cursor, conn, treeview):
    selected = treeview.selection()
    if selected:
        selected_item = treeview.item(selected[0])['values']
        tram_id = selected_item[0]
        try:
            cursor.execute("DELETE FROM Tram WHERE tram_id = ?", (tram_id,))
            conn.commit()
            refresh_data(cursor, treeview)
        except Exception as e:
            messagebox.showerror("Error", str(e))

# Buttons for CRUD operations
button_frame = ttk.Frame(root)
button_frame.pack(pady=10, fill='x')

add_button = ttk.Button(button_frame, text="Add Tram", command=lambda: add_tram(cursor, conn, treeview))
update_button = ttk.Button(button_frame, text="Update Selected Tram", command=lambda: update_tram(cursor, conn, treeview))
delete_button = ttk.Button(button_frame, text="Delete Selected Tram", command=lambda: delete_tram(cursor, conn, treeview))

add_button.pack(side='left', fill='x', expand=True, padx=2)
update_button.pack(side='left', fill='x', expand=True, padx=2)
delete_button.pack(side='left', fill='x', expand=True, padx=2)

# Initial data load
refresh_data(cursor, treeview)

# Start the GUI event loop
root.mainloop()
